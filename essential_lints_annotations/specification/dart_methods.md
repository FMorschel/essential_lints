# Complete Dart Class Method Declaration Patterns

This document lists all valid Dart class method declaration patterns and their corresponding modifiers.

## 1. Instance Methods (36 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 1 | `void foo() {}` | instance + typed + public + methods |
| 2 | `void foo() {}` | instance + typed + methods |
| 3 | `void _foo() {}` | instance + typed + private + methods |
| 4 | `int? foo() {}` | instance + typed + nullable + public + methods |
| 5 | `int? foo() {}` | instance + typed + nullable + methods |
| 6 | `int? _foo() {}` | instance + typed + nullable + private + methods |
| 7 | `void foo();` | instance + typed + abstract + public + methods |
| 8 | `void foo();` | instance + typed + abstract + methods |
| 9 | `void _foo();` | instance + typed + abstract + private + methods |
| 10 | `int? foo();` | instance + typed + abstract + nullable + public + methods |
| 11 | `int? foo();` | instance + typed + abstract + nullable + methods |
| 12 | `int? _foo();` | instance + typed + abstract + nullable + private + methods |
| 13 | `external void foo();` | external + instance + typed + public + methods |
| 14 | `external void foo();` | external + instance + typed + methods |
| 15 | `external void _foo();` | external + instance + typed + private + methods |
| 16 | `external int? foo();` | external + instance + typed + nullable + public + methods |
| 17 | `external int? foo();` | external + instance + typed + nullable + methods |
| 18 | `external int? _foo();` | external + instance + typed + nullable + private + methods |
| 19 | `@override void foo() {}` | instance + overridden + typed + public + methods |
| 20 | `@override void foo() {}` | instance + overridden + typed + methods |
| 21 | `@override void _foo() {}` | instance + overridden + typed + private + methods |
| 22 | `@override int? foo() {}` | instance + overridden + typed + nullable + public + methods |
| 23 | `@override int? foo() {}` | instance + overridden + typed + nullable + methods |
| 24 | `@override int? _foo() {}` | instance + overridden + typed + nullable + private + methods |
| 25 | `@override external void foo();` | external + instance + overridden + typed + public + methods |
| 26 | `@override external void foo();` | external + instance + overridden + typed + methods |
| 27 | `@override external void _foo();` | external + instance + overridden + typed + private + methods |
| 28 | `@override external int? foo();` | external + instance + overridden + typed + nullable + public + methods |
| 29 | `@override external int? foo();` | external + instance + overridden + typed + nullable + methods |
| 30 | `@override external int? _foo();` | external + instance + overridden + typed + nullable + private + methods |
| 31 | `@override void foo();` | instance + overridden + typed + abstract + public + methods |
| 32 | `@override void foo();` | instance + overridden + typed + abstract + methods |
| 33 | `@override void _foo();` | instance + overridden + typed + abstract + private + methods |
| 34 | `@override int? foo();` | instance + overridden + typed + abstract + nullable + public + methods |
| 35 | `@override int? foo();` | instance + overridden + typed + abstract + nullable + methods |
| 36 | `@override int? _foo();` | instance + overridden + typed + abstract + nullable + private + methods |

## 2. Static Methods (12 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 37 | `static void foo() {}` | static + typed + public + methods |
| 38 | `static void foo() {}` | static + typed + methods |
| 39 | `static void _foo() {}` | static + typed + private + methods |
| 40 | `static int? foo() {}` | static + typed + nullable + public + methods |
| 41 | `static int? foo() {}` | static + typed + nullable + methods |
| 42 | `static int? _foo() {}` | static + typed + nullable + private + methods |
| 43 | `external static void foo();` | external + static + typed + public + methods |
| 44 | `external static void foo();` | external + static + typed + methods |
| 45 | `external static void _foo();` | external + static + typed + private + methods |
| 46 | `external static int? foo();` | external + static + typed + nullable + public + methods |
| 47 | `external static int? foo();` | external + static + typed + nullable + methods |
| 48 | `external static int? _foo();` | external + static + typed + nullable + private + methods |

## 3. Operators (8 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 49 | `T operator +(T other) {}` | instance + typed + operator + methods |
| 50 | `T? operator +(T other) {}` | instance + typed + operator + nullable + methods |
| 51 | `T operator +(T other);` | instance + typed + abstract + operator + methods |
| 52 | `T? operator +(T other);` | instance + typed + abstract + operator + nullable + methods |
| 53 | `external T operator +(T other);` | external + instance + typed + operator + methods |
| 54 | `external T? operator +(T other);` | external + instance + typed + operator + nullable + methods |
| 55 | `@override T operator +(T other) {}` | instance + overridden + typed + operator + methods |
| 56 | `@override T? operator -(T other) {}` | instance + overridden + typed + operator + nullable + methods |

## Summary of Modifiers

| Modifier | Description |
|----------|-------------|
| `methods` | Base type for all methods |
| `instance` | Method belongs to an instance, not static (mutually exclusive with `static`) |
| `static` | Method belongs to class, not instance (mutually exclusive with `instance`, `overridden`, `new`) |
| `overridden` | Method overrides a superclass method (requires `@override` annotation) (mutually exclusive with `new`) |
| `new` | Method does not override a superclass method (opposite of `overridden`). Indicates the member is new to this class. (mutually exclusive with `overridden`, `static`) |
| `typed` | Method has an explicit return type annotation (e.g., `void foo()`, `int? bar()`) (mutually exclusive with `dynamic`) |
| `dynamic` | Method has inferred or dynamic return type (e.g., `foo() => 0`) (mutually exclusive with `typed`) |
| `abstract` | Method has no body, must be in abstract class (mutually exclusive with `external`) |
| `external` | Method implementation is provided externally (mutually exclusive with `abstract`; can be combined with `overridden` or `new`) |
| `operator` | Operator method like `+`, `-`, `[]`, etc. (always instance, cannot be static or private) |
| `nullable` | Return type is nullable (e.g., `int?`, `T?`) |
| `private` | Method name starts with `_` (cannot apply to operators) |
| `public` | Method name does not start with `_` (explicit visibility) |
