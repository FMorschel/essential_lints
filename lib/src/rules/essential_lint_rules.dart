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
  )
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
