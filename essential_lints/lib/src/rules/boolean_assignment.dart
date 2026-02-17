import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template boolean_assignment}
/// Checks for assignments where a condition was expected.
/// {@endtemplate}
@staticLoggerEnforcement
class BooleanAssignmentRule extends LintRule {
  /// {@macro boolean_assignment}
  BooleanAssignmentRule() : super(.booleanAssignment, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'BooleanAssignmentRule',
  );

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    logger.fine('Registering node processors for BooleanAssignmentRule');
    var visitor = _BooleanAssignmentVisitor(this, context);
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
    logger.fine('Registered node processors for BooleanAssignmentRule');
  }
}

class _BooleanAssignmentVisitor extends SimpleAstVisitor<void> {
  _BooleanAssignmentVisitor(this.rule, this.context);

  final BooleanAssignmentRule rule;
  final RuleContext context;

  @override
  void visitIfStatement(IfStatement node) {
    rule.logger.info(
      'BooleanAssignmentRule.visitIfStatement() started at offset '
      '${node.offset}',
    );
    if (node.caseClause == null) {
      rule.logger.fine(
        'IfStatement has no caseClause — checking condition expression',
      );
      _reportIfAssignment(node.expression);
    } else {
      rule.logger.finer(
        'IfStatement has a caseClause, skipping condition check',
      );
    }
  }

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    rule.logger.info(
      'BooleanAssignmentRule.visitVariableDeclaration() started for '
      '${node.name.lexeme} at offset ${node.offset}',
    );
    if (node.initializer case var initializer?
        when initializer.staticType?.isDartCoreBool ?? false) {
      rule.logger.fine(
        'Variable ${node.name.lexeme} has bool initializer — checking for '
        'assignment in initializer',
      );
      _reportIfAssignment(initializer);
    } else {
      rule.logger.finer(
        'Variable ${node.name.lexeme} initializer is not a bool or is absent',
      );
    }
  }

  @override
  void visitWhileStatement(WhileStatement node) {
    rule.logger.info(
      'BooleanAssignmentRule.visitWhileStatement() started at offset '
      '${node.offset}',
    );
    rule.logger.fine('Checking while condition for assignment');
    _reportIfAssignment(node.condition);
  }

  @override
  void visitConditionalExpression(ConditionalExpression node) {
    rule.logger.info(
      'BooleanAssignmentRule.visitConditionalExpression() started at offset '
      '${node.offset}',
    );
    rule.logger.fine(
      'Checking conditional expression condition for assignment',
    );
    _reportIfAssignment(node.condition);
  }

  @override
  void visitWhenClause(WhenClause node) {
    rule.logger.info(
      'BooleanAssignmentRule.visitWhenClause() started at offset '
      '${node.offset}',
    );
    rule.logger.fine('Checking when-clause expression for assignment');
    _reportIfAssignment(node.expression);
  }

  @override
  void visitForPartsWithDeclarations(ForPartsWithDeclarations node) {
    rule.logger.info(
      'BooleanAssignmentRule.visitForPartsWithDeclarations() started at offset '
      '${node.offset}',
    );
    if (node.condition case var condition?) {
      rule.logger.fine('For loop has condition — checking for assignment');
      _reportIfAssignment(condition);
    } else {
      rule.logger.finer('ForPartsWithDeclarations has no condition');
    }
  }

  @override
  void visitForPartsWithExpression(ForPartsWithExpression node) {
    rule.logger.info(
      'BooleanAssignmentRule.visitForPartsWithExpression() started at offset '
      '${node.offset}',
    );
    if (node.condition case var condition?) {
      rule.logger.fine('For loop has condition — checking for assignment');
      _reportIfAssignment(condition);
    } else {
      rule.logger.finer('ForPartsWithExpression has no condition');
    }
  }

  @override
  void visitForPartsWithPattern(ForPartsWithPattern node) {
    rule.logger.info(
      'BooleanAssignmentRule.visitForPartsWithPattern() started at offset '
      '${node.offset}',
    );
    if (node.condition case var condition?) {
      rule.logger.fine('For loop has condition — checking for assignment');
      _reportIfAssignment(condition);
    } else {
      rule.logger.finer('ForPartsWithPattern has no condition');
    }
  }

  @override
  void visitAssertInitializer(AssertInitializer node) {
    rule.logger.info(
      'BooleanAssignmentRule.visitAssertInitializer() started at offset '
      '${node.offset}',
    );
    rule.logger.fine('Checking assert initializer condition for assignment');
    _reportIfAssignment(node.condition);
  }

  @override
  void visitAssertStatement(AssertStatement node) {
    rule.logger.info(
      'BooleanAssignmentRule.visitAssertStatement() started at offset '
      '${node.offset}',
    );
    rule.logger.fine('Checking assert statement condition for assignment');
    _reportIfAssignment(node.condition);
  }

  @override
  void visitReturnStatement(ReturnStatement node) {
    rule.logger.info(
      'BooleanAssignmentRule.visitReturnStatement() started at offset '
      '${node.offset}',
    );
    if (node.expression case var expression?
        when expression.staticType?.isDartCoreBool ?? false) {
      rule.logger.fine(
        'Return statement returns a bool expression — checking for assignment',
      );
      _reportIfAssignment(expression);
    } else {
      rule.logger.finer(
        'Return statement expression is not a bool or is absent',
      );
    }
  }

  @override
  void visitAssignmentExpression(AssignmentExpression node) {
    rule.logger.info(
      'BooleanAssignmentRule.visitAssignmentExpression() started at offset '
      '${node.offset}',
    );
    if (node.rightHandSide.staticType?.isDartCoreBool ?? false) {
      rule.logger.fine(
        'Assignment right-hand side is a bool — checking for nested assignment',
      );
      _reportIfAssignment(node.rightHandSide);
    } else {
      rule.logger.finer('AssignmentExpression RHS is not a bool');
    }
  }

  @override
  void visitArgumentList(ArgumentList node) {
    rule.logger.info(
      'BooleanAssignmentRule.visitArgumentList() started at offset '
      '${node.offset}',
    );
    for (var argument in node.arguments) {
      var expression = argument;
      if (expression is NamedExpression) {
        expression = expression.expression;
      }
      if (expression.staticType?.isDartCoreBool ?? false) {
        rule.logger.fine('Found bool-typed argument — checking for assignment');
        _reportIfAssignment(expression);
      } else {
        rule.logger.finer('Argument expression is not bool-typed');
      }
    }
  }

  void _reportIfAssignment(Expression expression) {
    if (expression.unParenthesized case AssignmentExpression(:var operator)) {
      rule.logger.fine(
        'Detected assignment expression with operator "${operator.lexeme}" at '
        'offset ${operator.offset} — reporting',
      );
      rule.reportAtToken(operator);
    } else {
      rule.logger.finer(
        'Expression is not an assignment expression (offset '
        '${expression.offset})',
      );
    }
  }
}
