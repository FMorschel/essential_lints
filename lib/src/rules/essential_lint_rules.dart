import 'package:analyzer/error/error.dart';

/// The list of all essential lint rules.
enum EssentialLintRules {
  /// Arguments should be in alphabetical order.
  alphabetizeArguments(
    LintCode(
      'alphabetize_arguments',
      'Arguments should be in alphabetical order.',
    ),
  );

  const EssentialLintRules(this.code);

  /// The diagnostic code associated with the lint rule.
  final LintCode code;
}
