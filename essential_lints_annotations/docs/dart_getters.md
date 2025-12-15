# Complete Dart Class Getter Declaration Patterns

This document lists all valid Dart class getter declaration patterns and their corresponding modifiers.

## 1. Instance Getters (30 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 1 | `int get foo => 0;` | public + getters |
| 2 | `int get foo => 0;` | getters |
| 3 | `int get _foo => 0;` | private + getters |
| 4 | `int? get foo => null;` | nullable + public + getters |
| 5 | `int? get foo => null;` | nullable + getters |
| 6 | `int? get _foo => null;` | nullable + private + getters |
| 7 | `int get foo;` | abstract + public + getters |
| 8 | `int get foo;` | abstract + getters |
| 9 | `int get _foo;` | abstract + private + getters |
| 10 | `int? get foo;` | abstract + nullable + public + getters |
| 11 | `int? get foo;` | abstract + nullable + getters |
| 12 | `int? get _foo;` | abstract + nullable + private + getters |
| 13 | `external int get foo;` | external + public + getters |
| 14 | `external int get foo;` | external + getters |
| 15 | `external int get _foo;` | external + private + getters |
| 16 | `external int? get foo;` | external + nullable + public + getters |
| 17 | `external int? get foo;` | external + nullable + getters |
| 18 | `external int? get _foo;` | external + nullable + private + getters |
| 19 | `@override int get foo => 0;` | overridden + public + getters |
| 20 | `@override int get foo => 0;` | overridden + getters |
| 21 | `@override int get _foo => 0;` | overridden + private + getters |
| 22 | `@override int? get foo => null;` | overridden + nullable + public + getters |
| 23 | `@override int? get foo => null;` | overridden + nullable + getters |
| 24 | `@override int? get _foo => null;` | overridden + nullable + private + getters |
| 25 | `@override external int get foo;` | overridden + external + public + getters |
| 26 | `@override external int get foo;` | overridden + external + getters |
| 27 | `@override external int get _foo;` | overridden + external + private + getters |
| 28 | `@override external int? get foo;` | overridden + external + nullable + public + getters |
| 29 | `@override external int? get foo;` | overridden + external + nullable + getters |
| 30 | `@override external int? get _foo;` | overridden + external + nullable + private + getters |

| 31 | `@override int get foo;` | overridden + abstract + public + getters |
| 32 | `@override int get foo;` | overridden + abstract + getters |
| 33 | `@override int get _foo;` | overridden + abstract + private + getters |
| 34 | `@override int? get foo;` | overridden + abstract + nullable + public + getters |
| 35 | `@override int? get foo;` | overridden + abstract + nullable + getters |
| 36 | `@override int? get _foo;` | overridden + abstract + nullable + private + getters |

## 2. Static Getters (12 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 37 | `static int get foo => 0;` | static + public + getters |
| 38 | `static int get foo => 0;` | static + getters |
| 39 | `static int get _foo => 0;` | static + private + getters |
| 40 | `static int? get foo => null;` | static + nullable + public + getters |
| 41 | `static int? get foo => null;` | static + nullable + getters |
| 42 | `static int? get _foo => null;` | static + nullable + private + getters |
| 43 | `external static int get foo;` | external + static + public + getters |
| 44 | `external static int get foo;` | external + static + getters |
| 45 | `external static int get _foo;` | external + static + private + getters |
| 46 | `external static int? get foo;` | external + static + nullable + public + getters |
| 47 | `external static int? get foo;` | external + static + nullable + getters |
| 48 | `external static int? get _foo;` | external + static + nullable + private + getters |

## Summary of Modifiers

| Modifier | Description |
|----------|-------------|
| `getters` | Base type for all getters |
| `static` | Getter belongs to class, not instance (mutually exclusive with `overridden`) |
| `overridden` | Getter overrides a superclass getter (requires `@override` annotation). Can be combined with `abstract` (an `@override` annotated getter may be abstract). |
| `abstract` | Getter has no body, must be in abstract class (mutually exclusive with `external`) |
| `external` | Getter implementation is provided externally (mutually exclusive with `abstract`; can be combined with `overridden`) |
| `nullable` | Return type is nullable (e.g., `int?`, `T?`) |
| `private` | Getter name starts with `_` |
| `public` | Getter name does not start with `_` (explicit visibility) |
