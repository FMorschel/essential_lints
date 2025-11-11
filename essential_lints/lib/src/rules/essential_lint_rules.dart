import 'package:analyzer/error/error.dart';

import '../warnings/essential_lint_warnings.dart';

/// {@template enum_lint}
/// A mixin for enums that provide a lint rule code.
/// {@endtemplate}
mixin EnumLint on EnumDiagnostic implements LintCode {
  @override
  LintRuleCode get code;
}

/// The list of all essential lint rules.
enum EssentialLintRules with EnumDiagnostic, EnumLint {
  /// Arguments should be in alphabetical order.
  alphabetizeArguments(
    LintRuleCode(
      name: 'alphabetize_arguments',
      problemMessage: 'Arguments should be in alphabetical order.',
      correctionMessage: 'Reorder the arguments alphabetically.',
      description:
          'A lint rule that enforces alphabetical ordering of function '
          'arguments.',
    ),
  ),

  /// Prefer explicitly named parameters for better readability.
  preferExplicitlyNamedParameter(
    LintRuleCode(
      name: 'prefer_explicitly_named_parameter',
      problemMessage: 'Use explicitly named parameters for better readability.',
      correctionMessage:
          'Change to use explicitly named parameters in function type '
          'declarations.',
      description:
          'A lint rule that encourages the use of explicitly named parameters '
          'in function type declarations for improved code clarity and '
          'completion.',
    ),
  ),

  /// Double literals should follow the preferred format.
  doubleLiteralFormat(
    LintRuleCode(
      name: 'double_literal_format',
      problemMessage: 'Double literals should follow the preferred format.',
      correctionMessage:
          'Reformat the double literal to match the preferred style.',
      description:
          'A lint rule that enforces a consistent format for double literals '
          'in the codebase.',
    ),
  ),

  /// Prefer using the `last` property to access the last element of a
  /// list-like object.
  preferLast(
    LintRuleCode(
      name: 'prefer_last',
      problemMessage:
          'Prefer using the `last` property to access the last element of a '
          'list-like object.',
      correctionMessage: 'Replace the index access with the `last` property.',
      description:
          'A lint rule that suggests using the `last` property instead of '
          'accessing the last element of a list-like object using length - 1 '
          'index.',
    ),
  ),

  /// Prefer using the `first` property to access the first element of a
  /// list-like object.
  preferFirst(
    LintRuleCode(
      name: 'prefer_first',
      problemMessage:
          'Prefer using the `first` property to access the first element of a '
          'list-like object.',
      correctionMessage: 'Replace the index access with the `first` property.',
      description:
          'A lint rule that suggests using the `first` property instead of '
          'accessing the first element of a list-like object using index 0.',
    ),
  ),

  /// Avoid returning Widgets from functions.
  returningWidgets(
    LintRuleCode(
      name: 'returning_widgets',
      problemMessage: 'Avoid returning Widgets from functions.',
      correctionMessage: 'Prefer extracting the widget into a separate class.',
      description:
          'A lint rule that discourages returning Widgets from functions and '
          'encourages extracting them into separate classes for better code '
          'organization and reusability.',
    ),
  ),

  paddingOverContainer(
    LintRuleCode(
      name: 'padding_over_container',
      problemMessage:
          'Prefer using the inner padding property from Container over '
          'wrapping with padding.',
      correctionMessage:
          'Use the padding property of Container instead of wrapping it with '
          'a Padding widget.',
      description:
          'A lint rule that suggests using the padding property of Container '
          'instead of wrapping it with a Padding widget.',
    ),
  ),
  ;

  const EssentialLintRules(this.code);

  /// The diagnostic code associated with the lint rule.
  @override
  final LintRuleCode code;
}

/// The list of all essential lint rules.
enum EssentialMultiLints<T extends SubLints> with EnumDiagnostic, EnumLint {
  /// Getters should be included in member lists.
  // ignore: unused_field
  _placeholder(
    LintRuleCode(
      name: 'placeholder',
      problemMessage: '',
      correctionMessage: '',
      description: '',
    ),
  )
  ;

  const EssentialMultiLints(this.code);

  @override
  final LintRuleCode code;
}

/// {@template lint_rule_code}
/// A diagnostic code for a lint rule.
/// {@endtemplate}
class LintRuleCode extends WarningCode implements LintCode {
  /// {@macro lint_rule_code}
  const LintRuleCode({
    required super.name,
    required super.problemMessage,
    required super.correctionMessage,
    required super.description,
    super.severity,
    super.hasPublishedDocs,
    super.uniqueName,
  }) : super(type: DiagnosticType.LINT);
}

/// {@template sub_warnings}
/// A grouping of sub-warnings under a base warning.
/// {@endtemplate}
mixin SubLints on EnumDiagnostic {
  /// The base warning.
  EssentialMultiLints get base;

  @override
  LintRuleCode get code;
}
