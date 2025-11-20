// This code is based on the an idea from dart_code_metrics package see
// https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/prefer_first/prefer_first_rule.dart.

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import '../utils/extensions/ast.dart';
import 'rule.dart';

/// {@template first_getter}
/// A rule that suggests using the `first` property instead of accessing
/// the first element of a list-like object using index 0.
/// {@endtemplate}
class FirstGetterRule extends LintRule {
  /// {@macro first_getter}
  FirstGetterRule() : super(.firstGetter);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _PreferFirstVisitor(this, context);
    registry
      ..addIndexExpression(this, visitor)
      ..addMethodInvocation(this, visitor);
  }
}

class _PreferFirstVisitor extends SimpleAstVisitor<void> {
  _PreferFirstVisitor(this.rule, this.context);

  final FirstGetterRule rule;

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
    if (_elementDoesntContainFirst(element)) {
      super.visitIndexExpression(node);
      return;
    }
    var expression = node.index;
    if (expression case IntegerLiteral(:var value) when value == 0) {
      var offset = node.leftBracket.offset;
      var endOffset = node.rightBracket.end;
      rule.reportAtOffset(offset, endOffset - offset);
    }
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
    if (_elementDoesntContainFirst(targetTypeElement)) {
      super.visitMethodInvocation(node);
      return;
    }
    if (!_methodIsIterableElementAt(node)) {
      super.visitMethodInvocation(node);
      return;
    }
    var expression = node.argumentList.arguments.first;
    if (expression case IntegerLiteral(:var value) when value == 0) {
      rule.reportAtNode(node.argumentList);
    }
    super.visitMethodInvocation(node);
  }

  bool _elementDoesntContainFirst(Element element) {
    return element is! InterfaceElement ||
        !element.interfaceMembers.entries
            .map((entry) => entry.key.name)
            .contains('first');
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
