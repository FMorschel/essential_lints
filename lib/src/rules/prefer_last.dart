import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'rule.dart';

/// {@template prefer_last}
/// A rule that suggests using `last` property instead of accessing
/// the last element of a list-like object using length - 1 index.
/// {@endtemplate}
class PreferLastRule extends Rule {
  /// {@macro prefer_last}
  PreferLastRule() : super(.preferLast);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _PreferLastVisitor(this, context);
    registry
      ..addIndexExpression(this, visitor)
      ..addMethodInvocation(this, visitor);
  }
}

class _PreferLastVisitor extends SimpleAstVisitor<void> {
  _PreferLastVisitor(this.rule, this.context);

  final PreferLastRule rule;

  final RuleContext context;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    var target = node.target;
    if (target is! SimpleIdentifier) {
      super.visitMethodInvocation(node);
      return;
    }
    var targetElement = target.element;
    var targetTypeElement = target.staticType?.element;
    if (targetTypeElement == null || targetElement == null) {
      super.visitMethodInvocation(node);
      return;
    }
    if (_elementDoesntContainLast(targetTypeElement)) {
      super.visitMethodInvocation(node);
      return;
    }
    if (!_methodIsIterableElementAt(node)) {
      super.visitMethodInvocation(node);
      return;
    }
    var expression = node.argumentList.arguments.first;
    var offset = node.methodName.offset;
    var endOffset = node.methodName.end;
    _reportWhenLengthMinusOne(
      expression,
      targetElement,
      targetTypeElement,
      offset,
      endOffset,
    );
    super.visitMethodInvocation(node);
  }

  @override
  void visitIndexExpression(IndexExpression node) {
    var target = node.target;
    DartType? type;
    Element? targetElement;

    if (target
        case SimpleIdentifier(:var staticType, :var element) ||
            ThisExpression(
              :var staticType,
              enclosingTypeElement: Element? element,
            )) {
      targetElement = element;
      type = staticType;
    }
    var element = type?.element;
    if (element == null || targetElement == null) {
      super.visitIndexExpression(node);
      return;
    }
    if (_elementDoesntContainLast(element)) {
      super.visitIndexExpression(node);
      return;
    }
    var expression = node.index;
    var offset = node.leftBracket.offset;
    var endOffset = node.rightBracket.end;
    _reportWhenLengthMinusOne(
      expression,
      targetElement,
      element,
      offset,
      endOffset,
    );
    super.visitIndexExpression(node);
  }

  bool _elementDoesntContainLast(Element element) {
    return element is! InterfaceElement ||
        !element.interfaceMembers.entries
            .map((entry) => entry.key.name)
            .contains('last');
  }

  void _reportWhenLengthMinusOne(
    Expression expression,
    Element targetElement,
    Element targetTypeElement,
    int offset,
    int endOffset,
  ) {
    if (expression case BinaryExpression(
      :var operator,
      :Expression leftOperand,
      :IntegerLiteral rightOperand,
    ) when operator.type == TokenType.MINUS && rightOperand.value == 1) {
      switch (leftOperand) {
        case PrefixedIdentifier(
              identifier: SimpleIdentifier(name: 'length'),
              prefix: SimpleIdentifier(:var staticType, :var element),
            )
            when staticType?.element == targetTypeElement &&
                targetElement == element:
          rule.reportAtOffset(offset, endOffset - offset);
        case SimpleIdentifier(
              name: 'length',
              element: GetterElement() || FieldElement(),
              :var enclosingTypeElement,
            )
            when enclosingTypeElement == targetTypeElement &&
                targetElement == enclosingTypeElement:
          rule.reportAtOffset(offset, endOffset - offset);
      }
    }
  }

  bool _methodIsIterableElementAt(MethodInvocation node) {
    var element = node.methodName.element;
    if (element == null) {
      return false;
    }
    var typeElement = element.enclosingElement;
    if (typeElement is! InterfaceElement) {
      return false;
    }
    var isIterable = context.typeSystem.isAssignableTo(
      typeElement.thisType,
      context.typeProvider.iterableDynamicType,
    );
    if (!isIterable) {
      return false;
    }
    if (node.methodName.name != 'elementAt') {
      return false;
    }
    return true;
  }
}

extension on AstNode {
  InterfaceElement get enclosingTypeElement {
    for (final ancestor in withAncestors) {
      switch (ancestor) {
        case ClassDeclaration(
          declaredFragment: InterfaceFragment(:var element),
        ):
          return element;
        case ExtensionDeclaration(
          declaredFragment: ExtensionFragment(:var element),
        ):
          var extendedElement = element.extendedType.element
              .whenTypeOrNull<InterfaceElement>();
          if (extendedElement != null) {
            return extendedElement;
          }
        case ExtensionTypeDeclaration(
          declaredFragment: InterfaceFragment(:var element),
        ):
          return element;
        case EnumDeclaration(declaredFragment: InterfaceFragment(:var element)):
          return element;
        case MixinDeclaration(
          declaredFragment: InterfaceFragment(:var element),
        ):
          return element;
      }
    }
    throw StateError('No enclosing type element found.');
  }

  Iterable<AstNode> get withAncestors sync* {
    AstNode? current = this;
    while (current != null) {
      yield current;
      current = current.parent;
    }
  }
}

extension on Element? {
  T? whenTypeOrNull<T>() => this is T ? this as T : null;
}
