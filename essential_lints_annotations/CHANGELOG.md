# Changelog

## 0.1.4

Released on: 2026-02-24

- Adds **`SubtypeDeannotating`**: An annotation that stops propagation of annotation rules to subtypes. This is useful for cases where you want to enforce certain rules on a class and its subtypes, but allow specific subtypes to opt-out of those rules.
- Adds **`SubtypeUnnaming`**: An annotation that stops propagation of naming rules to subtypes. This is useful for cases where you want to enforce certain naming conventions on a class and its subtypes, but allow specific subtypes to opt-out of those naming conventions.

## 0.1.3+1

Released on: 2026-02-24

- Updated README.md to reflect the new `packageOption` member in the `SubtypeAnnotating` and `SubtypeNaming` annotations.

## 0.1.3

Released on: 2026-02-24

- Adds a new `packageOption` member to both `SubtypeAnnotating` and `SubtypeNaming` annotations, allowing users to specify if the defined annotations should only apply to members of the same package. This is useful for libraries that want to enforce certain rules only within their own codebase, without affecting external users of the library.

## 0.1.2

Released on: 2026-02-16

- Adds an internal annotation that is used on `essential_lints` package.

## 0.1.1+2

Released on: 2026-01-09

- Adds an internal `analysis_options.yaml` file to the package to ensure compatibility with `essential_lints` package.

## 0.1.1+1

Released on: 2026-01-05

- Fixes an error on the example comment regarding how to clone it.

## 0.1.1

Released on: 2026-01-05

- Fixes PANA problems in essential_lints_annotations package.

## 0.1.0

Released on: 2025-12-27

- Initial release of essential_lints package.

## 0.0.1

- Placeholder.
