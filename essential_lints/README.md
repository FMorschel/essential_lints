# essential_lints

This package provides some basic lints that help Dart/Flutter developers along with fixes for them.

This is currently a placeholder for an under-construction package.

<!---
## Features

TODO(FMORSCHEL): List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO(FMORSCHEL): List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO(FMORSCHEL): Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```
!--->

## Additional information

Some of the rules provided by this package are inspired by equivalent rules from [dart_code_metrics](https://pub.dev/packages/dart_code_metrics). Their work is currently done under <https://dcm.dev/>. Thanks to the authors of that package for their great work! These are:

- border_all [see the original work](https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/avoid_border_all/avoid_border_all_rule.dart)
- first_getter [see the original work](https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/prefer_first/prefer_first_rule.dart)
- last_getter [see the original work](https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/prefer_last/prefer_last_rule.dart)
- numeric_constant_style [see the original work](https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/double_literal_format/double_literal_format_rule.dart)
- padding_over_container [see the original work](https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/avoid_wrapping_in_padding/avoid_wrapping_in_padding_rule.dart)
- pending_listener [see the original work](https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/always_remove_listener/always_remove_listener_rule.dart)
- prefer_explicitly_named_parameters [see the original work](https://dcm.dev/docs/rules/common/prefer-explicit-parameter-names/)
- returning_widgets [see the original work](https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/avoid_returning_widgets/avoid_returning_widgets_rule.dart)
- unnecessary_setstate [see the original work](https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/avoid_unnecessary_setstate/avoid_unnecessary_setstate_rule.dart)
- border_radius_all [see the original work](https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/prefer_const_border_radius/prefer_const_border_radius_rule.dart)
- standard_comment_style [see the original work](https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/format_comment/format_comment_rule.dart)

<!---
https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/member_ordering/member_ordering_rule.dart
!--->

Some of the rules are based on issues in the Dart SDK repository. These are:

- new_instance_cascade [based on this SDK issue](https://github.com/dart-lang/sdk/issues/59754)
- is_future [based on this SDK issue](https://github.com/dart-lang/sdk/issues/59355)
- variable_shadowing [based on this SDK issue](https://github.com/dart-lang/sdk/issues/60560)
- optional_positional_parameters [based on this SDK issue](https://github.com/dart-lang/sdk/issues/59097)
