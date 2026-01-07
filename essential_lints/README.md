# essential_lints

A comprehensive collection of custom lint rules for Dart and Flutter projects, complete with quick fixes and assists. This package helps enforce best practices, catch common mistakes, and maintain code quality across your codebase.

## Features

This package provides **20+ lint rules** organized into several categories:

### Code Quality & Best Practices

- **`alphabetize_arguments`** - Enforces alphabetical ordering of named function arguments for consistency
  - *Note: This rule currently doesn't take into consideration whether `sort_child_properties_last` is active. See [dart-lang/sdk#61770](https://github.com/dart-lang/sdk/issues/61770)*
- **`alphabetize_enum_constants`** - Keeps enum constants in alphabetical order
- **`prefer_explicitly_named_parameter`** - Encourages explicit parameter names in function type declarations
- **`same_package_direct_import`** - Enforces direct imports within the same package (avoid importing exports)
- **`standard_comment_style`** - Ensures comments follow proper capitalization and punctuation
- **`useless_else`** - Detects and removes unnecessary else statements after return/throw

### Type Safety & Correctness

- **`boolean_assignment`** - Detects assignments where a condition was likely intended
- **`closure_incorrect_type`** - Catches closures with incorrect type annotations
- **`is_future`** - Warns about problematic `is Future` type checks in FutureOr contexts
- **`variable_shadowing`** - Prevents variable declarations that shadow outer scope variables
- **`duplicate_value`** - Detects duplicate values in boolean expressions (`&&`, `||`)
- **`equal_statement`** - Identifies identical statements in switch cases that should be combined
- **`mutable_tearoff`** - Warns against tearing off mutable methods/getters

### Function Design

- **`optional_positional_parameters`** - Discourages optional positional parameters in favor of named parameters

### Async/Future Handling

- **`completer_error_no_stack`** - Ensures `Completer.completeError` includes a stack trace

### Flutter-Specific Rules

- **`border_all`** - Suggests `Border.fromBorderSide` over `Border.all` for better performance
- **`border_radius_all`** - Recommends `BorderRadius.all` over `BorderRadius.circular` for better performance
- **`empty_container`** - Detects empty Container widgets that should use `SizedBox.shrink()` for better performance
- **`first_getter`** - Suggests using `.first` instead of `[0]` for list access
- **`last_getter`** - Suggests using `.last` instead of `[length - 1]` for list access
- **`new_instance_cascade`** - Detects cascade notation on methods returning new instances
- **`numeric_constant_style`** - Enforces consistent formatting for numeric literals
- **`padding_over_container`** - Recommends using `Container.padding` property over wrapping with `Padding` widget
- **`pending_listener`** - Detects listeners that are added but never removed
- **`returning_widgets`** - Discourages returning widgets from functions (prefer extracting to `Widget` classes)
- **`unnecessary_setstate`** - Flags unnecessary `setState` calls

### Configurable Warning Rules

These rules use annotations from the [`essential_lints_annotations`](https://pub.dev/packages/essential_lints_annotations) package:

- **`getters_in_member_list`** - Ensures getters/fields are included in designated member lists
- **`subtype_annotating`** - Requires specific annotations on subtypes
- **`subtype_naming`** - Enforces naming conventions (prefix/suffix/containing) on subtypes

## Getting started

### Installation

Add `essential_lints` in your `analysis_options.yaml` plugins:

```yaml
plugins:
  essential_lints:
    version: ^0.1.6
    diagnostics:
      - alphabetize_arguments
      - alphabetize_enum_constants
      - boolean_assignment
      - border_all
      - border_radius_all
      - closure_incorrect_type
      - completer_error_no_stack
      - duplicate_value
      - empty_container
      - equal_statement
      - first_getter
      - is_future
      - last_getter
      - mutable_tearoff
      - new_instance_cascade
      - numeric_constant_style
      - optional_positional_parameters
      - padding_over_container
      - pending_listener
      - prefer_explicitly_named_parameter
      - returning_widgets
      - same_package_direct_import
      - standard_comment_style
      - unnecessary_setstate
      - useless_else
      - variable_shadowing
```

Or enable them selectively based on your needs.

If you plan to use the configurable warning rules (`getters_in_member_list`, `subtype_annotating`, `subtype_naming`), also add to your `pubspec.yaml`:

```yaml
dependencies:
  essential_lints_annotations: ^0.1.1
```

## Usage

Most rules work automatically once enabled. Here are examples for key rules:

### Alphabetize Arguments

```dart
// ✗ Bad - arguments not in alphabetical order
Widget build(BuildContext context) {
  return Container(
    width: 100,
    height: 50,
    color: Colors.blue,
  );
}

// ✓ Good - arguments in alphabetical order
Widget build(BuildContext context) {
  return Container(
    color: Colors.blue,
    height: 50,
    width: 100,
  );
}
```

### First/Last Getter

```dart
// ✗ Bad
final firstItem = list[0];
final lastItem = list[list.length - 1];

// ✓ Good
final firstItem = list.first;
final lastItem = list.last;
```

### Useless Else

```dart
// ✗ Bad - else is unnecessary after return
String getName(bool condition) {
  if (condition) {
    return 'John';
  } else {
    return 'Jane';
  }
}

// ✓ Good
String getName(bool condition) {
  if (condition) {
    return 'John';
  }
  return 'Jane';
}
```

### Variable Shadowing

```dart
// ✗ Bad - 'name' shadows outer variable
void processUser(String name) {
  users.forEach((user) {
    final name = user.name; // Shadows parameter
    print(name);
  });
}

// ✓ Good
void processUser(String name) {
  users.forEach((user) {
    final userName = user.name;
    print(userName);
  });
}
```

### Padding Over Container

```dart
// ✗ Bad
Padding(
  padding: EdgeInsets.all(16),
  child: Container(
    color: Colors.blue,
    child: Text('Hello'),
  ),
)

// ✓ Good
Container(
  padding: EdgeInsets.all(16),
  color: Colors.blue,
  child: Text('Hello'),
)
```

### Configurable Rules with Annotations

For detailed examples of `getters_in_member_list`, `subtype_annotating`, and `subtype_naming`, see the [`essential_lints_annotations` documentation](https://pub.dev/packages/essential_lints_annotations).

## Quick Fixes

Many rules come with automatic quick fixes that you can apply in your IDE:

- **Alphabetize arguments** - Automatically reorder arguments
- **Use first/last getter** - Replace index access with getter
- **Remove useless else** - Strip unnecessary else keywords
- **Format numeric literals** - Apply consistent formatting
- **Use padding property** - Move padding into Container
- **Replace with SizedBox.shrink()** - Replace empty containers
- **Sort enum constants** - Alphabetize enum values
- **Add stack trace** - Add StackTrace.current to completeError calls
- And many more...

Simply place your cursor on the diagnostic and use your IDE's quick fix action (typically `Ctrl+.`/`Cmd+.` for VS Code or `Alt+Enter` for IntelliJ).

## Additional information

### Acknowledgments

Several rules in this package are inspired by [dart_code_metrics](https://pub.dev/packages/dart_code_metrics) (now available at <https://dcm.dev/>). We're grateful to the DCM team for their pioneering work in Dart linting:

- `border_all` - [original implementation](https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/avoid_border_all/avoid_border_all_rule.dart)
- `border_radius_all` - [original implementation](https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/prefer_const_border_radius/prefer_const_border_radius_rule.dart)
- `first_getter` - [original implementation](https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/prefer_first/prefer_first_rule.dart)
- `last_getter` - [original implementation](https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/prefer_last/prefer_last_rule.dart)
- `numeric_constant_style` - [original implementation](https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/double_literal_format/double_literal_format_rule.dart)
- `padding_over_container` - [original implementation](https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/avoid_wrapping_in_padding/avoid_wrapping_in_padding_rule.dart)
- `pending_listener` - [original implementation](https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/always_remove_listener/always_remove_listener_rule.dart)
- `prefer_explicitly_named_parameter` - [original documentation](https://dcm.dev/docs/rules/common/prefer-explicit-parameter-names/)
- `returning_widgets` - [original implementation](https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/avoid_returning_widgets/avoid_returning_widgets_rule.dart)
- `standard_comment_style` - [original implementation](https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/format_comment/format_comment_rule.dart)
- `unnecessary_setstate` - [original implementation](https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/avoid_unnecessary_setstate/avoid_unnecessary_setstate_rule.dart)

Other rules are based on feature requests and discussions in the [Dart SDK issue tracker](https://github.com/dart-lang/sdk/issues):

- `boolean_assignment` - [dart-lang/sdk#60208](https://github.com/dart-lang/sdk/issues/60208)
- `closure_incorrect_type` - [dart-lang/sdk#59114](https://github.com/dart-lang/sdk/issues/59114)
- `completer_error_no_stack` - [dart-lang/sdk#59374](https://github.com/dart-lang/sdk/issues/59374)
- `duplicate_value` - [dart-lang/sdk#59530](https://github.com/dart-lang/sdk/issues/59530)
- `equal_statement` - [dart-lang/sdk#59529](https://github.com/dart-lang/sdk/issues/59529)
- `is_future` - [dart-lang/sdk#59355](https://github.com/dart-lang/sdk/issues/59355)
- `mutable_tearoff` - [dart-lang/sdk#59510](https://github.com/dart-lang/sdk/issues/59510)
- `new_instance_cascade` - [dart-lang/sdk#59754](https://github.com/dart-lang/sdk/issues/59754)
- `optional_positional_parameters` - [dart-lang/sdk#59097](https://github.com/dart-lang/sdk/issues/59097)
- `useless_else` - [dart-lang/sdk#59148](https://github.com/dart-lang/sdk/issues/59148)
- `variable_shadowing` - [dart-lang/sdk#60560](https://github.com/dart-lang/sdk/issues/60560)

### Contributing

Contributions are welcome! Please feel free to submit issues and pull requests on our [GitHub repository](https://github.com/FMorschel/essential_lints).
