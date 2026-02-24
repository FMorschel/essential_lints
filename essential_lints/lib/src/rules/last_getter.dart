// This code is based on an idea from dart_code_metrics package see
// https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/prefer_last/prefer_last_rule.dart.

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import '../utils/extensions/ast.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template last_getter}
/// A rule that suggests using `last` property instead of accessing
/// the last element of a list-like object using length - 1 index.
/// {@endtemplate}
@staticLoggerEnforcement
class LastGetterRule extends LintRule<LastGetterRule> {
  /// {@macro last_getter}
  LastGetterRule() : super(.lastGetter, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'LastGetterRule',
  );

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

class _PreferLastVisitor extends BaseVisitor<LastGetterRule> {
  _PreferLastVisitor(super.rule, super.context);

  @override
  void visitIndexExpression(IndexExpression node) {
    logger.info('visitIndexExpression() started');
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
    logger.finer(
      'Resolved targetElement: ${targetElement?.name ?? 'null'}, element type: '
      '${type?.getDisplayString() ?? 'null'}',
    );
    if (element == null || targetElement == null) {
      logger.finer('Missing element or targetElement — skipping');
      super.visitIndexExpression(node);
      return;
    }
    if (_elementDoesntContainLast(element)) {
      logger.finer('Element does not contain `last` — skipping');
      super.visitIndexExpression(node);
      return;
    }
    var expression = node.index;
    var offset = node.leftBracket.offset;
    var endOffset = node.rightBracket.end;
    logger.finer('Checking index expression for length - 1 pattern');
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
      'Resolved targetElement: ${targetElement?.name ?? 'null'}, '
      'targetTypeElement: ${targetTypeElement?.name ?? 'null'}',
    );
    if (targetTypeElement == null || targetElement == null) {
      logger.finer('Missing target/type element — skipping');
      super.visitMethodInvocation(node);
      return;
    }
    if (_elementDoesntContainLast(targetTypeElement)) {
      logger.finer('Target type does not contain `last` — skipping');
      super.visitMethodInvocation(node);
      return;
    }
    if (!_methodIsIterableElementAt(node)) {
      logger.finer('Method is not iterable.elementAt(...) — skipping');
      super.visitMethodInvocation(node);
      return;
    }
    var expression = node.argumentList.arguments.first;
    var offset = node.methodName.offset;
    var endOffset = node.methodName.end;
    logger.finer('Checking method invocation arguments for length - 1 pattern');
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
    var contains =
        element is InterfaceElement &&
        element.interfaceMembers.entries
            .map((entry) => entry.key.name)
            .contains('last');
    logger.finer('_elementDoesntContainLast(${element.name}) -> ${!contains}');
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

  void _reportWhenLengthMinusOne(
    Expression expression,
    Element targetElement,
    Element targetTypeElement,
    int offset,
    int endOffset,
  ) {
    logger.finer(
      '_reportWhenLengthMinusOne() checking expression: '
      '${expression.runtimeType}',
    );
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
          logger.fine(
            'Reporting use of length - 1 on prefixed identifier for type '
            '${targetTypeElement.name}',
          );
          rule.reportAtOffset(offset, endOffset - offset);
        case SimpleIdentifier(
              name: 'length',
              element: GetterElement() || FieldElement(),
              :var enclosingTypeElement,
            )
            when enclosingTypeElement == targetTypeElement &&
                targetElement == enclosingTypeElement:
          logger.fine(
            'Reporting use of length - 1 on simple identifier for type '
            '${targetTypeElement.name}',
          );
          rule.reportAtOffset(offset, endOffset - offset);
      }
    } else {
      logger.finer('Expression does not match length - 1 pattern');
    }
  }
}
