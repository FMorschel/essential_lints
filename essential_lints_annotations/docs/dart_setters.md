# Complete Dart Class Setter Declaration Patterns

This document lists all valid Dart class setter declaration patterns and their corresponding modifiers.

## 1. Instance Setters (24 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 1 | `set foo(int value) {}` | public + setters |
| 2 | `set foo(int value) {}` | setters |
| 3 | `set _foo(int value) {}` | private + setters |
| 4 | `set foo(int? value) {}` | nullable + public + setters |
| 5 | `set foo(int? value) {}` | nullable + setters |
| 6 | `set _foo(int? value) {}` | nullable + private + setters |
| 7 | `set foo(int value);` | abstract + public + setters |
| 8 | `set foo(int value);` | abstract + setters |
| 9 | `set _foo(int value);` | abstract + private + setters |
| 10 | `set foo(int? value);` | abstract + nullable + public + setters |
| 11 | `set foo(int? value);` | abstract + nullable + setters |
| 12 | `set _foo(int? value);` | abstract + nullable + private + setters |
| 13 | `external set foo(int value);` | external + public + setters |
| 14 | `external set foo(int value);` | external + setters |
| 15 | `external set _foo(int value);` | external + private + setters |
| 16 | `external set foo(int? value);` | external + nullable + public + setters |
| 17 | `external set foo(int? value);` | external + nullable + setters |
| 18 | `external set _foo(int? value);` | external + nullable + private + setters |
| 19 | `@override set foo(int value) {}` | overridden + public + setters |
| 20 | `@override set foo(int value) {}` | overridden + setters |
| 21 | `@override set _foo(int value) {}` | overridden + private + setters |
| 22 | `@override set foo(int? value) {}` | overridden + nullable + public + setters |
| 23 | `@override set foo(int? value) {}` | overridden + nullable + setters |
| 24 | `@override set _foo(int? value) {}` | overridden + nullable + private + setters |
| 25 | `@override external set foo(int value);` | overridden + external + public + setters |
| 26 | `@override external set foo(int value);` | overridden + external + setters |
| 27 | `@override external set _foo(int value);` | overridden + external + private + setters |
| 28 | `@override external set foo(int? value);` | overridden + external + nullable + public + setters |
| 29 | `@override external set foo(int? value);` | overridden + external + nullable + setters |
| 30 | `@override external set _foo(int? value);` | overridden + external + nullable + private + setters |
| 31 | `@override set foo(int value);` | overridden + abstract + public + setters |
| 32 | `@override set foo(int value);` | overridden + abstract + setters |
| 33 | `@override set _foo(int value);` | overridden + abstract + private + setters |
| 34 | `@override set foo(int? value);` | overridden + abstract + nullable + public + setters |
| 35 | `@override set foo(int? value);` | overridden + abstract + nullable + setters |
| 36 | `@override set _foo(int? value);` | overridden + abstract + nullable + private + setters |

## 2. Static Setters (12 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 37 | `static set foo(int value) {}` | static + public + setters |
| 38 | `static set foo(int value) {}` | static + setters |
| 39 | `static set _foo(int value) {}` | static + private + setters |
| 40 | `static set foo(int? value) {}` | static + nullable + public + setters |
| 41 | `static set foo(int? value) {}` | static + nullable + setters |
| 42 | `static set _foo(int? value) {}` | static + nullable + private + setters |
| 43 | `external static set foo(int value);` | external + static + public + setters |
| 44 | `external static set foo(int value);` | external + static + setters |
| 45 | `external static set _foo(int value);` | external + static + private + setters |
| 46 | `external static set foo(int? value);` | external + static + nullable + public + setters |
| 47 | `external static set foo(int? value);` | external + static + nullable + setters |
| 48 | `external static set _foo(int? value);` | external + static + nullable + private + setters |

## Summary of Modifiers

| Modifier | Description |
|----------|-------------|
| `setters` | Base type for all setters |
| `static` | Setter belongs to class, not instance (mutually exclusive with `overridden`) |
| `overridden` | Setter overrides a superclass setter (requires `@override` annotation) |
| `abstract` | Setter has no body, must be in abstract class (mutually exclusive with `external`) |
| `external` | Setter implementation is provided externally (mutually exclusive with `abstract`) |
| `nullable` | Parameter type is nullable (e.g., `int?`, `T?`) |
| `private` | Setter name starts with `_` |
| `public` | Setter name does not start with `_` (explicit visibility) |
