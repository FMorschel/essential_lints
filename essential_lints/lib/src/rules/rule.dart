import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:essential_lints_annotations/essential_lints_annotations.dart';
import 'package:meta/meta.dart';

import '../warnings/essential_lint_warnings.dart' hide SubtypeNaming;
import 'analysis_rule.dart';
import 'essential_lint_rules.dart';

/// {@template rule}
/// The base class for all essential lint rules.
/// {@endtemplate}
@SubtypeNaming(suffix: 'Rule')
abstract class LintRule extends EssentialAnalysisRule {
  /// {@macro rule}
  LintRule(this.rule)
    : super(
        name: rule.lowerCaseUniqueName,
        description: rule.code.description,
      );

  /// The essential lint rule associated with this analysis rule.
  final EssentialLintRules rule;

  @override
  EnumDiagnostic get diagnosticCode => rule;

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
@SubtypeNaming(suffix: 'Rule')
abstract class MultiLintRule<T extends SubLints>
    extends EssentialMultiAnalysisRule {
  /// {@macro rule}
  MultiLintRule(this.rule)
    : super(
        name: rule.lowerCaseUniqueName,
        description: rule.code.description,
      );

  /// The essential lint rule associated with this analysis rule.
  final EssentialMultiLints<T> rule;

  @override
  List<EnumDiagnostic> get diagnosticCodes => [
    rule,
    ...subLints.map((e) => e),
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
