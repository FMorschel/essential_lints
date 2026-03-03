import '../rules/analysis_rule.dart';
import 'essential_lint_warnings.dart'
    show EssentialLintWarningCode, EssentialMultiWarningCode, SubWarnings;

/// The enum for all the essential warning rules, containing their names and
/// descriptions.
enum EssentialLintWarningRule implements Rule {
  /// Members of a class should be sorted in a specific order.
  sortingMembers(
    name: 'sorting_members',
    description:
        'A rule that ensures the members of a class are sorted in a '
        'specific order.',
  ),

  /// Getters should be included in member lists.
  gettersInMemberList(
    name: 'getters_in_member_list',
    description:
        'A lint rule that ensures getters/fields are included in the member '
        'list.',
  ),

  /// Subtypes should follow specific naming conventions.
  subtypeNaming(
    name: 'subtype_naming',
    description:
        'A lint rule that ensures subtypes follow specific naming '
        'conventions such as required prefixes, suffixes, or containing '
        'names.',
  ),

  /// Subtypes should be annotated with specific annotations.
  subtypeAnnotating(
    name: 'subtype_annotating',
    description:
        'A rule that ensures subtypes are annotated with specific '
        'annotations as defined by the @SubtypeAnnotating annotation.',
  );

  const EssentialLintWarningRule({
    required this.name,
    required this.description,
  });

  @override
  final String name;

  @override
  final String description;
}

/// {@template rule}
/// The base class for all essential rules.
/// {@endtemplate}
abstract class Rule {
  /// {@macro rule}
  const Rule({required this.name, required this.description});

  /// The human-readable name of the rule.
  final String name;

  /// A description of the rule.
  final String description;
}

/// {@template rule}
/// The base class for all essential warning rules.
/// {@endtemplate}
// ignore: avoid_types_as_parameter_names
abstract class WarningRule<Rule extends WarningRule<Rule>>
    extends
        EssentialAnalysisRule<
          Rule,
          EssentialLintWarningCode
        > {
  /// {@macro rule}
  WarningRule(super.rule, super.logger);
}

/// {@template rule}
/// The base class for all essential multi-warnings rules.
/// {@endtemplate}
abstract class MultiWarningRule<
  R extends MultiWarningRule<R, Sub>,
  Sub extends SubWarnings
>
    extends
        EssentialMultiAnalysisRule<
          R,
          EssentialMultiWarningCode<Sub>,
          Sub
        > {
  /// {@macro rule}
  MultiWarningRule(super.rule, super.logger);
}
