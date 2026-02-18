import 'package:analyzer/error/error.dart';
import 'package:essential_lints_annotations/essential_lints_annotations.dart'
    as annotation;
// ignore: implementation_imports internal
import 'package:essential_lints_annotations/src/_internal/static_enforcement.dart';

/// Enforcement to ensure a static list of all diagnostics is present in all
/// multi-lint rules.
const staticAllEnforcement = StaticEnforcement(
  #all,
  annotation.th<List<EnumDiagnostic>>(),
);

/// {@template enum_diagnostic}
/// A mixin for enums that provide a diagnostic code.
/// {@endtemplate}
mixin EnumDiagnostic
    implements
        DiagnosticCode,
        WarningCode,
        // TODO(FMorschel): Remove this once the new version of
        //  `analysis_server_plugin` is released.
        LintCode {
  /// The diagnostic code associated with the enum value.
  WarningCode get code;

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
  @Deprecated('Use lowercaseName instead')
  String get name => code.name;

  @override
  String get lowerCaseName => code.lowerCaseName;

  @override
  int get numParameters => code.numParameters;

  @override
  String get problemMessage => code.problemMessage;

  @override
  DiagnosticSeverity get severity => code.severity;

  @override
  DiagnosticType get type => code.type;

  @override
  String get description => code.description;

  @override
  @Deprecated('Use lowercaseUniqueName instead')
  String get uniqueName => code.uniqueName;

  @override
  String get lowerCaseUniqueName => code.lowerCaseUniqueName;

  @override
  String? get url => code.url;
}

/// The list of all essential lint warnings.
enum EssentialLintWarnings with EnumDiagnostic {
  /// Members of a class should be sorted in a specific order.
  sortingMembers(
    WarningCode(
      name: 'sorting_members',
      problemMessage:
          'The members of this class are not sorted according to the '
          'required order.',
      correctionMessage:
          'Sort the members of the class to follow the required order.',
      description:
          'A rule that ensures the members of a class are sorted in a '
          'specific order.',
    ),
  ),
  ;

  const EssentialLintWarnings(this.code);

  @override
  final WarningCode code;
}

/// The list of all essential lint rules.
enum EssentialMultiWarnings<T extends SubWarnings>
    with EnumDiagnostic, SuperDiagnostic<T> {
  /// Getters should be included in member lists.
  gettersInMemberList(
    WarningCode(
      name: 'getters_in_member_list',
      problemMessage: 'All {0} should be included in member lists.',
      correctionMessage: 'Include the missing member(s) {1}',
      description:
          'A lint rule that ensures getters/fields are included in the member '
          'list.',
    ),
    GettersInMemberList.values,
  ),

  /// Subtypes should follow specific naming conventions.
  subtypeNaming(
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
    SubtypeNaming.values,
  ),

  /// Subtypes should be annotated with specific annotations.
  subtypeAnnotating(
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
    SubtypeAnnotating.values,
  ),
  ;

  const EssentialMultiWarnings(this.code, this.subDiagnostics);

  @override
  final WarningCode code;

  @override
  final List<T> subDiagnostics;
}

/// Represents a base diagnostic for mutlti diagnostic rules that have
/// sub-diagnostics.
mixin SuperDiagnostic<Base extends SubDiagnostic> implements EnumDiagnostic {
  /// Sub diagnostics associated with this diagnostic.
  List<Base> get subDiagnostics;

  /// All diagnostics associated with this diagnostic, including
  /// sub-diagnostics.
  List<EnumDiagnostic> get all => [...subDiagnostics, this];
}

/// The list of sub-warnings for the GettersInMemberList warning.
@staticAllEnforcement
@StaticEnforcement(
  #base,
  annotation.th<EssentialMultiWarnings>(),
)
enum GettersInMemberList with EnumDiagnostic, SubDiagnostic, SubWarnings {
  /// An instance member list is missing to include getters/fields.
  missingList(
    WarningCode(
      name: 'getters_in_member_list',
      problemMessage:
          "The class needs a{1} member called '{0}' to list the "
          'members.',
      correctionMessage:
          "Include the missing member '{0}' or turn the static member into "
          'a{1} member.',
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

  /// The list of all SubtypeNaming sub-warnings.
  static const List<EnumDiagnostic> all = [...values, base];

  /// The base warning.
  static const EssentialMultiWarnings base = .gettersInMemberList;

  @override
  final WarningCode code;
}

/// The list of sub-warnings for the SubtypeAnnotating warning.
@staticAllEnforcement
@StaticEnforcement(
  #base,
  annotation.th<EssentialMultiWarnings>(),
)
enum SubtypeAnnotating with EnumDiagnostic, SubDiagnostic, SubWarnings {
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

  /// The list of all SubtypeAnnotating sub-warnings.
  static const List<EnumDiagnostic> all = [...values, base];

  /// The base warning.
  static const EssentialMultiWarnings base = .subtypeAnnotating;

  @override
  final WarningCode code;
}

/// The list of sub-warnings for the SubtypeNaming warning.
@staticAllEnforcement
@StaticEnforcement(
  #base,
  annotation.th<EssentialMultiWarnings>(),
)
enum SubtypeNaming with EnumDiagnostic, SubDiagnostic, SubWarnings {
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

  /// The list of all SubtypeNaming sub-warnings.
  static const List<EnumDiagnostic> all = [...values, base];

  /// The base warning.
  static const EssentialMultiWarnings base = .subtypeNaming;

  @override
  final WarningCode code;
}

/// {@template sub_warnings}
/// A grouping of sub-warnings under a base warning.
/// {@endtemplate}
@annotation.SubtypeAnnotating(
  annotations: [
    StaticEnforcement(
      #base,
      annotation.th<EssentialMultiWarnings>(),
    ),
  ],
  option: .onlyInstantiable,
)
mixin SubWarnings on SubDiagnostic {
  @override
  WarningCode get code;
}

/// {@template sub_warnings}
/// A grouping of sub-warnings under a base warning.
/// {@endtemplate}
@annotation.SubtypeAnnotating(
  annotations: [staticAllEnforcement],
  option: .onlyInstantiable,
)
mixin SubDiagnostic on EnumDiagnostic {
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
