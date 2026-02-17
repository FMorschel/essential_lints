// This code is based on an idea from dart_code_metrics package see
// https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/prefer_first/prefer_first_rule.dart.

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template first_getter}
/// A rule that suggests using the `first` property instead of accessing
/// the first element of a list-like object using index 0.
/// {@endtemplate}
@staticLoggerEnforcement
class FirstGetterRule extends LintRule {
  /// {@macro first_getter}
  FirstGetterRule() : super(.firstGetter, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'FirstGetterRule',
  );

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
    rule.logger.info('visitIndexExpression() started');
    var target = node.target;
    var type = target?.staticType;
    rule.logger.finer(
      'Resolved target type: ${type?.getDisplayString() ?? 'null'}',
    );
    var element = type?.element;
    if (element == null) {
      rule.logger.finer('Target element is null — skipping');
      super.visitIndexExpression(node);
      return;
    }
    if (_elementDoesntContainFirst(element)) {
      rule.logger.finer('Element does not contain `first` — skipping');
      super.visitIndexExpression(node);
      return;
    }
    var expression = node.index;
    if (expression case IntegerLiteral(:var value) when value == 0) {
      var offset = node.leftBracket.offset;
      var endOffset = node.rightBracket.end;
      rule.logger.fine(
        'Suggest using `.first` instead of [0] at offset $offset',
      );
      rule.reportAtOffset(offset, endOffset - offset);
    }
    super.visitIndexExpression(node);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    rule.logger.info(
      'visitMethodInvocation() started: ${node.methodName.name}',
    );
    var target = node.target;
    if (target is! SimpleIdentifier) {
      rule.logger.finer('Target is not SimpleIdentifier — skipping');
      super.visitMethodInvocation(node);
      return;
    }
    var targetElement = target.element;
    var targetTypeElement = target.staticType?.element;
    rule.logger.finer(
      'Target element: ${targetElement?.name ?? 'null'}, target type element: '
      '${targetTypeElement?.name ?? 'null'}',
    );
    if (targetTypeElement == null || targetElement == null) {
      rule.logger.finer('Missing target/type element — skipping');
      super.visitMethodInvocation(node);
      return;
    }
    if (_elementDoesntContainFirst(targetTypeElement)) {
      rule.logger.finer('Target type does not contain `first` — skipping');
      super.visitMethodInvocation(node);
      return;
    }
    if (!_methodIsIterableElementAt(node)) {
      rule.logger.finer('Method is not iterable.elementAt(...) — skipping');
      super.visitMethodInvocation(node);
      return;
    }
    var expression = node.argumentList.arguments.first;
    if (expression case IntegerLiteral(:var value) when value == 0) {
      rule.logger.fine(
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
    rule.logger.finer(
      '_elementDoesntContainFirst(${element.name}) -> ${!contains}',
    );
    return !contains;
  }

  bool _methodIsIterableElementAt(MethodInvocation node) {
    rule.logger.finer(
      '_methodIsIterableElementAt() started for ${node.methodName.name}',
    );
    var element = node.methodName.element;
    if (element == null) {
      rule.logger.finer('Method element is null -> false');
      return false;
    }
    var typeElement = element.enclosingElement;
    if (typeElement is! InterfaceElement) {
      rule.logger.finer('Enclosing element is not InterfaceElement -> false');
      return false;
    }
    var isIterable = context.typeSystem.isAssignableTo(
      typeElement.thisType,
      context.typeProvider.iterableDynamicType,
    );
    rule.logger.finer('Is enclosing element iterable: $isIterable');
    if (!isIterable) {
      return false;
    }
    var isElementAt = node.methodName.name == 'elementAt';
    rule.logger.finer('Method name is elementAt: $isElementAt');
    return isElementAt;
  }
}
