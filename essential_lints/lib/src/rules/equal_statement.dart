import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../utils/extensions/list.dart';
import 'rule.dart';

/// {@template equal_statement}
/// A lint rule for equal statements under switch cases.
/// {@endtemplate}
class EqualStatementRule extends LintRule {
  /// {@macro equal_statement}
  EqualStatementRule() : super(.equalStatement);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _EqualStatementVisitor(this, context);
    registry
      ..addSwitchStatement(this, visitor)
      ..addSwitchExpression(this, visitor);
  }
}

class _EqualStatementVisitor extends SimpleAstVisitor<void> {
  _EqualStatementVisitor(this.rule, this.context);

  final EqualStatementRule rule;
  final RuleContext context;

  @override
  void visitSwitchExpression(SwitchExpression node) {
    if (node.cases.length < 2) {
      return;
    }
    var equals = <String, List<SwitchExpressionCase>>{};
    for (var i = 0; i < node.cases.length; i++) {
      var comparingExpression = node.cases[i].expression;
      if (equals.containsKey(comparingExpression.toSource())) {
        continue;
      }
      for (final switchCase in node.cases) {
        if (switchCase.expression.toSource() ==
            comparingExpression.toSource()) {
          equals
              .putIfAbsent(switchCase.expression.toSource(), () => [])
              .add(switchCase);
        }
      }
    }
    for (final entry in equals.entries) {
      if (entry.value.length < 2) {
        continue;
      }
      rule.reportAtToken(
        entry.value[1].arrow,
        arguments: [
          entry.value
              .map((switchCase) => switchCase.guardedPattern.toSource())
              .quotedAndCommaSeparatedWithAnd,
        ],
      );
    }
  }

  @override
  void visitSwitchStatement(SwitchStatement node) {
    if (node.members.length < 2) {
      return;
    }
    var equals = <String, List<SwitchMember>>{};
    for (var i = 0; i < node.members.length; i++) {
      var member = node.members[i];
      var statementsSource = member.statements.map((e) => e.toSource()).join();
      if (equals.containsKey(statementsSource)) {
        continue;
      }
      for (final switchCase in node.members) {
        var switchCaseStatementsSource = switchCase.statements
            .map((e) => e.toSource())
            .join();
        if (switchCaseStatementsSource == statementsSource) {
          equals.putIfAbsent(statementsSource, () => []).add(switchCase);
        }
      }
    }
    for (final entry in equals.entries) {
      if (entry.value.length < 2) {
        continue;
      }
      rule.reportAtToken(
        entry.value[1].keyword,
        arguments: [
          entry.value
              .map((switchCase) => switchCase.source())
              .quotedAndCommaSeparatedWithAnd,
        ],
      );
    }
  }
}

extension on SwitchMember {
  String source() {
    return switch (this) {
      SwitchCase(:var expression) => 'case ${expression.toSource()}:',
      SwitchDefault() => '${keyword.lexeme}:',
      SwitchPatternCase(:var guardedPattern) =>
        'case ${guardedPattern.toSource()}:',
    };
  }
}
