# Complete Dart Class Method Declaration Patterns

This document lists all valid Dart class method declaration patterns and their corresponding modifiers.

## 1. Instance Methods (36 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 1 | `void foo() {}` | public + methods |
| 2 | `void foo() {}` | methods |
| 3 | `void _foo() {}` | private + methods |
| 4 | `int? foo() {}` | nullable + public + methods |
| 5 | `int? foo() {}` | nullable + methods |
| 6 | `int? _foo() {}` | nullable + private + methods |
| 7 | `void foo();` | abstract + public + methods |
| 8 | `void foo();` | abstract + methods |
| 9 | `void _foo();` | abstract + private + methods |
| 10 | `int? foo();` | abstract + nullable + public + methods |
| 11 | `int? foo();` | abstract + nullable + methods |
| 12 | `int? _foo();` | abstract + nullable + private + methods |
| 13 | `external void foo();` | external + public + methods |
| 14 | `external void foo();` | external + methods |
| 15 | `external void _foo();` | external + private + methods |
| 16 | `external int? foo();` | external + nullable + public + methods |
| 17 | `external int? foo();` | external + nullable + methods |
| 18 | `external int? _foo();` | external + nullable + private + methods |
| 19 | `@override void foo() {}` | overridden + public + methods |
| 20 | `@override void foo() {}` | overridden + methods |
| 21 | `@override void _foo() {}` | overridden + private + methods |
| 22 | `@override int? foo() {}` | overridden + nullable + public + methods |
| 23 | `@override int? foo() {}` | overridden + nullable + methods |
| 24 | `@override int? _foo() {}` | overridden + nullable + private + methods |
| 25 | `@override external void foo();` | overridden + external + public + methods |
| 26 | `@override external void foo();` | overridden + external + methods |
| 27 | `@override external void _foo();` | overridden + external + private + methods |
| 28 | `@override external int? foo();` | overridden + external + nullable + public + methods |
| 29 | `@override external int? foo();` | overridden + external + nullable + methods |
| 30 | `@override external int? _foo();` | overridden + external + nullable + private + methods |
| 31 | `@override void foo();` | overridden + abstract + public + methods |
| 32 | `@override void foo();` | overridden + abstract + methods |
| 33 | `@override void _foo();` | overridden + abstract + private + methods |
| 34 | `@override int? foo();` | overridden + abstract + nullable + public + methods |
| 35 | `@override int? foo();` | overridden + abstract + nullable + methods |
| 36 | `@override int? _foo();` | overridden + abstract + nullable + private + methods |

## 2. Static Methods (12 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 37 | `static void foo() {}` | static + public + methods |
| 38 | `static void foo() {}` | static + methods |
| 39 | `static void _foo() {}` | static + private + methods |
| 40 | `static int? foo() {}` | static + nullable + public + methods |
| 41 | `static int? foo() {}` | static + nullable + methods |
| 42 | `static int? _foo() {}` | static + nullable + private + methods |
| 43 | `external static void foo();` | external + static + public + methods |
| 44 | `external static void foo();` | external + static + methods |
| 45 | `external static void _foo();` | external + static + private + methods |
| 46 | `external static int? foo();` | external + static + nullable + public + methods |
| 47 | `external static int? foo();` | external + static + nullable + methods |
| 48 | `external static int? _foo();` | external + static + nullable + private + methods |

## 3. Operators (8 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 49 | `T operator +(T other) {}` | operator + methods |
| 50 | `T? operator +(T other) {}` | operator + nullable + methods |
| 51 | `T operator +(T other);` | abstract + operator + methods |
| 52 | `T? operator +(T other);` | abstract + operator + nullable + methods |
| 53 | `external T operator +(T other);` | external + operator + methods |
| 54 | `external T? operator +(T other);` | external + operator + nullable + methods |
| 55 | `@override T operator +(T other) {}` | overridden + operator + methods |
| 56 | `@override T? operator -(T other) {}` | overridden + operator + nullable + methods |

## Summary of Modifiers

| Modifier | Description |
|----------|-------------|
| `methods` | Base type for all methods |
| `static` | Method belongs to class, not instance (mutually exclusive with `overridden`) |
| `overridden` | Method overrides a superclass method (requires `@override` annotation) |
| `abstract` | Method has no body, must be in abstract class (mutually exclusive with `external`) |
| `external` | Method implementation is provided externally (mutually exclusive with `abstract`) |
| `operator` | Operator method like `+`, `-`, `[]`, etc. (always instance, cannot be static or private) |
| `nullable` | Return type is nullable (e.g., `int?`, `T?`) |
| `private` | Method name starts with `_` (cannot apply to operators) |
| `public` | Method name does not start with `_` (explicit visibility) |
