# Complete Dart Class Setter Declaration Patterns

This document lists all valid Dart class setter declaration patterns and their corresponding modifiers.

## 1. Instance Setters (36 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 1 | `set foo(int value) {}` | instance + typed + public + setters |
| 2 | `set foo(int value) {}` | instance + typed + setters |
| 3 | `set _foo(int value) {}` | instance + typed + private + setters |
| 4 | `set foo(int? value) {}` | instance + typed + nullable + public + setters |
| 5 | `set foo(int? value) {}` | instance + typed + nullable + setters |
| 6 | `set _foo(int? value) {}` | instance + typed + nullable + private + setters |
| 7 | `set foo(int value);` | instance + typed + abstract + public + setters |
| 8 | `set foo(int value);` | instance + typed + abstract + setters |
| 9 | `set _foo(int value);` | instance + typed + abstract + private + setters |
| 10 | `set foo(int? value);` | instance + typed + abstract + nullable + public + setters |
| 11 | `set foo(int? value);` | instance + typed + abstract + nullable + setters |
| 12 | `set _foo(int? value);` | instance + typed + abstract + nullable + private + setters |
| 13 | `external set foo(int value);` | external + instance + typed + public + setters |
| 14 | `external set foo(int value);` | external + instance + typed + setters |
| 15 | `external set _foo(int value);` | external + instance + typed + private + setters |
| 16 | `external set foo(int? value);` | external + instance + typed + nullable + public + setters |
| 17 | `external set foo(int? value);` | external + instance + typed + nullable + setters |
| 18 | `external set _foo(int? value);` | external + instance + typed + nullable + private + setters |
| 19 | `@override set foo(int value) {}` | instance + overridden + typed + public + setters |
| 20 | `@override set foo(int value) {}` | instance + overridden + typed + setters |
| 21 | `@override set _foo(int value) {}` | instance + overridden + typed + private + setters |
| 22 | `@override set foo(int? value) {}` | instance + overridden + typed + nullable + public + setters |
| 23 | `@override set foo(int? value) {}` | instance + overridden + typed + nullable + setters |
| 24 | `@override set _foo(int? value) {}` | instance + overridden + typed + nullable + private + setters |
| 25 | `@override external set foo(int value);` | external + instance + overridden + typed + public + setters |
| 26 | `@override external set foo(int value);` | external + instance + overridden + typed + setters |
| 27 | `@override external set _foo(int value);` | external + instance + overridden + typed + private + setters |
| 28 | `@override external set foo(int? value);` | external + instance + overridden + typed + nullable + public + setters |
| 29 | `@override external set foo(int? value);` | external + instance + overridden + typed + nullable + setters |
| 30 | `@override external set _foo(int? value);` | external + instance + overridden + typed + nullable + private + setters |
| 31 | `@override set foo(int value);` | instance + overridden + typed + abstract + public + setters |
| 32 | `@override set foo(int value);` | instance + overridden + typed + abstract + setters |
| 33 | `@override set _foo(int value);` | instance + overridden + typed + abstract + private + setters |
| 34 | `@override set foo(int? value);` | instance + overridden + typed + abstract + nullable + public + setters |
| 35 | `@override set foo(int? value);` | instance + overridden + typed + abstract + nullable + setters |
| 36 | `@override set _foo(int? value);` | instance + overridden + typed + abstract + nullable + private + setters |

## 2. Static Setters (12 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 37 | `static set foo(int value) {}` | static + typed + public + setters |
| 38 | `static set foo(int value) {}` | static + typed + setters |
| 39 | `static set _foo(int value) {}` | static + typed + private + setters |
| 40 | `static set foo(int? value) {}` | static + typed + nullable + public + setters |
| 41 | `static set foo(int? value) {}` | static + typed + nullable + setters |
| 42 | `static set _foo(int? value) {}` | static + typed + nullable + private + setters |
| 43 | `external static set foo(int value);` | external + static + typed + public + setters |
| 44 | `external static set foo(int value);` | external + static + typed + setters |
| 45 | `external static set _foo(int value);` | external + static + typed + private + setters |
| 46 | `external static set foo(int? value);` | external + static + typed + nullable + public + setters |
| 47 | `external static set foo(int? value);` | external + static + typed + nullable + setters |
| 48 | `external static set _foo(int? value);` | external + static + typed + nullable + private + setters |

## Summary of Modifiers

| Modifier | Description |
|----------|-------------|
| `setters` | Base type for all setters |
| `instance` | Setter belongs to an instance, not static (mutually exclusive with `static`) |
| `static` | Setter belongs to class, not instance (mutually exclusive with `instance`, `overridden`, `new`) |
| `overridden` | Setter overrides a superclass setter (requires `@override` annotation) (mutually exclusive with `new`) |
| `new` | Setter does not override a superclass setter (opposite of `overridden`). Indicates the member is new to this class. (mutually exclusive with `overridden`, `static`) |
| `typed` | Setter has an explicit parameter type annotation (e.g., `set foo(int value)`, `set bar(String? value)`) (mutually exclusive with `dynamic`) |
| `dynamic` | Setter has inferred or dynamic parameter type (e.g., `set foo(value) {}`) (mutually exclusive with `typed`) |
| `abstract` | Setter has no body, must be in abstract class (mutually exclusive with `external`) |
| `external` | Setter implementation is provided externally (mutually exclusive with `abstract`; can be combined with `overridden` or `new`) |
| `nullable` | Parameter type is nullable (e.g., `int?`, `T?`) |
| `private` | Setter name starts with `_` |
| `public` | Setter name does not start with `_` (explicit visibility) |
