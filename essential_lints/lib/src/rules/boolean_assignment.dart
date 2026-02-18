import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template boolean_assignment}
/// Checks for assignments where a condition was expected.
/// {@endtemplate}
@staticLoggerEnforcement
class BooleanAssignmentRule extends LintRule<BooleanAssignmentRule> {
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

class _BooleanAssignmentVisitor extends BaseVisitor<BooleanAssignmentRule> {
  _BooleanAssignmentVisitor(super.rule, super.context);

  @override
  void visitIfStatement(IfStatement node) {
    logger.info(
      'BooleanAssignmentRule.visitIfStatement() started at offset '
      '${node.offset}',
    );
    if (node.caseClause == null) {
      logger.fine(
        'IfStatement has no caseClause — checking condition expression',
      );
      _reportIfAssignment(node.expression);
    } else {
      logger.finer(
        'IfStatement has a caseClause, skipping condition check',
      );
    }
  }

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    logger.info(
      'BooleanAssignmentRule.visitVariableDeclaration() started for '
      '${node.name.lexeme} at offset ${node.offset}',
    );
    if (node.initializer case var initializer?
        when initializer.staticType?.isDartCoreBool ?? false) {
      logger.fine(
        'Variable ${node.name.lexeme} has bool initializer — checking for '
        'assignment in initializer',
      );
      _reportIfAssignment(initializer);
    } else {
      logger.finer(
        'Variable ${node.name.lexeme} initializer is not a bool or is absent',
      );
    }
  }

  @override
  void visitWhileStatement(WhileStatement node) {
    logger..info(
      'BooleanAssignmentRule.visitWhileStatement() started at offset '
      '${node.offset}',
    )
    ..fine('Checking while condition for assignment');
    _reportIfAssignment(node.condition);
  }

  @override
  void visitConditionalExpression(ConditionalExpression node) {
    logger..info(
      'BooleanAssignmentRule.visitConditionalExpression() started at offset '
      '${node.offset}',
    )
    ..fine(
      'Checking conditional expression condition for assignment',
    );
    _reportIfAssignment(node.condition);
  }

  @override
  void visitWhenClause(WhenClause node) {
    logger..info(
      'BooleanAssignmentRule.visitWhenClause() started at offset '
      '${node.offset}',
    )
    ..fine('Checking when-clause expression for assignment');
    _reportIfAssignment(node.expression);
  }

  @override
  void visitForPartsWithDeclarations(ForPartsWithDeclarations node) {
    logger.info(
      'BooleanAssignmentRule.visitForPartsWithDeclarations() started at offset '
      '${node.offset}',
    );
    if (node.condition case var condition?) {
      logger.fine('For loop has condition — checking for assignment');
      _reportIfAssignment(condition);
    } else {
      logger.finer('ForPartsWithDeclarations has no condition');
    }
  }

  @override
  void visitForPartsWithExpression(ForPartsWithExpression node) {
    logger.info(
      'BooleanAssignmentRule.visitForPartsWithExpression() started at offset '
      '${node.offset}',
    );
    if (node.condition case var condition?) {
      logger.fine('For loop has condition — checking for assignment');
      _reportIfAssignment(condition);
    } else {
      logger.finer('ForPartsWithExpression has no condition');
    }
  }

  @override
  void visitForPartsWithPattern(ForPartsWithPattern node) {
    logger.info(
      'BooleanAssignmentRule.visitForPartsWithPattern() started at offset '
      '${node.offset}',
    );
    if (node.condition case var condition?) {
      logger.fine('For loop has condition — checking for assignment');
      _reportIfAssignment(condition);
    } else {
      logger.finer('ForPartsWithPattern has no condition');
    }
  }

  @override
  void visitAssertInitializer(AssertInitializer node) {
    logger..info(
      'BooleanAssignmentRule.visitAssertInitializer() started at offset '
      '${node.offset}',
    )
    ..fine('Checking assert initializer condition for assignment');
    _reportIfAssignment(node.condition);
  }

  @override
  void visitAssertStatement(AssertStatement node) {
    logger..info(
      'BooleanAssignmentRule.visitAssertStatement() started at offset '
      '${node.offset}',
    )
    ..fine('Checking assert statement condition for assignment');
    _reportIfAssignment(node.condition);
  }

  @override
  void visitReturnStatement(ReturnStatement node) {
    logger.info(
      'BooleanAssignmentRule.visitReturnStatement() started at offset '
      '${node.offset}',
    );
    if (node.expression case var expression?
        when expression.staticType?.isDartCoreBool ?? false) {
      logger.fine(
        'Return statement returns a bool expression — checking for assignment',
      );
      _reportIfAssignment(expression);
    } else {
      logger.finer(
        'Return statement expression is not a bool or is absent',
      );
    }
  }

  @override
  void visitAssignmentExpression(AssignmentExpression node) {
    logger.info(
      'BooleanAssignmentRule.visitAssignmentExpression() started at offset '
      '${node.offset}',
    );
    if (node.rightHandSide.staticType?.isDartCoreBool ?? false) {
      logger.fine(
        'Assignment right-hand side is a bool — checking for nested assignment',
      );
      _reportIfAssignment(node.rightHandSide);
    } else {
      logger.finer('AssignmentExpression RHS is not a bool');
    }
  }

  @override
  void visitArgumentList(ArgumentList node) {
    logger.info(
      'BooleanAssignmentRule.visitArgumentList() started at offset '
      '${node.offset}',
    );
    for (var argument in node.arguments) {
      var expression = argument;
      if (expression is NamedExpression) {
        expression = expression.expression;
      }
      if (expression.staticType?.isDartCoreBool ?? false) {
        logger.fine('Found bool-typed argument — checking for assignment');
        _reportIfAssignment(expression);
      } else {
        logger.finer('Argument expression is not bool-typed');
      }
    }
  }

  void _reportIfAssignment(Expression expression) {
    if (expression.unParenthesized case AssignmentExpression(:var operator)) {
      logger.fine(
        'Detected assignment expression with operator "${operator.lexeme}" at '
        'offset ${operator.offset} — reporting',
      );
      rule.reportAtToken(operator);
    } else {
      logger.finer(
        'Expression is not an assignment expression (offset '
        '${expression.offset})',
      );
    }
  }
}
