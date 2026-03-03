import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import '../utils/extensions/list.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template equal_statement}
/// A lint rule for equal statements under switch cases.
/// {@endtemplate}
@staticLoggerEnforcement
class EqualStatementRule extends LintRule<EqualStatementRule> {
  /// {@macro equal_statement}
  EqualStatementRule() : super(.equalStatement, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'EqualStatementRule',
  );

  @override
  Visitor<EqualStatementRule, void> visitorFor(RuleContext context) =>
      _EqualStatementVisitor(this, context);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = visitorFor(context);
    registry
      ..addSwitchStatement(this, visitor)
      ..addSwitchExpression(this, visitor);
  }
}

class _EqualStatementVisitor extends BaseVisitor<EqualStatementRule> {
  _EqualStatementVisitor(super.rule, super.context);

  @override
  void visitSwitchExpression(SwitchExpression node) {
    logger.info(
      'visitSwitchExpression() started with ${node.cases.length} case(s)',
    );
    if (node.cases.length < 2) {
      logger.finer('Less than 2 cases — nothing to compare');
      return;
    }

    var equals = <String, List<SwitchExpressionCase>>{};
    for (var i = 0; i < node.cases.length; i++) {
      var comparingExpression = node.cases[i].expression;
      var key = comparingExpression.toSource();
      if (equals.containsKey(key)) {
        logger.finer('Already processed expression: $key');
        continue;
      }
      for (var switchCase in node.cases) {
        if (switchCase.expression.toSource() == key) {
          equals.putIfAbsent(key, () => []).add(switchCase);
        }
      }
      logger.finer(
        'Collected ${equals[key]?.length ?? 0} entry(ies) for expression: $key',
      );
    }

    for (var entry in equals.entries) {
      if (entry.value.length < 2) {
        continue;
      }
      logger.fine(
        'Reporting equal switch expression for ${entry.key} with '
        '${entry.value.length} occurrences',
      );
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
    logger.info(
      'visitSwitchStatement() started with ${node.members.length} member(s)',
    );
    if (node.members.length < 2) {
      logger.finer('Less than 2 members — nothing to compare');
      return;
    }

    var equals = <String, List<SwitchMember>>{};
    for (var i = 0; i < node.members.length; i++) {
      var member = node.members[i];
      if (member.statements.isEmpty) {
        logger.finer('Member $i has no statements — skipping');
        continue;
      }
      var statementsSource = member.statements.map((e) => e.toSource()).join();
      if (equals.containsKey(statementsSource)) {
        logger.finer('Statements source already processed for member $i');
        continue;
      }
      for (var switchCase in node.members) {
        var switchCaseStatementsSource = switchCase.statements
            .map((e) => e.toSource())
            .join();
        if (switchCaseStatementsSource == statementsSource) {
          equals.putIfAbsent(statementsSource, () => []).add(switchCase);
        }
      }
      logger.finer(
        'Collected ${equals[statementsSource]?.length ?? 0} member(s) for '
        'statementsSource at member $i',
      );
    }

    for (var entry in equals.entries) {
      if (entry.value.length < 2) {
        continue;
      }
      logger.fine(
        'Reporting equal switch statement with ${entry.value.length} '
        'occurrences',
      );
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
