import 'package:analyzer/error/error.dart';

/// {@template enum_diagnostic}
/// A mixin for enums that provide a diagnostic code.
/// {@endtemplate}
mixin EnumDiagnostic implements DiagnosticCode {
  /// The diagnostic code associated with the enum value.
  DiagnosticCode get code;

  @override
  String? get correctionMessage => code.correctionMessage;

  @override
  // ignore: deprecated_member_use, overriding all members
  DiagnosticSeverity get errorSeverity => code.errorSeverity;

  @override
  bool get hasPublishedDocs => code.hasPublishedDocs;

  @override
  bool get isIgnorable => code.isIgnorable;

  @override
  bool get isUnresolvedIdentifier => code.isUnresolvedIdentifier;

  @override
  String get name => code.name;

  @override
  int get numParameters => code.numParameters;

  @override
  String get problemMessage => code.problemMessage;

  @override
  DiagnosticSeverity get severity => code.severity;

  @override
  DiagnosticType get type => code.type;

  @override
  String get uniqueName => code.uniqueName;

  @override
  String? get url => code.url;
}

/// The list of all essential lint rules.
enum EssentialMultiWarnings<T extends SubWarnings> with EnumDiagnostic {
  /// Getters should be included in member lists.
  gettersInMemberList<GettersInMemberList>(
    WarningCode(
      name: 'getters_in_member_list',
      problemMessage: 'All {0} should be included in member lists.',
      correctionMessage: 'Include the missing member(s) {1}',
      description:
          'A lint rule that ensures getters/fields are included in the member '
          'list.',
    ),
  )
  ;

  const EssentialMultiWarnings(this.code);

  @override
  final WarningCode code;
}

/// The list of sub-warnings for the GettersInMemberList warning.
enum GettersInMemberList with EnumDiagnostic, SubWarnings {
  /// An instance member list is missing to include getters/fields.
  missingList(
    WarningCode(
      name: 'getters_in_member_list',
      problemMessage:
          "The class needs an instance member called '{0}' to list the "
          'members.',
      correctionMessage:
          "Include the missing member '{0}' or turn the static member into an "
          'instance member.',
      description:
          'A lint rule that ensures getters/fields list instance member is '
          'declared.',
      uniqueName: 'missing_instance_getters_in_member_list',
    ),
  ),

  /// Empty member list name in GettersInMemberList annotation.
  emptyMemberListName(
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
  invalidMemberList(
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
  nonMemberIn(
    WarningCode(
      name: 'getters_in_member_list',
      problemMessage:
          'This is not a member of the class that should be included in the '
          'member list.',
      correctionMessage: 'Remove this from the member list.',
      description:
          'A lint rule that ensures everything listed in the member list is a '
          'valid expected instance member of the class.',
      uniqueName: 'non_member_in_getters_in_member_list',
    ),
  )
  ;

  const GettersInMemberList(this.code);

  @override
  final EssentialMultiWarnings base = .gettersInMemberList;

  @override
  final WarningCode code;
}

/// {@template sub_warnings}
/// A grouping of sub-warnings under a base warning.
/// {@endtemplate}
mixin SubWarnings on EnumDiagnostic {
  /// The base warning.
  EssentialMultiWarnings get base;

  @override
  WarningCode get code;
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
    this.severity = .WARNING,
    String? uniqueName,
    this.type = .STATIC_WARNING,
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
