import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/extensions/ast.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template useless_else}
/// Checks for useless else statements.
/// {@endtemplate}
@staticLoggerEnforcement
class UselessElseRule extends LintRule {
  /// {@macro useless_else}
  UselessElseRule() : super(.uselessElse, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'UselessElseRule',
  );

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _UselessElseVisitor(this, context);
    registry.addIfStatement(this, visitor);
  }
}

class _UselessElseVisitor extends SimpleAstVisitor<void> {
  _UselessElseVisitor(this.rule, this.context) {
    rule.logger.info('_UselessElseVisitor() created');
  }

  final UselessElseRule rule;
  final RuleContext context;

  @override
  void visitIfStatement(IfStatement node) {
    rule.logger.info('visitIfStatement() started for: ${node.toSource()}');
    var elseKeyword = node.elseKeyword;
    if (elseKeyword == null) {
      rule.logger.finer('No else keyword present, skipping');
      return;
    }
    if (node.thenStatement.alwaysExits) {
      rule.logger.fine(
        'Then-statement always exits; reporting else at ${elseKeyword.lexeme}',
      );
      rule.reportAtToken(elseKeyword);
    }
    rule.logger.info('visitIfStatement() completed for: ${node.toSource()}');
  }
}
