import 'dart:math';

import 'package:analyzer/error/error.dart';
import 'package:essential_lints_annotations/essential_lints_annotations.dart'
    as annotation;
// ignore: implementation_imports internal
import 'package:essential_lints_annotations/src/_internal/static_enforcement.dart';

import 'warning.dart';

/// Enforcement to ensure a static list of all diagnostics is present in all
/// multi-lint rules.
const staticAllEnforcement = StaticEnforcement(
  #all,
  annotation.th<List<EnumDiagnostic>>(),
);

/// {@template enum_diagnostic}
/// A mixin for enums that provide a diagnostic code.
/// {@endtemplate}
mixin EnumDiagnostic<Code extends WarningCode<R>, R extends Rule>
    implements DiagnosticCode, WarningCode<R> {
  /// The diagnostic code associated with the enum value.
  Code get code;

  @override
  R get rule => code.rule;

  @override
  String? get correctionMessage => code.correctionMessage;

  @override
  @Deprecated("Use 'diagnosticSeverity' instead")
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
  String? get _uniqueName => code._uniqueName;

  @override
  String get lowerCaseUniqueName => code.lowerCaseUniqueName;

  @override
  String? get url => code.url;
}

/// The list of all essential lint warnings.
enum EssentialLintWarningCode
    with
        EnumDiagnostic<
          WarningCode<EssentialLintWarningRule>,
          EssentialLintWarningRule
        > {
  /// Members of a class should be sorted in a specific order.
  sortingMembers(
    WarningCode(
      rule: .sortingMembers,
      problemMessage:
          'The members of this class are not sorted according to the '
          'required order.',
      correctionMessage:
          'Sort the members of the class to follow the required order.',
    ),
  );

  const EssentialLintWarningCode(this.code);

  @override
  final WarningCode<EssentialLintWarningRule> code;
}

/// The list of all essential lint rules.
enum EssentialMultiWarningCode<
  T extends SubWarnings<Code, R>,
  Code extends SubWarningCode<R>,
  R extends EssentialLintWarningRule
>
    with
        EnumDiagnostic<
          WarningCode<EssentialLintWarningRule>,
          EssentialLintWarningRule
        >,
        SuperDiagnostic<
          T,
          WarningCode<EssentialLintWarningRule>,
          EssentialLintWarningRule
        > {
  /// Getters should be included in member lists.
  gettersInMemberList(
    WarningCode(
      rule: .gettersInMemberList,
      problemMessage: 'All {0} should be included in member lists.',
      correctionMessage: 'Include the missing member(s) {1}',
    ),
    GettersInMemberList.values,
  ),

  /// Subtypes should follow specific naming conventions.
  subtypeNaming(
    WarningCode(
      rule: .subtypeNaming,
      problemMessage:
          'The name of this subtype does not follow the required naming '
          'conventions.',
      correctionMessage:
          'Rename the subtype to follow the required naming conventions.',
    ),
    SubtypeNaming.values,
  ),

  /// Subtypes should be annotated with specific annotations.
  subtypeAnnotating(
    WarningCode(
      rule: .subtypeAnnotating,
      problemMessage:
          'The subtype is missing required annotations as specified by the '
          '@SubtypeAnnotating annotation.',
      correctionMessage: 'Add the required annotation(s): {0}',
    ),
    SubtypeAnnotating.values,
  );

  const EssentialMultiWarningCode(this.code, this.subDiagnostics);

  @override
  final WarningCode<EssentialLintWarningRule> code;

  @override
  final List<T> subDiagnostics;
}

/// Represents a base diagnostic for mutlti diagnostic rules that have
/// sub-diagnostics.
mixin SuperDiagnostic<
  Base extends SubDiagnostic<Code, R>,
  Code extends WarningCode<R>,
  R extends Rule
>
    implements EnumDiagnostic<Code, R> {
  /// Sub diagnostics associated with this diagnostic.
  List<Base> get subDiagnostics;

  /// All diagnostics associated with this diagnostic, including
  /// sub-diagnostics.
  List<EnumDiagnostic<Code, R>> get all => [...subDiagnostics, this];
}

/// The list of sub-warnings for the GettersInMemberList warning.
@staticAllEnforcement
@StaticEnforcement(#base, annotation.th<EssentialMultiWarningCode>())
enum GettersInMemberList
    with
        EnumDiagnostic<
          SubWarningCode<EssentialLintWarningRule>,
          EssentialLintWarningRule
        >,
        SubDiagnostic,
        SubWarnings {
  /// An instance member list is missing to include getters/fields.
  missingList(
    SubWarningCode(
      rule: .gettersInMemberList,
      uniqueName: 'missing_instance_getters_in_member_list',
      problemMessage:
          "The class needs a{1} member called '{0}' to list the "
          'members.',
      correctionMessage:
          "Include the missing member '{0}' or turn the static member into "
          'a{1} member.',
    ),
  ),

  /// Invalid member list name in GettersInMemberList annotation.
  invalidMemberListName(
    SubWarningCode(
      rule: .gettersInMemberList,
      uniqueName: 'invalid_member_list_name_getters_in_member_list',
      problemMessage:
          'Invalid member list name: The name of the member list in the '
          '@GettersInMemberList annotation must be a valid identifier.',
      correctionMessage:
          'Provide a valid member list name in the '
          '@GettersInMemberList annotation.',
    ),
  ),

  /// Invalid member list for GettersInMemberList annotation.
  invalidMemberList(
    SubWarningCode(
      rule: .gettersInMemberList,
      uniqueName: 'invalid_member_list_getters_in_member_list',
      problemMessage:
          'The declaration of {0} must be a getter or a single field that '
          'returns a literal list containing the members.',
      correctionMessage:
          'Modify the declaration of {0} to be a getter or a single field '
          'that returns a literal list of the members.',
    ),
  ),

  /// Something listed in the member list is not a member of the class.
  nonMemberIn(
    SubWarningCode(
      rule: .gettersInMemberList,
      uniqueName: 'non_member_in_getters_in_member_list',
      problemMessage:
          'This is not a member of the class that should be included in the '
          'member list.',
      correctionMessage: 'Remove this from the member list.',
    ),
  );

  const GettersInMemberList(this.code);

  /// The list of all SubtypeNaming sub-warnings.
  static const List<EnumDiagnostic> all = [...values, base];

  /// The base warning.
  static const EssentialMultiWarningCode base = .gettersInMemberList;

  @override
  final SubWarningCode code;
}

/// The list of sub-warnings for the SubtypeAnnotating warning.
@staticAllEnforcement
@StaticEnforcement(#base, annotation.th<EssentialMultiWarningCode>())
enum SubtypeAnnotating
    with
        EnumDiagnostic<
          SubWarningCode<EssentialLintWarningRule>,
          EssentialLintWarningRule
        >,
        SubDiagnostic,
        SubWarnings {
  /// The annotation does not specify any required annotations.
  missingAnnotation(
    SubWarningCode(
      rule: .subtypeAnnotating,
      uniqueName: 'missing_annotation',
      problemMessage:
          'The @SubtypeAnnotating annotation must specify at least one '
          'required annotation.',
      correctionMessage:
          'Add at least one required annotation to the '
          '@SubtypeAnnotating annotation.',
    ),
  ),

  /// The added object a constructor (invocation/tear off) and not just a type
  /// name.
  constructorNotType(
    SubWarningCode(
      rule: .subtypeAnnotating,
      uniqueName: 'constructor_not_type',
      problemMessage:
          'The @SubtypeAnnotating annotation should specify type names, not '
          'constructor invocations or tear-offs.',
      correctionMessage:
          'Replace the constructor invocation or tear-off with the type name.',
    ),
  ),

  /// Unnecessary @SubtypeDeannotating annotation when there are no matching
  /// @SubtypeAnnotating annotations in the supertypes.
  unnecessaryDeannotatingAnnotation(
    SubWarningCode(
      rule: .subtypeAnnotating,
      uniqueName: 'unnecessary_deannotating_annotation',
      problemMessage:
          'The @SubtypeDeannotating annotation is unnecessary because there '
          'are no matching @SubtypeAnnotating annotations in the supertypes.',
      correctionMessage:
          'Remove the unnecessary @SubtypeDeannotating annotation.',
    ),
  );

  /// Checks if two elements are from the same package, used for package-level

  const SubtypeAnnotating(this.code);

  /// The list of all SubtypeAnnotating sub-warnings.
  static const List<EnumDiagnostic> all = [...values, base];

  /// The base warning.
  static const EssentialMultiWarningCode base = .subtypeAnnotating;

  @override
  final SubWarningCode code;
}

/// The list of sub-warnings for the SubtypeNaming warning.
@staticAllEnforcement
@StaticEnforcement(#base, annotation.th<EssentialMultiWarningCode>())
enum SubtypeNaming
    with
        EnumDiagnostic<
          SubWarningCode<EssentialLintWarningRule>,
          EssentialLintWarningRule
        >,
        SubDiagnostic,
        SubWarnings {
  /// The annotation does not specify any naming conventions.
  missingNameDefinition(
    SubWarningCode(
      rule: .subtypeNaming,
      uniqueName: 'missing_subtype_naming_definition',
      problemMessage:
          'The @SubtypeNaming annotation must specify at least one naming '
          'convention (prefix, suffix, or containing name).',
      correctionMessage:
          'Add at least one naming convention to the @SubtypeNaming '
          'annotation.',
    ),
  ),

  /// Unnecessary @SubtypeUnnaming annotation when there are no matching
  /// @SubtypeNaming annotations in the supertypes.
  unnecessaryUnnamingAnnotation(
    SubWarningCode(
      rule: .subtypeNaming,
      uniqueName: 'unnecessary_unnaming_annotation',
      problemMessage:
          'The @SubtypeUnnaming annotation is unnecessary because there are no '
          'matching @SubtypeNaming annotations in the supertypes.',
      correctionMessage: 'Remove the unnecessary @SubtypeUnnaming annotation.',
    ),
  );

  const SubtypeNaming(this.code);

  /// The list of all SubtypeNaming sub-warnings.
  static const List<EnumDiagnostic> all = [...values, base];

  /// The base warning.
  static const EssentialMultiWarningCode base = .subtypeNaming;

  @override
  final SubWarningCode code;
}

/// {@template sub_warning_code}
/// A sub diagnostic code for a warning rule.
/// {@endtemplate}
class SubWarningCode<R extends EssentialLintWarningRule>
    extends WarningCode<R> {
  /// {@macro sub_warning_code}
  const SubWarningCode({
    required super.rule,
    required super.uniqueName,
    required super.problemMessage,
    required super.correctionMessage,
    super.severity = .INFO,
  });
}

/// {@template sub_warnings}
/// A grouping of sub-warnings under a base warning.
/// {@endtemplate}
@annotation.SubtypeAnnotating(
  annotations: [
    StaticEnforcement(#base, annotation.th<EssentialMultiWarningCode>()),
  ],
  option: .onlyInstantiable,
)
mixin SubWarnings<
  Code extends SubWarningCode<R>,
  R extends EssentialLintWarningRule
>
    on SubDiagnostic<Code, R> {}

/// {@template sub_warnings}
/// A grouping of sub-warnings under a base warning.
/// {@endtemplate}
@annotation.SubtypeAnnotating(
  annotations: [staticAllEnforcement],
  option: .onlyInstantiable,
)
mixin SubDiagnostic<Code extends WarningCode<R>, R extends Rule>
    on EnumDiagnostic<Code, R> {}

/// {@template rule_code}
/// A diagnostic code for warnings.
/// {@endtemplate}
class WarningCode<R extends Rule> implements DiagnosticCode {
  /// {@macro rule_code}
  const WarningCode({
    required this.rule,
    required this.problemMessage,
    this.correctionMessage,
    this.severity = .WARNING,
    String? uniqueName,
    this.type = .STATIC_WARNING,
  }) : _uniqueName = uniqueName;

  /// Regular expression for identifying positional arguments in error messages.
  static final RegExp _positionalArgumentRegExp = RegExp(r'\{(\d+)\}');

  @override
  @Deprecated("Use 'diagnosticSeverity' instead")
  DiagnosticSeverity get errorSeverity => severity;

  /// Whether a finding of this diagnostic is ignorable via comments such as
  /// `// ignore:` or `// ignore_for_file:`.
  @override
  bool get isIgnorable => severity != DiagnosticSeverity.ERROR;

  /// The name of the error code, converted to all lower case.
  @override
  // ignore: deprecated_member_use_from_same_package necessary
  String get lowerCaseName => name.toLowerCase();

  /// The unique name of this error code, converted to all lower case.
  @override
  // ignore: deprecated_member_use_from_same_package necessary
  String get lowerCaseUniqueName => uniqueName.toLowerCase();

  @override
  @Deprecated('Please use lowerCaseName')
  String get name => rule.name;

  /// The human-readable rule information.
  String get description => rule.name;

  @override
  @Deprecated('Please use lowerCaseUniqueName')
  String get uniqueName => _uniqueName ?? rule.name;

  final String? _uniqueName;

  @override
  int get numParameters {
    var result = 0;
    for (var s in [problemMessage, ?correctionMessage]) {
      for (var match in _positionalArgumentRegExp.allMatches(s)) {
        result = max(result, int.parse(match.group(1)!) + 1);
      }
    }
    return result;
  }

  /// The human-readable rule information.
  final R rule;

  @override
  final DiagnosticSeverity severity;

  @override
  final DiagnosticType type;

  @override
  final String? correctionMessage;

  @override
  final String problemMessage;

  @override
  bool get hasPublishedDocs => false;

  @override
  bool get isUnresolvedIdentifier => false;

  @override
  String? get url => null;
}
