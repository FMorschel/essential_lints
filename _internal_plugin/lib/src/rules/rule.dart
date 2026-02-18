import 'package:essential_lints/src/rules/analysis_rule.dart';
import 'package:essential_lints/src/utils/base_visitor.dart';

import 'diagnostic.dart';

abstract class LintRule<Rule extends LintRule<Rule>>
    extends
        EssentialAnalysisRule<Rule, BaseVisitor<Rule>, InternalDiagnosticCode> {
  /// {@macro rule}
  LintRule(super.rule, super.logger);
}
