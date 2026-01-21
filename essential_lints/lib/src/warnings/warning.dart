import '../rules/analysis_rule.dart';
import 'essential_lint_warnings.dart'
    show EssentialLintWarnings, EssentialMultiWarnings, SubWarnings;

/// {@template rule}
/// The base class for all essential warning rules.
/// {@endtemplate}
abstract class WarningRule extends EssentialAnalysisRule {
  /// {@macro rule}
  WarningRule(EssentialLintWarnings super.rule, super.logger);
}

/// {@template rule}
/// The base class for all essential multi-warnings rules.
/// {@endtemplate}
abstract class MultiWarningRule<T extends SubWarnings>
    extends EssentialMultiAnalysisRule {
  /// {@macro rule}
  MultiWarningRule(EssentialMultiWarnings<T> super.rule, super.logger);
}
