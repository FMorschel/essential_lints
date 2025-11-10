import 'package:analyzer/error/error.dart';

/// {@template enum_diagnostic}
/// A mixin for enums that provide a diagnostic code.
/// {@endtemplate}
mixin EnumDiagnostic {
  /// The diagnostic code associated with the enum value.
  DiagnosticCode get code;
}

/// The list of all essential lint rules.
enum EssentialLintWarnings<T extends SubWarnings> implements EnumDiagnostic {
  /// Getters should be included in member lists.
  gettersInMemberList<GettersInMemberListWarnings>(
    WarningCode(
      name: 'getters_in_member_list',
      problemMessage: 'All {0} should be included in member lists.',
      correctionMessage: 'Include the missing member(s) {1}',
      description:
          'A lint rule that ensures getters/fields are included in the member '
          'list.',
      severity: .WARNING,
    ),
  )
  ;

  const EssentialLintWarnings(this.code);

  @override
  final WarningCode code;
}

/// The list of sub-warnings for the GettersInMemberList warning.
enum GettersInMemberListWarnings implements SubWarnings {
  /// An instance member list is missing to include getters/fields.
  missingInstanceGettersInMemberList(
    WarningCode(
      name: 'getters_in_member_list',
      problemMessage:
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
    WarningCode(
      name: 'getters_in_member_list',
      problemMessage:
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
    WarningCode(
      name: 'getters_in_member_list',
      problemMessage:
          'The name of the member list in @GettersInMemberList cannot be '
          'empty.',
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
    WarningCode(
      name: 'getters_in_member_list',
      problemMessage:
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
    WarningCode(
      name: 'getters_in_member_list',
      problemMessage:
          'This is not a member of the class that should be included in the '
          'member list.',
      correctionMessage: 'Remove this from the member list.',
      description:
          'A lint rule that ensures everything listed in the member list is a '
          'valid expected member of the class.',
      uniqueName: 'non_member_in_getters_in_member_list',
    ),
  )
  ;

  const GettersInMemberListWarnings(this.code);

  @override
  final EssentialLintWarnings base = .gettersInMemberList;

  @override
  final WarningCode code;
}

/// {@template sub_warnings}
/// A grouping of sub-warnings under a base warning.
/// {@endtemplate}
final class SubWarnings implements EnumDiagnostic {
  /// {@macro sub_warnings}
  SubWarnings(this.base, this.code);

  /// The base warning.
  final EssentialLintWarnings base;

  @override
  final WarningCode code;
}

/// {@template rule_code}
/// A diagnostic code for warnings.
/// {@endtemplate}
class WarningCode extends DiagnosticCode {
  /// {@macro rule_code}
  const WarningCode({
    required super.name,
    required super.problemMessage,
    required super.correctionMessage,
    required this.description,
    super.hasPublishedDocs,
    this.severity = DiagnosticSeverity.INFO,
    String? uniqueName,
    this.type = DiagnosticType.STATIC_WARNING,
  }) : super(
         uniqueName: uniqueName ?? name,
         isUnresolvedIdentifier: false,
       );

  /// A detailed description of the lint rule.
  final String description;

  @override
  final DiagnosticSeverity severity;

  @override
  final DiagnosticType type;
}
