# Changelog

## 0.1.9

Released on: 2026-02-24

- **Subtype annotations**: Adds package-option support
- **ambiguous_positional_boolean**: Adds new rule to detect ambiguous boolean positional parameters.
- **pending_listeners**:
  - Fixes two more cases of disposed listeners and multiple removals.
  - Improves detection and reporting for additional listener scenarios (instantiation and assignments).

## 0.1.8

Released on: 2026-02-17

- **Analyzer**: Updated to analyzer v10.0.0.
- **Logging capabilities scaffold**: Added the base logging capabilities to the plugin, which will be used in future releases to possibly log various information during lint analysis, fixes and assists.
- **GettersInMemberList**: Improved handling of nullable and spread elements.
- **pending_listeners**:
  - Fixes disposed listeners and multiple removals correctly.
  - Fixes getters adding/removing for different getters.
  - Fixes reporting for `part` files.
- **unnecessary_setstate**: Fixes `unnecessary_setstate` false-positive.

## 0.1.7

Released on: 2026-01-09

- Fixes `Use direct import` fix for non-lib files.

## 0.1.6

Released on: 2026-01-07

- Fixes `standard_comment_style` to be compatible with `dartdoc`.

## 0.1.5

Released on: 2026-01-07

- Fixes `standard_comment_style` for some token sequences that made it stop looking.

## 0.1.4

Released on: 2026-01-07

- Fixes warnings to be ignorable.
- Adds some fixes for warnings and for `first_getter` and `last_getter` rules.

## 0.1.3

Released on: 2026-01-06

- Fixes `standard_comment_style` rule to allow markdown compatible comments (like headings, lists, blockquotes) to pass without linting errors.
- Fixes `variable_shadowing` rule to avoid false positives in certain scenarios.
- Fixes `mutable_tearoff` rule to avoid false positives with property accessors.

## 0.1.2

Released on: 2026-01-05

- Changes essential_lints_annotations dependency version.
- Fixes example comments to clone it.
- Adds missing punctuations to `standard_comment_style` rule.

## 0.1.1

Released on: 2026-01-05

- Fixes PANA problems in essential_lints package.

## 0.1.0

Released on: 2025-12-27

- Initial release of essential_lints package.

## 0.0.1

- Placeholder.
