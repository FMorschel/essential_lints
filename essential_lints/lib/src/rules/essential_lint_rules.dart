import 'package:analyzer/error/error.dart';
import 'package:essential_lints_annotations/essential_lints_annotations.dart'
    as annotation;
// ignore: implementation_imports internal
import 'package:essential_lints_annotations/src/_internal/static_enforcement.dart';

import '../warnings/essential_lint_warnings.dart';
import 'rule.dart';

/// {@template enum_lint}
/// A mixin for enums that provide a lint rule code.
/// {@endtemplate}
mixin EnumLint on EnumDiagnostic implements LintCode {
  @override
  LintRuleCode get code;
}

/// The list of all essential lint rules.
enum EssentialLintCode with EnumDiagnostic, EnumLint {
  /// Arguments should be in alphabetical order.
  alphabetizeArguments(
    LintRuleCode(
      rule: .alphabetizeArguments,
      problemMessage: 'Arguments should be in alphabetical order.',
      correctionMessage: 'Reorder the arguments alphabetically.',
    ),
  ),

  /// Prefer explicitly named parameters for better readability.
  preferExplicitlyNamedParameter(
    LintRuleCode(
      rule: .preferExplicitlyNamedParameter,
      problemMessage: 'Use explicitly named parameters for better readability.',
      correctionMessage:
          'Change to use explicitly named parameters in function type '
          'declarations.',
    ),
  ),

  /// Double literals should follow the preferred format.
  numericConstantStyle(
    LintRuleCode(
      rule: .numericConstantStyle,
      problemMessage: 'Double literals should follow the preferred format.',
      correctionMessage:
          'Reformat the double literal to match the preferred style.',
    ),
  ),

  /// Prefer using the `last` getter to access the last element of a
  /// list-like object.
  lastGetter(
    LintRuleCode(
      rule: .lastGetter,
      problemMessage:
          'Prefer using the `last` getter to access the last element of a '
          'list-like object.',
      correctionMessage: 'Replace the index access with the `last` getter.',
    ),
  ),

  /// Prefer using the `first` getter to access the first element of a
  /// list-like object.
  firstGetter(
    LintRuleCode(
      rule: .firstGetter,
      problemMessage:
          'Prefer using the `first` getter to access the first element of a '
          'list-like object.',
      correctionMessage: 'Replace the index access with the `first` getter.',
    ),
  ),

  /// Avoid returning Widgets from functions.
  returningWidgets(
    LintRuleCode(
      rule: .returningWidgets,
      problemMessage: 'Avoid returning Widgets from functions.',
      correctionMessage: 'Prefer extracting the widget into a separate class.',
    ),
  ),

  /// Prefer using the padding property of Container instead of wrapping it with
  /// a Padding widget.
  paddingOverContainer(
    LintRuleCode(
      rule: .paddingOverContainer,
      problemMessage:
          'Prefer using the inner padding property from Container over '
          'wrapping with padding.',
      correctionMessage:
          'Use the padding property of Container instead of wrapping it with '
          'a Padding widget.',
    ),
  ),

  /// Detects unnecessary calls to setState in Flutter widgets.
  unnecessarySetstate(
    LintRuleCode(
      rule: .unnecessarySetstate,
      problemMessage: 'Unnecessary calls to setState detected.',
      correctionMessage: 'Remove the unnecessary call to setState.',
    ),
  ),

  /// A rule that detects empty container widgets in Flutter code.
  emptyContainer(
    LintRuleCode(
      rule: .emptyContainer,
      problemMessage: 'Empty Container widget detected.',
      correctionMessage: 'Remove the empty Container widget.',
    ),
  ),

  /// A rule that enforces alphabetical ordering of enum constants.
  alphabetizeEnumConstants(
    LintRuleCode(
      rule: .alphabetizeEnumConstants,
      problemMessage: 'Enum constants should be in alphabetical order.',
      correctionMessage: 'Reorder the enum constants alphabetically.',
    ),
  ),

  /// A lint rule that checks for the use of `Border.all` in Flutter widgets.
  borderAll(
    LintRuleCode(
      rule: .borderAll,
      problemMessage: 'Avoid using Border.all in Flutter widgets.',
      correctionMessage: 'Use Border.fromBorderSide instead of Border.all.',
    ),
  ),

  /// A lint rule that checks for the use of BorderRadius.circular in
  /// Flutter widgets.
  borderRadiusAll(
    LintRuleCode(
      rule: .borderRadiusAll,
      problemMessage: 'Avoid using BorderRadius.circular in Flutter widgets.',
      correctionMessage:
          'Use BorderRadius.all instead of BorderRadius.circular.',
    ),
  ),

  /// A rule that checks for proper phrasing of comments.
  standardCommentStyle(
    LintRuleCode(
      rule: .standardCommentStyle,
      problemMessage: 'Comments should be phrased.',
      correctionMessage:
          'Format comments to end with proper punctuation and capitalization.',
    ),
  ),

  /// A lint rule that enforces direct imports within the same package.
  samePackageDirectImport(
    LintRuleCode(
      rule: .samePackageDirectImport,
      problemMessage:
          'Imports within the same package should be direct imports.',
      correctionMessage: 'Change to a direct import.',
    ),
  ),

  /// A lint rule that detects cascades being used on members that return new
  /// instances.
  newInstanceCascade(
    LintRuleCode(
      rule: .newInstanceCascade,
      problemMessage:
          'Avoid using cascades on members that return new instances.',
      correctionMessage:
          'Do not use cascades on members that return new instances.',
    ),
  ),

  /// A lint rule that checks for usages of `is Future` type checks in
  /// `FutureOr` instances that accept `Future` values.
  isFuture(
    LintRuleCode(
      rule: .isFuture,
      problemMessage:
          'Avoid using `is Future` type checks in `FutureOr` instances that '
          'accept `Future` values.',
      correctionMessage:
          'Remove the `is Future` type check when working with `FutureOr` '
          'instances.',
    ),
  ),

  /// A lint rule that checks for variable declarations that shadow other
  /// variables in the same scope.
  variableShadowing(
    LintRuleCode(
      rule: .variableShadowing,
      problemMessage:
          'Variable declarations should not shadow other variables in the '
          'same scope.',
      correctionMessage:
          'Rename the variable to avoid shadowing another variable in the '
          'same scope.',
    ),
  ),

  /// A lint rule that discourages the use of optional positional parameters
  /// in function declarations.
  optionalPositionalParameters(
    LintRuleCode(
      rule: .optionalPositionalParameters,
      problemMessage:
          'Avoid using optional positional parameters in function '
          'declarations.',
      correctionMessage:
          'Use named parameters instead of optional positional parameters.',
    ),
  ),

  /// A lint rule that checks for closures that have an incorrect type
  /// annotation.
  closureIncorrectType(
    LintRuleCode(
      rule: .closureIncorrectType,
      problemMessage: 'Closure parameter has an incorrect type annotation.',
      correctionMessage:
          'Adjust the type annotation to match the expected type.',
    ),
  ),

  /// A lint rule that checks for the use of Completer.completeError without
  /// providing a stack trace.
  completerErrorNoStack(
    LintRuleCode(
      rule: .completerErrorNoStack,
      problemMessage:
          'Avoid using Completer.completeError without a stack trace.',
      correctionMessage:
          'Provide a stack trace when calling Completer.completeError.',
    ),
  ),

  /// A lint rule that detects equal statements in switch cases.
  equalStatement(
    LintRuleCode(
      rule: .equalStatement,
      problemMessage: 'Avoid using equal statements in switch cases.',
      correctionMessage: 'Agregate {0} cases.',
    ),
  ),

  /// A lint rule that detects duplicate values in comparisons like `&&` and
  /// `||`.
  duplicateValue(
    LintRuleCode(
      rule: .duplicateValue,
      problemMessage: 'Duplicate value detected.',
      correctionMessage: 'Remove the duplicate value.',
    ),
  ),

  /// A lint rule that detects tearing off mutable methods or getters.
  mutableTearoff(
    LintRuleCode(
      rule: .mutableTearoff,
      problemMessage:
          'Avoid tearing off mutable methods or getters to prevent '
          'unintended side effects.',
      correctionMessage:
          'Do not tear off mutable methods or getters; consider using a '
          'different approach.',
    ),
  ),

  /// A lint rule that detects useless else statements.
  uselessElse(
    LintRuleCode(
      rule: .uselessElse,
      problemMessage: 'Useless else statement detected.',
      correctionMessage: 'Remove the useless else statement.',
    ),
  ),

  /// A lint rule that discourages assignment of boolean values in conditions.
  booleanAssignment(
    LintRuleCode(
      rule: .booleanAssignment,
      problemMessage: 'Avoid assigning boolean in conditions.',
      correctionMessage:
          'Refactor the code to use a condition instead of boolean assignment.',
    ),
  ),

  /// A lint rule that detects ambiguous positional boolean parameters in
  /// functions and methods, which can lead to confusion and errors in code.
  ambiguousPositionalBoolean(
    LintRuleCode(
      rule: .ambiguousPositionalBoolean,
      problemMessage:
          'Avoid using ambiguous positional boolean parameters in functions '
          'and methods.',
      correctionMessage:
          'Use named parameters for boolean values to improve readability and '
          'reduce confusion.',
    ),
  ),

  /// A lint rule that warns against explicit `as` casts. Encouraging the use
  /// of type inference or other type-safe approaches instead.
  explicitCasts(
    LintRuleCode(
      rule: .explicitCasts,
      problemMessage: 'Avoid using explicit casts.',
      correctionMessage:
          'Use type inference or other type-safe approaches instead of '
          'explicit casts.',
    ),
  );

  const EssentialLintCode(this.code);

  /// The diagnostic code associated with the lint rule.
  @override
  final LintRuleCode code;
}

/// The list of all essential lint rules.
enum EssentialMultiLints<T extends SubLints>
    with EnumDiagnostic, EnumLint, SuperDiagnostic<T> {
  /// A lint rule that detects pending listeners and reminds developers to
  /// remove them.
  pendingListener(
    LintRuleCode(
      rule: .pendingListener,
      problemMessage: 'Pending listener detected.',
      correctionMessage: 'Remove the pending listener.',
    ),
    PendingListener.values,
  );

  const EssentialMultiLints(this.code, this.subDiagnostics);

  @override
  final LintRuleCode code;

  @override
  final List<T> subDiagnostics;
}

/// {@template lint_rule_code}
/// A diagnostic code for a lint rule.
/// {@endtemplate}
class LintRuleCode extends WarningCode implements LintCode {
  /// {@macro lint_rule_code}
  const LintRuleCode({
    required EssentialLintRule super.rule,
    required super.problemMessage,
    super.correctionMessage,
    super.severity = .INFO,
    super.uniqueName,
  }) : super(type: DiagnosticType.LINT);
}

/// {@template sub_lint_rule_code}
/// A sub diagnostic code for a lint rule.
/// {@endtemplate}
class SubLintRuleCode extends LintRuleCode {
  /// {@macro sub_lint_rule_code}
  const SubLintRuleCode({
    required super.rule,
    required super.uniqueName,
    required super.problemMessage,
    super.correctionMessage,
    super.severity = .INFO,
  });
}

/// {@template pending_listener}
/// Sub-lints for the PendingListener lint rule.
/// {@endtemplate}
@staticAllEnforcement
@StaticEnforcement(#base, annotation.th<EssentialMultiLints>())
enum PendingListener with EnumDiagnostic, SubDiagnostic, SubLints {
  /// Closures used as listeners cannot be matched for removal.
  closuresCannotBeMatched(
    SubLintRuleCode(
      rule: .pendingListener,
      uniqueName: 'closures_cannot_be_matched',
      problemMessage:
          'Closures used as listeners cannot be matched for '
          'removal.',
      correctionMessage:
          'Avoid using closures as listeners to ensure they can be properly '
          'removed.',
    ),
  ),

  /// Unnecessary calls to remove listeners that were never added.
  unnecessaryRemove(
    SubLintRuleCode(
      rule: .pendingListener,
      uniqueName: 'unnecessary_remove',
      problemMessage: 'Unnecessary listener removal detected.',
      correctionMessage: 'Remove the unnecessary listener removal call.',
    ),
  ),

  /// Listener handling at unused instantiation detected.
  listenerInstantiation(
    SubLintRuleCode(
      rule: .pendingListener,
      uniqueName: 'listener_instantiation',
      problemMessage: 'Listener handling at unused instantiation detected.',
      correctionMessage:
          'Make use of this instance or remove it if it is not needed.',
    ),
  );

  const PendingListener(this.code);

  /// All the diagnostics associated with this multi-lint.
  static final List<EnumDiagnostic> all = [...values, base];

  /// The base lint rule.
  static const EssentialMultiLints base = .pendingListener;

  @override
  final SubLintRuleCode code;
}

/// {@template sub_warnings}
/// A grouping of sub-warnings under a base warning.
/// {@endtemplate}

@annotation.SubtypeAnnotating(
  annotations: [StaticEnforcement(#base, annotation.th<EssentialMultiLints>())],
  option: .onlyInstantiable,
)
mixin SubLints on SubDiagnostic implements LintRuleCode {}
