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
  ),

  /// Subtypes should follow specific naming conventions.
  subtypeNaming<SubtypeNaming>(
    WarningCode(
      name: 'subtype_naming',
      problemMessage:
          'The name of this subtype does not follow the required naming '
          'conventions.',
      correctionMessage:
          'Rename the subtype to follow the required naming conventions.',
      description:
          'A lint rule that ensures subtypes follow specific naming '
          'conventions such as required prefixes, suffixes, or containing '
          'names.',
    ),
  ),

  /// Subtypes should be annotated with specific annotations.
  subtypeAnnotating<SubtypeAnnotating>(
    WarningCode(
      name: 'subtype_annotating',
      problemMessage:
          'The subtype is missing required annotations as specified by the '
          '@SubtypeAnnotating annotation.',
      correctionMessage: 'Add the required annotation(s): {0}',
      description:
          'A rule that ensures subtypes are annotated with specific '
          'annotations as defined by the @SubtypeAnnotating annotation.',
    ),
  ),
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

  /// Invalid member list name in GettersInMemberList annotation.
  invalidMemberListName(
    WarningCode(
      name: 'getters_in_member_list',
      problemMessage:
          'Invalid member list name: The name of the member list in the '
          '@GettersInMemberList annotation must be a valid identifier.',
      correctionMessage:
          'Provide a valid member list name in the '
          '@GettersInMemberList annotation.',
      description:
          'A lint rule that ensures the name of the member list in the '
          '@GettersInMemberList annotation is a valid identifier.',
      uniqueName: 'invalid_member_list_name_getters_in_member_list',
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

/// The list of sub-warnings for the SubtypeAnnotating warning.
enum SubtypeAnnotating with EnumDiagnostic, SubWarnings {
  /// The annotation does not specify any required annotations.
  missingAnnotation(
    WarningCode(
      name: 'missing_annotation',
      problemMessage:
          'The @SubtypeAnnotating annotation must specify at least one '
          'required annotation.',
      correctionMessage:
          'Add at least one required annotation to the '
          '@SubtypeAnnotating annotation.',
      description:
          'A lint rule that ensures the @SubtypeAnnotating annotation '
          'specifies at least one required annotation.',
    ),
  ),

  /// The added object a constructor (invocation/tear off) and not just a type
  /// name.
  constructorNotType(
    WarningCode(
      name: 'constructor_not_type',
      problemMessage:
          'The @SubtypeAnnotating annotation should specify type names, not '
          'constructor invocations or tear-offs.',
      correctionMessage:
          'Replace the constructor invocation or tear-off with the type name.',
      description:
          'A lint rule that ensures the @SubtypeAnnotating annotation '
          'specifies type names and not constructor invocations or tear-offs.',
    ),
  ),
  ;

  const SubtypeAnnotating(this.code);

  @override
  final EssentialMultiWarnings base = .subtypeAnnotating;

  @override
  final WarningCode code;
}

/// The list of sub-warnings for the SubtypeNaming warning.
enum SubtypeNaming with EnumDiagnostic, SubWarnings {
  /// The annotation does not specify any naming conventions.
  missingNameDefinition(
    WarningCode(
      name: 'missing_subtype_naming_definition',
      problemMessage:
          'The @SubtypeNaming annotation must specify at least one naming '
          'convention (prefix, suffix, or containing name).',
      correctionMessage:
          'Add at least one naming convention to the @SubtypeNaming '
          'annotation.',
      description:
          'A lint rule that ensures the @SubtypeNaming annotation specifies '
          'at least one naming convention (prefix, suffix, or containing '
          'name).',
    ),
  ),
  ;

  const SubtypeNaming(this.code);

  @override
  final EssentialMultiWarnings base = .subtypeNaming;

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
