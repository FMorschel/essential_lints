import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import '../utils/extensions/ast.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template useless_else}
/// Checks for useless else statements.
/// {@endtemplate}
@staticLoggerEnforcement
class UselessElseRule extends LintRule<UselessElseRule> {
  /// {@macro useless_else}
  UselessElseRule() : super(.uselessElse, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'UselessElseRule',
  );

  @override
  Visitor<UselessElseRule, void> visitorFor(RuleContext context) =>
      _UselessElseVisitor(this, context);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = visitorFor(context);
    registry.addIfStatement(this, visitor);
  }
}

class _UselessElseVisitor extends BaseVisitor<UselessElseRule> {
  _UselessElseVisitor(super.rule, super.context);

  @override
  void visitIfStatement(IfStatement node) {
    logger.info('visitIfStatement() started for: ${node.toSource()}');
    var elseKeyword = node.elseKeyword;
    if (elseKeyword == null) {
      logger.finer('No else keyword present, skipping');
      return;
    }
    if (node.thenStatement.alwaysExits) {
      logger.fine(
        'Then-statement always exits; reporting else at ${elseKeyword.lexeme}',
      );
      rule.reportAtToken(elseKeyword);
    }
    logger.info('visitIfStatement() completed for: ${node.toSource()}');
  }
}
