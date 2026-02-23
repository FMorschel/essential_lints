import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template duplicate_value}
/// A lint rule that detects duplicate values in comparisons like `&&` and `||`.
/// {@endtemplate}
@staticLoggerEnforcement
class DuplicateValueRule extends LintRule<DuplicateValueRule> {
  /// {@macro duplicate_value}
  DuplicateValueRule() : super(.duplicateValue, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'DuplicateValueRule',
  );

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _DuplicateValueVisitor(this, context);
    registry
      ..addBinaryExpression(this, visitor)
      ..addSwitchPatternCase(this, visitor)
      ..addSwitchExpressionCase(this, visitor);
  }
}

class _DuplicateValueVisitor extends BaseVisitor<DuplicateValueRule> {
  _DuplicateValueVisitor(super.rule, super.context);

  @override
  void visitBinaryExpression(BinaryExpression node) {
    logger.info(
      'visitBinaryExpression() started: operator=${node.operator.type}',
    );

    if (node.operator.type != TokenType.AMPERSAND_AMPERSAND &&
        node.operator.type != TokenType.BAR_BAR &&
        node.operator.type != TokenType.EQ_EQ &&
        node.operator.type != TokenType.BANG_EQ &&
        (node.operator.type != TokenType.CARET ||
            !(node.leftOperand.staticType?.isDartCoreBool ?? false))) {
      logger.finer(
        'Operator ${node.operator.type} not subject to duplicate-value rule — '
        'skipping',
      );
      return;
    }

    var left = node.leftOperand.toSource();
    var right = node.rightOperand.toSource();
    logger.finer('Left: "$left", Right: "$right"');
    if (left == right) {
      logger.fine('Detected duplicate value in binary expression: $left');
      rule.reportAtToken(node.operator);
    }
  }

  @override
  void visitSwitchExpressionCase(SwitchExpressionCase node) {
    logger.info('visitSwitchExpressionCase() started');
    _handlePattern(node.guardedPattern.pattern);
  }

  @override
  void visitSwitchPatternCase(SwitchPatternCase node) {
    logger.info('visitSwitchPatternCase() started');
    _handlePattern(node.guardedPattern.pattern);
  }

  void _handlePattern(DartPattern pattern) {
    logger.info(
      '_handlePattern() started for pattern: ${pattern.runtimeType}',
    );

    DartPattern leftPattern;
    DartPattern rightPattern;
    Token token;
    if (pattern
        case LogicalOrPattern(
              :var leftOperand,
              :var rightOperand,
              :var operator,
            ) ||
            LogicalAndPattern(
              :var leftOperand,
              :var rightOperand,
              :var operator,
            )) {
      leftPattern = leftOperand;
      rightPattern = rightOperand;
      token = operator;
    } else {
      logger.finer('Pattern is not LogicalOr/LogicalAnd — skipping');
      return;
    }

    var leftSrc = leftPattern.toSource();
    var rightSrc = rightPattern.toSource();
    logger.finer('Left pattern: "$leftSrc", Right pattern: "$rightSrc"');
    if (leftSrc == rightSrc) {
      logger.fine('Detected duplicate value in pattern: $leftSrc');
      rule.reportAtToken(token);
    }
  }
}
