# Complete Dart Class Getter Declaration Patterns

This document lists all valid Dart class getter declaration patterns and their corresponding modifiers.

## 1. Instance Getters (36 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 1 | `int get foo => 0;` | instance + typed + public + getters |
| 2 | `int get foo => 0;` | instance + typed + getters |
| 3 | `int get _foo => 0;` | instance + typed + private + getters |
| 4 | `int? get foo => null;` | instance + typed + nullable + public + getters |
| 5 | `int? get foo => null;` | instance + typed + nullable + getters |
| 6 | `int? get _foo => null;` | instance + typed + nullable + private + getters |
| 7 | `int get foo;` | instance + typed + abstract + public + getters |
| 8 | `int get foo;` | instance + typed + abstract + getters |
| 9 | `int get _foo;` | instance + typed + abstract + private + getters |
| 10 | `int? get foo;` | instance + typed + abstract + nullable + public + getters |
| 11 | `int? get foo;` | instance + typed + abstract + nullable + getters |
| 12 | `int? get _foo;` | instance + typed + abstract + nullable + private + getters |
| 13 | `external int get foo;` | external + instance + typed + public + getters |
| 14 | `external int get foo;` | external + instance + typed + getters |
| 15 | `external int get _foo;` | external + instance + typed + private + getters |
| 16 | `external int? get foo;` | external + instance + typed + nullable + public + getters |
| 17 | `external int? get foo;` | external + instance + typed + nullable + getters |
| 18 | `external int? get _foo;` | external + instance + typed + nullable + private + getters |
| 19 | `@override int get foo => 0;` | instance + overridden + typed + public + getters |
| 20 | `@override int get foo => 0;` | instance + overridden + typed + getters |
| 21 | `@override int get _foo => 0;` | instance + overridden + typed + private + getters |
| 22 | `@override int? get foo => null;` | instance + overridden + typed + nullable + public + getters |
| 23 | `@override int? get foo => null;` | instance + overridden + typed + nullable + getters |
| 24 | `@override int? get _foo => null;` | instance + overridden + typed + nullable + private + getters |
| 25 | `@override external int get foo;` | external + instance + overridden + typed + public + getters |
| 26 | `@override external int get foo;` | external + instance + overridden + typed + getters |
| 27 | `@override external int get _foo;` | external + instance + overridden + typed + private + getters |
| 28 | `@override external int? get foo;` | external + instance + overridden + typed + nullable + public + getters |
| 29 | `@override external int? get foo;` | external + instance + overridden + typed + nullable + getters |
| 30 | `@override external int? get _foo;` | external + instance + overridden + typed + nullable + private + getters |

| 31 | `@override int get foo;` | instance + overridden + typed + abstract + public + getters |
| 32 | `@override int get foo;` | instance + overridden + typed + abstract + getters |
| 33 | `@override int get _foo;` | instance + overridden + typed + abstract + private + getters |
| 34 | `@override int? get foo;` | instance + overridden + typed + abstract + nullable + public + getters |
| 35 | `@override int? get foo;` | instance + overridden + typed + abstract + nullable + getters |
| 36 | `@override int? get _foo;` | instance + overridden + typed + abstract + nullable + private + getters |

## 2. Static Getters (12 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 37 | `static int get foo => 0;` | static + typed + public + getters |
| 38 | `static int get foo => 0;` | static + typed + getters |
| 39 | `static int get _foo => 0;` | static + typed + private + getters |
| 40 | `static int? get foo => null;` | static + typed + nullable + public + getters |
| 41 | `static int? get foo => null;` | static + typed + nullable + getters |
| 42 | `static int? get _foo => null;` | static + typed + nullable + private + getters |
| 43 | `external static int get foo;` | external + static + typed + public + getters |
| 44 | `external static int get foo;` | external + static + typed + getters |
| 45 | `external static int get _foo;` | external + static + typed + private + getters |
| 46 | `external static int? get foo;` | external + static + typed + nullable + public + getters |
| 47 | `external static int? get foo;` | external + static + typed + nullable + getters |
| 48 | `external static int? get _foo;` | external + static + typed + nullable + private + getters |

## Summary of Modifiers

| Modifier | Description |
|----------|-------------|
| `getters` | Base type for all getters |
| `instance` | Getter belongs to an instance, not static (mutually exclusive with `static`) |
| `static` | Getter belongs to class, not instance (mutually exclusive with `instance`, `overridden`, `new`) |
| `overridden` | Getter overrides a superclass getter (requires `@override` annotation). Can be combined with `abstract` (an `@override` annotated getter may be abstract). (mutually exclusive with `new`) |
| `new` | Getter does not override a superclass getter (opposite of `overridden`). Indicates the member is new to this class. (mutually exclusive with `overridden`, `static`) |
| `typed` | Getter has an explicit return type annotation (e.g., `int get foo`, `String? get bar`) (mutually exclusive with `dynamic`) |
| `dynamic` | Getter has inferred or dynamic return type (e.g., `get foo => 0`) (mutually exclusive with `typed`) |
| `abstract` | Getter has no body, must be in abstract class (mutually exclusive with `external`) |
| `external` | Getter implementation is provided externally (mutually exclusive with `abstract`; can be combined with `overridden` or `new`) |
| `nullable` | Return type is nullable (e.g., `int?`, `T?`) |
| `private` | Getter name starts with `_` |
| `public` | Getter name does not start with `_` (explicit visibility) |
