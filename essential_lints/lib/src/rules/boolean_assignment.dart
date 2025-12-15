import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'rule.dart';

/// {@template boolean_assignment}
/// Checks for assignments where a condition was expected.
/// {@endtemplate}
class BooleanAssignmentRule extends LintRule {
  /// {@macro boolean_assignment}
  BooleanAssignmentRule() : super(.booleanAssignment);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _BooleanAssignmentVisitor(this, context);
    registry
      ..addIfStatement(this, visitor)
      ..addVariableDeclaration(this, visitor)
      ..addWhileStatement(this, visitor)
      ..addConditionalExpression(this, visitor)
      ..addWhenClause(this, visitor)
      ..addForPartsWithDeclarations(this, visitor)
      ..addForPartsWithExpression(this, visitor)
      ..addForPartsWithPattern(this, visitor)
      ..addAssertInitializer(this, visitor)
      ..addAssertStatement(this, visitor)
      ..addReturnStatement(this, visitor)
      ..addAssignmentExpression(this, visitor)
      ..addArgumentList(this, visitor);
  }
}

class _BooleanAssignmentVisitor extends SimpleAstVisitor<void> {
  _BooleanAssignmentVisitor(this.rule, this.context);

  final BooleanAssignmentRule rule;
  final RuleContext context;

  @override
  void visitIfStatement(IfStatement node) {
    if (node.caseClause == null) {
      _reportIfAssignment(node.expression);
    }
  }

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    if (node.initializer case var initializer?
        when initializer.staticType?.isDartCoreBool ?? false) {
      _reportIfAssignment(initializer);
    }
  }

  @override
  void visitWhileStatement(WhileStatement node) {
    _reportIfAssignment(node.condition);
  }

  @override
  void visitConditionalExpression(ConditionalExpression node) {
    _reportIfAssignment(node.condition);
  }

  @override
  void visitWhenClause(WhenClause node) {
    _reportIfAssignment(node.expression);
  }

  @override
  void visitForPartsWithDeclarations(ForPartsWithDeclarations node) {
    if (node.condition case var condition?) {
      _reportIfAssignment(condition);
    }
  }

  @override
  void visitForPartsWithExpression(ForPartsWithExpression node) {
    if (node.condition case var condition?) {
      _reportIfAssignment(condition);
    }
  }

  @override
  void visitForPartsWithPattern(ForPartsWithPattern node) {
    if (node.condition case var condition?) {
      _reportIfAssignment(condition);
    }
  }

  @override
  void visitAssertInitializer(AssertInitializer node) {
    _reportIfAssignment(node.condition);
  }

  @override
  void visitAssertStatement(AssertStatement node) {
    _reportIfAssignment(node.condition);
  }

  @override
  void visitReturnStatement(ReturnStatement node) {
    if (node.expression case var expression?
        when expression.staticType?.isDartCoreBool ?? false) {
      _reportIfAssignment(expression);
    }
  }

  @override
  void visitAssignmentExpression(AssignmentExpression node) {
    if (node.rightHandSide.staticType?.isDartCoreBool ?? false) {
      _reportIfAssignment(node.rightHandSide);
    }
  }

  @override
  void visitArgumentList(ArgumentList node) {
    for (final argument in node.arguments) {
      var expression = argument;
      if (expression is NamedExpression) {
        expression = expression.expression;
      }
      if (expression.staticType?.isDartCoreBool ?? false) {
        _reportIfAssignment(expression);
      }
    }
  }

  void _reportIfAssignment(Expression expression) {
    if (expression.unParenthesized case AssignmentExpression(:var operator)) {
      rule.reportAtToken(operator);
    }
  }
}
