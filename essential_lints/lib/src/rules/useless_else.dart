import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../utils/extensions/ast.dart';
import 'rule.dart';

/// {@template useless_else}
/// Checks for useless else statements.
/// {@endtemplate}
class UselessElseRule extends LintRule {
  /// {@macro useless_else}
  UselessElseRule() : super(.uselessElse);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _UselessElseVisitor(this, context);
    registry.addIfStatement(this, visitor);
  }
}

class _UselessElseVisitor extends SimpleAstVisitor<void> {
  _UselessElseVisitor(this.rule, this.context);

  final UselessElseRule rule;
  final RuleContext context;

  @override
  void visitIfStatement(IfStatement node) {
    var elseKeyword = node.elseKeyword;
    if (elseKeyword == null) {
      return;
    }
    if (node.thenStatement.alwaysExits) {
      rule.reportAtToken(elseKeyword);
    }
  }
}
