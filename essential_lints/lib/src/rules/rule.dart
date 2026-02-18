import '../utils/base_visitor.dart';
import 'analysis_rule.dart';
import 'essential_lint_rules.dart';

/// {@template rule}
/// The base class for all essential lint rules.
/// {@endtemplate}
abstract class LintRule<Rule extends LintRule<Rule>>
    extends EssentialAnalysisRule<Rule, BaseVisitor<Rule>, EssentialLintRules> {
  /// {@macro rule}
  LintRule(super.rule, super.logger);
}

/// {@template rule}
/// The base class for all essential multi-lints rules.
/// {@endtemplate}
abstract class MultiLintRule<
  Rule extends MultiLintRule<Rule, Sub>,
  Sub extends SubLints
>
    extends
        EssentialMultiAnalysisRule<
          Rule,
          BaseVisitor<Rule>,
          EssentialMultiLints<Sub>,
          Sub
        > {
  /// {@macro rule}
  MultiLintRule(super.rule, super.logger);
}
