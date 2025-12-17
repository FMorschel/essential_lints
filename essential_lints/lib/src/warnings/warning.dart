import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/error/error.dart';
import 'package:essential_lints_annotations/essential_lints_annotations.dart';
import 'package:meta/meta.dart';

import 'essential_lint_warnings.dart'
    show EssentialLintWarnings, EssentialMultiWarnings, SubWarnings;

/// {@template rule}
/// The base class for all essential multi-warnings rules.
/// {@endtemplate}
@SubtypeNaming(suffix: 'Rule')
abstract class MultiWarningRule<T extends SubWarnings>
    extends MultiAnalysisRule {
  /// {@macro rule}
  MultiWarningRule(this.rule)
    : super(
        name: rule.code.name,
        description: rule.code.description,
      );

  /// The essential warning rule associated with this analysis rule.
  final EssentialMultiWarnings<T> rule;

  @override
  List<DiagnosticCode> get diagnosticCodes => [
    rule.code,
    ...subWarnings.map((e) => e.code),
  ];

  /// The list of sub-warnings associated with this analysis rule.
  List<T> get subWarnings;

  @override
  @mustBeOverridden
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  );
}

/// {@template rule}
/// The base class for all essential warning rules.
/// {@endtemplate}
@SubtypeNaming(suffix: 'Rule')
abstract class WarningRule extends AnalysisRule {
  /// {@macro rule}
  WarningRule(this.rule)
    : super(
        name: rule.code.name,
        description: rule.code.description,
      );

  /// The essential warning rule associated with this analysis rule.
  final EssentialLintWarnings rule;

  @override
  DiagnosticCode get diagnosticCode => rule.code;

  @override
  @mustBeOverridden
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  );
}
