import 'analysis_rule.dart';
import 'essential_lint_rules.dart';

/// {@template rule}
/// The base class for all essential lint rules.
/// {@endtemplate}
abstract class LintRule extends EssentialAnalysisRule {
  /// {@macro rule}
  LintRule(EssentialLintRules super.rule, super.logger);
}

/// {@template rule}
/// The base class for all essential multi-lints rules.
/// {@endtemplate}
abstract class MultiLintRule<T extends SubLints>
    extends EssentialMultiAnalysisRule {
  /// {@macro rule}
  MultiLintRule(EssentialMultiLints<T> super.rule, super.logger);
}
