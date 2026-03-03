import 'package:essential_lints/src/rules/analysis_rule.dart';
import 'package:essential_lints/src/utils/base_visitor.dart';
import 'package:essential_lints/src/warnings/essential_lint_warnings.dart';
import 'package:essential_lints/src/warnings/warning.dart' as diagnostic;

import 'diagnostic.dart';

enum InternalLintRule implements diagnostic.Rule {
  subDiagnostic(
    name: 'sub_diagnostic',
    description: 'Enforces that the SubDiagnostic name matches the base name.',
  ),
  annotateMembersWith(
    name: 'annotate_members_with',
    description: 'Members that should be annotated with specific annotations.',
  ),
  invalidMembers(
    name: 'invalid_members',
    description: 'Members that are invalid for a given modifier.',
  ),
  invalidModifiers(
    name: 'invalid_modifiers',
    description: 'Modifiers that are invalid for a given modifier.',
  ),
  reportShorterLengths(
    name: 'report_shorter_lengths',
    description: 'Report for long nodes.',
  ),
  staticEnforcement(
    name: 'static_enforcement',
    description: 'Enforces that certain members are declared as static.',
  );

  const InternalLintRule({required this.name, required this.description});

  @override
  final String name;

  @override
  final String description;
}

abstract class LintRule<R extends LintRule<R>>
    extends EssentialAnalysisRule<R, BaseVisitor<R>, InternalDiagnosticCode> {
  /// {@macro rule}
  LintRule(super.rule, super.logger);
}

abstract class MultiLintRule<
  R extends MultiLintRule<R, Sub>,
  Sub extends InternalMultiLints
>
    extends
        EssentialMultiAnalysisRule<
          R,
          BaseVisitor<R>,
          SuperDiagnostic<Sub>,
          Sub
        > {
  /// {@macro rule}
  MultiLintRule(super.rule, super.logger);
}
