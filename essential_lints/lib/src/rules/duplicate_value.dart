import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'rule.dart';

/// {@template duplicate_value}
/// A lint rule that detects duplicate values in comparisons like `&&` and `||`.
/// {@endtemplate}
class DuplicateValueRule extends LintRule {
  /// {@macro duplicate_value}
  DuplicateValueRule() : super(.duplicateValue);

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

class _DuplicateValueVisitor extends SimpleAstVisitor<void> {
  _DuplicateValueVisitor(this.rule, this.context);

  final DuplicateValueRule rule;
  final RuleContext context;

  @override
  void visitBinaryExpression(BinaryExpression node) {
    if (node.operator.type != TokenType.AMPERSAND_AMPERSAND &&
        node.operator.type != TokenType.BAR_BAR &&
        node.operator.type != TokenType.EQ_EQ &&
        node.operator.type != TokenType.BANG_EQ &&
        (node.operator.type != TokenType.CARET ||
            !(node.leftOperand.staticType?.isDartCoreBool ?? false))) {
      return;
    }
    var left = node.leftOperand.toSource();
    var right = node.rightOperand.toSource();
    if (left == right) {
      rule.reportAtNode(node.rightOperand);
    }
  }

  @override
  void visitSwitchExpressionCase(SwitchExpressionCase node) {
    _handlePattern(node.guardedPattern.pattern);
  }

  @override
  void visitSwitchPatternCase(SwitchPatternCase node) {
    _handlePattern(node.guardedPattern.pattern);
  }

  void _handlePattern(DartPattern pattern) {
    DartPattern leftPattern;
    DartPattern rightPattern;
    if (pattern
        case LogicalOrPattern(:var leftOperand, :var rightOperand) ||
            LogicalAndPattern(:var leftOperand, :var rightOperand)) {
      leftPattern = leftOperand;
      rightPattern = rightOperand;
    } else {
      return;
    }
    if (leftPattern.toSource() == rightPattern.toSource()) {
      rule.reportAtNode(rightPattern);
    }
  }
}
