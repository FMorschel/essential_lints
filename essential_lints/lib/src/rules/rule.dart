import '../utils/base_visitor.dart';
import '../warnings/warning.dart';
import 'analysis_rule.dart';
import 'essential_lint_rules.dart';

/// The enum for all the essential lint rules, containing their names and
/// descriptions.
enum EssentialLintRule implements Rule {
  /// Arguments should be in alphabetical order.
  alphabetizeArguments(
    name: 'alphabetize_arguments',
    description:
        'A lint rule that enforces alphabetical ordering of function '
        'arguments.',
  ),

  /// Prefer explicitly named parameters for better readability.
  preferExplicitlyNamedParameter(
    name: 'prefer_explicitly_named_parameter',
    description:
        'A lint rule that encourages the use of explicitly named parameters '
        'in function type declarations for improved code clarity and '
        'completion.',
  ),

  /// Double literals should follow the preferred format.
  numericConstantStyle(
    name: 'numeric_constant_style',
    description:
        'A lint rule that enforces a consistent format for double literals '
        'in the codebase.',
  ),

  /// Prefer using the `last` getter to access the last element of a
  /// list-like object.
  lastGetter(
    name: 'last_getter',
    description:
        'A lint rule that suggests using the `last` getter instead of '
        'accessing the last element of a list-like object using length - 1 '
        'index.',
  ),

  /// Prefer using the `first` getter to access the first element of a
  /// list-like object.
  firstGetter(
    name: 'first_getter',
    description:
        'A lint rule that suggests using the `first` getter instead of '
        'accessing the first element of a list-like object using 0 index.',
  ),

  /// Avoid returning Widgets from functions.
  returningWidgets(
    name: 'returning_widgets',
    description:
        'A lint rule that discourages returning Widgets from functions and '
        'encourages extracting them into separate classes for better code '
        'organization and reusability.',
  ),

  /// Prefer using the padding property of Container instead of wrapping it with
  /// a Padding widget.
  paddingOverContainer(
    name: 'padding_over_container',
    description:
        'A lint rule that suggests using the padding property of Container '
        'instead of wrapping it with a Padding widget.',
  ),

  /// Detects unnecessary calls to setState in Flutter widgets.
  unnecessarySetstate(
    name: 'unnecessary_setstate',
    description:
        'A lint rule that detects and flags unnecessary calls to setState '
        'in State classes.',
  ),

  /// A rule that detects empty container widgets in Flutter code.
  emptyContainer(
    name: 'empty_container',
    description:
        'A lint rule that detects empty Container widgets in Flutter code.',
  ),

  /// A rule that enforces alphabetical ordering of enum constants.
  alphabetizeEnumConstants(
    name: 'alphabetize_enum_constants',
    description:
        'A lint rule that enforces alphabetical ordering of enum constants.',
  ),

  /// A lint rule that checks for the use of `Border.all` in Flutter widgets.
  borderAll(
    name: 'border_all',
    description:
        'A lint rule that checks for the use of Border.all in Flutter '
        'widgets.',
  ),

  /// A lint rule that checks for the use of BorderRadius.circular in
  /// Flutter widgets.
  borderRadiusAll(
    name: 'border_radius_all',
    description:
        'A lint rule that checks for the use of BorderRadius.circular in '
        'Flutter widgets.',
  ),

  /// A rule that checks for proper phrasing of comments.
  standardCommentStyle(
    name: 'standard_comment_style',
    description: 'A lint rule that checks for proper phrasing of comments.',
  ),

  /// A lint rule that enforces direct imports within the same package.
  samePackageDirectImport(
    name: 'same_package_direct_import',
    description:
        'A lint rule that enforces direct imports within the same package.',
  ),

  /// A lint rule that detects cascades being used on members that return new
  /// instances.
  newInstanceCascade(
    name: 'new_instance_cascade',
    description:
        'A lint rule that detects cascades being used on members that return '
        'new instances.',
  ),

  /// A lint rule that checks for usages of `is Future` type checks in
  /// `FutureOr` instances that accept `Future` values.
  isFuture(
    name: 'is_future',
    description:
        'A lint rule that checks for usages of `is Future` type checks in '
        '`FutureOr` instances that accept `Future` values.',
  ),

  /// A lint rule that checks for variable declarations that shadow other
  /// variables in the same scope.
  variableShadowing(
    name: 'variable_shadowing',
    description:
        'A lint rule that checks for variable declarations that shadow other '
        'variables in the same scope.',
  ),

  /// A lint rule that discourages the use of optional positional parameters
  /// in function declarations.
  optionalPositionalParameters(
    name: 'optional_positional_parameters',
    description:
        'A lint rule that discourages the use of optional positional '
        'parameters in function declarations.',
  ),

  /// A lint rule that checks for closures that have an incorrect type
  /// annotation.
  closureIncorrectType(
    name: 'closure_incorrect_type',
    description:
        'A lint rule that checks for closures that have an incorrect type '
        'annotation.',
  ),

  /// A lint rule that checks for the use of Completer.completeError without
  /// providing a stack trace.
  completerErrorNoStack(
    name: 'completer_error_no_stack',
    description:
        'A lint rule that checks for the use of Completer.completeError '
        'without providing a stack trace.',
  ),

  /// A lint rule that detects equal statements in switch cases.
  equalStatement(
    name: 'equal_statement',
    description: 'A lint rule for equal statements under switch cases.',
  ),

  /// A lint rule that detects duplicate values in comparisons like `&&` and
  /// `||`.
  duplicateValue(
    name: 'duplicate_value',
    description:
        'A lint rule that detects duplicate values in comparisons like `&&` '
        'and `||`.',
  ),

  /// A lint rule that detects tearing off mutable methods or getters.
  mutableTearoff(
    name: 'mutable_tearoff',
    description:
        'A lint rule that detects tearing off mutable methods or getters, '
        'which can lead to unintended side effects if the underlying state '
        'changes.',
  ),

  /// A lint rule that detects useless else statements.
  uselessElse(
    name: 'useless_else',
    description:
        'A lint rule that detects and suggests to remove useless else '
        'statements that are not necessary for control flow.',
  ),

  /// A lint rule that discourages assignment of boolean values in conditions.
  booleanAssignment(
    name: 'boolean_assignment',
    description:
        'A lint rule that discourages assignment of boolean values, '
        'encouraging the use of conditions for better code clarity and '
        'maintainability.',
  ),

  /// A lint rule that detects ambiguous positional boolean parameters in
  /// functions and methods, which can lead to confusion and errors in code.
  ambiguousPositionalBoolean(
    name: 'ambiguous_positional_boolean',
    description:
        'A lint rule that detects ambiguous positional boolean parameters in '
        'functions and methods, which can lead to confusion and errors in '
        'code.',
  ),

  /// A lint rule that detects pending listeners and reminds developers to
  /// remove them.
  pendingListener(
    name: 'pending_listener',
    description:
        'A lint rule that detects pending listeners and reminds developers '
        'to remove them.',
  );

  const EssentialLintRule({required this.name, required this.description});

  @override
  final String name;

  @override
  final String description;
}

/// {@template rule}
/// The base class for all essential lint rules.
/// {@endtemplate}
// ignore: avoid_types_as_parameter_names
abstract class LintRule<Rule extends LintRule<Rule>>
    extends EssentialAnalysisRule<Rule, BaseVisitor<Rule>, EssentialLintCode> {
  /// {@macro rule}
  LintRule(super.rule, super.logger);
}

/// {@template rule}
/// The base class for all essential multi-lints rules.
/// {@endtemplate}
abstract class MultiLintRule<
  R extends MultiLintRule<R, Sub>,
  Sub extends SubLints<SubLintRuleCode<EssentialLintRule>, EssentialLintRule>
>
    extends
        EssentialMultiAnalysisRule<
          R,
          BaseVisitor<R>,
          EssentialMultiLints<Sub>,
          Sub,
          LintRuleCode,
          EssentialLintRule
        > {
  /// {@macro rule}
  MultiLintRule(super.rule, super.logger);
}
