// This code is based on an idea from dart_code_metrics package see
// https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/prefer_first/prefer_first_rule.dart.

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template first_getter}
/// A rule that suggests using the `first` property instead of accessing
/// the first element of a list-like object using index 0.
/// {@endtemplate}
@staticLoggerEnforcement
class FirstGetterRule extends LintRule<FirstGetterRule> {
  /// {@macro first_getter}
  FirstGetterRule() : super(.firstGetter, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'FirstGetterRule',
  );

  @override
  Visitor<FirstGetterRule, void> visitorFor(RuleContext context) =>
      _PreferFirstVisitor(this, context);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = visitorFor(context);
    registry
      ..addIndexExpression(this, visitor)
      ..addMethodInvocation(this, visitor);
  }
}

class _PreferFirstVisitor extends BaseVisitor<FirstGetterRule> {
  _PreferFirstVisitor(super.rule, super.context);

  @override
  void visitIndexExpression(IndexExpression node) {
    logger.info('visitIndexExpression() started');
    var target = node.target;
    var type = target?.staticType;
    logger.finer('Resolved target type: ${type?.getDisplayString() ?? 'null'}');
    var element = type?.element;
    if (element == null) {
      logger.finer('Target element is null — skipping');
      super.visitIndexExpression(node);
      return;
    }
    if (_elementDoesntContainFirst(element)) {
      logger.finer('Element does not contain `first` — skipping');
      super.visitIndexExpression(node);
      return;
    }
    var expression = node.index;
    if (expression case IntegerLiteral(:var value) when value == 0) {
      var offset = node.leftBracket.offset;
      var endOffset = node.rightBracket.end;
      logger.fine('Suggest using `.first` instead of [0] at offset $offset');
      rule.reportAtOffset(offset, endOffset - offset);
    }
    super.visitIndexExpression(node);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    logger.info('visitMethodInvocation() started: ${node.methodName.name}');
    var target = node.target;
    if (target is! SimpleIdentifier) {
      logger.finer('Target is not SimpleIdentifier — skipping');
      super.visitMethodInvocation(node);
      return;
    }
    var targetElement = target.element;
    var targetTypeElement = target.staticType?.element;
    logger.finer(
      'Target element: ${targetElement?.name ?? 'null'}, target type element: '
      '${targetTypeElement?.name ?? 'null'}',
    );
    if (targetTypeElement == null || targetElement == null) {
      logger.finer('Missing target/type element — skipping');
      super.visitMethodInvocation(node);
      return;
    }
    if (_elementDoesntContainFirst(targetTypeElement)) {
      logger.finer('Target type does not contain `first` — skipping');
      super.visitMethodInvocation(node);
      return;
    }
    if (!_methodIsIterableElementAt(node)) {
      logger.finer('Method is not iterable.elementAt(...) — skipping');
      super.visitMethodInvocation(node);
      return;
    }
    var expression = node.argumentList.arguments.first;
    if (expression case IntegerLiteral(:var value) when value == 0) {
      logger.fine(
        'Suggest using `.first` instead of `elementAt(0)` at '
        '${node.argumentList.offset}',
      );
      rule.reportAtNode(node.argumentList);
    }
    super.visitMethodInvocation(node);
  }

  bool _elementDoesntContainFirst(Element element) {
    var contains =
        element is InterfaceElement &&
        element.interfaceMembers.entries
            .map((entry) => entry.key.name)
            .contains('first');
    logger.finer('_elementDoesntContainFirst(${element.name}) -> ${!contains}');
    return !contains;
  }

  bool _methodIsIterableElementAt(MethodInvocation node) {
    logger.finer(
      '_methodIsIterableElementAt() started for ${node.methodName.name}',
    );
    var element = node.methodName.element;
    if (element == null) {
      logger.finer('Method element is null -> false');
      return false;
    }
    var typeElement = element.enclosingElement;
    if (typeElement is! InterfaceElement) {
      logger.finer('Enclosing element is not InterfaceElement -> false');
      return false;
    }
    var isIterable = typeSystem.isAssignableTo(
      typeElement.thisType,
      typeProvider.iterableDynamicType,
    );
    logger.finer('Is enclosing element iterable: $isIterable');
    if (!isIterable) {
      return false;
    }
    var isElementAt = node.methodName.name == 'elementAt';
    logger.finer('Method name is elementAt: $isElementAt');
    return isElementAt;
  }
}
