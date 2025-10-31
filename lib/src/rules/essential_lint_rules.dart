import 'package:analyzer/error/error.dart';

/// The list of all essential lint rules.
enum EssentialLintRules {
  /// Arguments should be in alphabetical order.
  alphabetizeArguments(
    RuleCode(
      'alphabetize_arguments',
      'Arguments should be in alphabetical order.',
      correctionMessage: 'Reorder the arguments alphabetically.',
      description:
          'A lint rule that enforces alphabetical ordering of function '
          'arguments.',
    ),
  ),

  /// Prefer explicitly named parameters for better readability.
  preferExplicitlyNamedParameter(
    RuleCode(
      'prefer_explicitly_named_parameter',
      'Use explicitly named parameters for better readability.',
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
    RuleCode(
      'double_literal_format',
      'Double literals should follow the preferred format.',
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
    RuleCode(
      'prefer_last',
      'Prefer using the `last` property to access the last element of a '
          'list-like object.',
      correctionMessage: 'Replace the index access with the `last` property.',
      description:
          'A lint rule that suggests using the `last` property instead of '
          'accessing the last element of a list-like object using length - 1 '
          'index.',
    ),
  ),
  ;

  const EssentialLintRules(this.code);

  /// The diagnostic code associated with the lint rule.
  final RuleCode code;
}

/// {@template rule_code}
/// A diagnostic code for a lint rule.
/// {@endtemplate}
class RuleCode extends LintCode {
  /// {@macro rule_code}
  const RuleCode(
    super.name,
    super.problemMessage, {
    required super.correctionMessage,
    required this.description,
    super.severity,
    super.hasPublishedDocs,
    super.uniqueName,
  });

  /// A detailed description of the lint rule.
  final String description;
}
