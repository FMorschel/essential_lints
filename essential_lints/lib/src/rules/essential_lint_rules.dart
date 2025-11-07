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

  /// Prefer using the `first` property to access the first element of a
  /// list-like object.
  preferFirst(
    RuleCode(
      'prefer_first',
      'Prefer using the `first` property to access the first element of a '
          'list-like object.',
      correctionMessage: 'Replace the index access with the `first` property.',
      description:
          'A lint rule that suggests using the `first` property instead of '
          'accessing the first element of a list-like object using index 0.',
    ),
  ),

  /// Getters should be included in member lists.
  gettersInMemberList(
    RuleCode(
      'getters_in_member_list',
      'All {0} should be included in member lists.',
      correctionMessage: 'Include the missing member(s) {1}',
      description:
          'A lint rule that ensures getters/fields are included in the member '
          'list.',
    ),
  ),

  /// An instance member list is missing to include getters/fields.
  missingInstanceGettersInMemberList(
    RuleCode(
      'getters_in_member_list',
      'The class needs an instance member called {0} to list the members.',
      correctionMessage:
          'Include the missing member {0} or turn the static member into an '
          'instance member.',
      description:
          'A lint rule that ensures getters/fields list instance member is '
          'declared.',
      uniqueName: 'missing_instance_getters_in_member_list',
    ),
  ),

  /// Invalid use of the GettersInMemberList annotation.
  notClassGettersInMemberList(
    RuleCode(
      'getters_in_member_list',
      'The annotation @GettersInMemberList can only be applied to classes.',
      correctionMessage:
          'Remove the @GettersInMemberList annotation from '
          'this declaration or convert it into a class.',
      description:
          'A lint rule that ensures the @GettersInMemberList annotation is '
          'only applied to classes.',
      uniqueName: 'not_class_getters_in_member_list',
    ),
  ),

  /// Empty member list name in GettersInMemberList annotation.
  emptyMemberListNameGettersInMemberList(
    RuleCode(
      'getters_in_member_list',
      'The name of the member list in @GettersInMemberList cannot be empty.',
      correctionMessage:
          'Provide a valid member list name in the '
          '@GettersInMemberList annotation.',
      description:
          'A lint rule that ensures the name of the member list in the '
          '@GettersInMemberList annotation is not empty.',
      uniqueName: 'empty_member_list_name_getters_in_member_list',
    ),
  ),

  /// Invalid member list for GettersInMemberList annotation.
  invalidMemberListGettersInMemberList(
    RuleCode(
      'getters_in_member_list',
      'The declaration of {0} must be a getter or a single field that '
          'returns a literal list containing the members.',
      correctionMessage:
          'Modify the declaration of {0} to be a getter or a single field '
          'that returns a literal list of the members.',
      description:
          'A lint rule that ensures the declaration of the member list is '
          'valid.',
      uniqueName: 'invalid_member_list_getters_in_member_list',
    ),
  ),

  /// Something listed in the member list is not a member of the class.
  nonMemberInGettersInMemberList(
    RuleCode(
      'getters_in_member_list',
      'This is not a member of the class that should be included in the member '
          'list.',
      correctionMessage: 'Remove this from the member list.',
      description:
          'A lint rule that ensures everything listed in the member list is a '
          'valid expected member of the class.',
      uniqueName: 'non_member_in_getters_in_member_list',
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
