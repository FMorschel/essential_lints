// This code is based on an idea from dart_code_metrics package see
// https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/prefer_last/prefer_last_rule.dart.

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import '../utils/extensions/ast.dart';
import 'rule.dart';

/// {@template last_getter}
/// A rule that suggests using `last` property instead of accessing
/// the last element of a list-like object using length - 1 index.
/// {@endtemplate}
class LastGetterRule extends LintRule {
  /// {@macro last_getter}
  LastGetterRule() : super(.lastGetter);

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

  final LastGetterRule rule;

  final RuleContext context;

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

  bool _elementDoesntContainLast(Element element) {
    return element is! InterfaceElement ||
        !element.interfaceMembers.entries
            .map((entry) => entry.key.name)
            .contains('last');
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
}
