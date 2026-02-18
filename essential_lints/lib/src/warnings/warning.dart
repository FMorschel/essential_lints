import '../rules/analysis_rule.dart';
import '../utils/base_visitor.dart';
import 'essential_lint_warnings.dart'
    show EssentialLintWarnings, EssentialMultiWarnings, SubWarnings;

/// {@template rule}
/// The base class for all essential warning rules.
/// {@endtemplate}
abstract class WarningRule<Rule extends WarningRule<Rule>>
    extends
        EssentialAnalysisRule<Rule, BaseVisitor<Rule>, EssentialLintWarnings> {
  /// {@macro rule}
  WarningRule(super.rule, super.logger);
}

/// {@template rule}
/// The base class for all essential multi-warnings rules.
/// {@endtemplate}
abstract class MultiWarningRule<
  Rule extends MultiWarningRule<Rule, Sub>,
  Sub extends SubWarnings
>
    extends
        EssentialMultiAnalysisRule<
          Rule,
          BaseVisitor<Rule>,
          EssentialMultiWarnings<Sub>,
          Sub
        > {
  /// {@macro rule}
  MultiWarningRule(super.rule, super.logger);
}
