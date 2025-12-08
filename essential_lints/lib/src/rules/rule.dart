import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/error/error.dart';
import 'package:meta/meta.dart';

import 'essential_lint_rules.dart';

/// {@template rule}
/// The base class for all essential lint rules.
/// {@endtemplate}
abstract class LintRule extends AnalysisRule {
  /// {@macro rule}
  LintRule(this.rule)
    : super(
        name: rule.code.name,
        description: rule.code.description,
      );

  /// The essential lint rule associated with this analysis rule.
  final EssentialLintRules rule;

  @override
  DiagnosticCode get diagnosticCode => rule;

  @override
  @mustBeOverridden
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  );
}

/// {@template rule}
/// The base class for all essential multi-lints rules.
/// {@endtemplate}
abstract class MultiLintRule<T extends SubLints> extends MultiAnalysisRule {
  /// {@macro rule}
  MultiLintRule(this.rule)
    : super(
        name: rule.code.name,
        description: rule.code.description,
      );

  /// The essential lint rule associated with this analysis rule.
  final EssentialMultiLints<T> rule;

  @override
  List<DiagnosticCode> get diagnosticCodes => [
    rule.code,
    ...subLints.map((e) => e.code),
  ];

  /// The list of sub-lints associated with this analysis rule.
  List<T> get subLints;

  @override
  @mustBeOverridden
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  );
}
