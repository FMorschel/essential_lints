# Complete Dart Class Field Declaration Patterns

This document lists all valid Dart class field declaration patterns and their corresponding modifiers.

## 1. Instance Fields - Regular (9 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 1 | `int foo = 0;` | instance + typed + initialized + public + fields |
| 2 | `int foo = 0;` | instance + typed + initialized + fields |
| 3 | `int _foo = 0;` | instance + typed + initialized + private + fields |
| 4 | `int? foo;` | instance + typed + nullable + public + fields |
| 5 | `int? foo;` | instance + typed + nullable + fields |
| 6 | `int? _foo;` | instance + typed + nullable + private + fields |
| 7 | `int? foo = null;` | instance + typed + nullable + initialized + public + fields |
| 8 | `int? foo = null;` | instance + typed + nullable + initialized + fields |
| 9 | `int? _foo = null;` | instance + typed + nullable + initialized + private + fields |

## 2. Instance Fields - Final (12 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 10 | `final int foo = 0;` | instance + typed + final + initialized + public + fields |
| 11 | `final int foo = 0;` | instance + typed + final + initialized + fields |
| 12 | `final int _foo = 0;` | instance + typed + final + initialized + private + fields |
| 13 | `final int foo;` | instance + typed + final + public + fields |
| 14 | `final int foo;` | instance + typed + final + fields |
| 15 | `final int _foo;` | instance + typed + final + private + fields |
| 16 | `final int? foo;` | instance + typed + final + nullable + public + fields |
| 17 | `final int? foo;` | instance + typed + final + nullable + fields |
| 18 | `final int? _foo;` | instance + typed + final + nullable + private + fields |
| 19 | `final int? foo = null;` | instance + typed + final + nullable + initialized + public + fields |
| 20 | `final int? foo = null;` | instance + typed + final + nullable + initialized + fields |
| 21 | `final int? _foo = null;` | instance + typed + final + nullable + initialized + private + fields |

## 3. Instance Fields - Late (12 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 22 | `late int foo;` | instance + typed + late + public + fields |
| 23 | `late int foo;` | instance + typed + late + fields |
| 24 | `late int _foo;` | instance + typed + late + private + fields |
| 25 | `late int foo = 0;` | instance + typed + late + initialized + public + fields |
| 26 | `late int foo = 0;` | instance + typed + late + initialized + fields |
| 27 | `late int _foo = 0;` | instance + typed + late + initialized + private + fields |
| 28 | `late int? foo;` | instance + typed + late + nullable + public + fields |
| 29 | `late int? foo;` | instance + typed + late + nullable + fields |
| 30 | `late int? _foo;` | instance + typed + late + nullable + private + fields |
| 31 | `late int? foo = null;` | instance + typed + late + nullable + initialized + public + fields |
| 32 | `late int? foo = null;` | instance + typed + late + nullable + initialized + fields |
| 33 | `late int? _foo = null;` | instance + typed + late + nullable + initialized + private + fields |

## 4. Instance Fields - Late Final (12 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 34 | `late final int foo;` | instance + typed + late + final + public + fields |
| 35 | `late final int foo;` | instance + typed + late + final + fields |
| 36 | `late final int _foo;` | instance + typed + late + final + private + fields |
| 37 | `late final int foo = 0;` | instance + typed + late + final + initialized + public + fields |
| 38 | `late final int foo = 0;` | instance + typed + late + final + initialized + fields |
| 39 | `late final int _foo = 0;` | instance + typed + late + final + initialized + private + fields |
| 40 | `late final int? foo;` | instance + typed + late + final + nullable + public + fields |
| 41 | `late final int? foo;` | instance + typed + late + final + nullable + fields |
| 42 | `late final int? _foo;` | instance + typed + late + final + nullable + private + fields |
| 43 | `late final int? foo = null;` | instance + typed + late + final + nullable + initialized + public + fields |
| 44 | `late final int? foo = null;` | instance + typed + late + final + nullable + initialized + fields |
| 45 | `late final int? _foo = null;` | instance + typed + late + final + nullable + initialized + private + fields |

## 5. Instance Fields - Abstract (12 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 46 | `abstract int foo;` | instance + typed + abstract + public + fields |
| 47 | `abstract int foo;` | instance + typed + abstract + fields |
| 48 | `abstract int _foo;` | instance + typed + abstract + private + fields |
| 49 | `abstract int? foo;` | instance + typed + abstract + nullable + public + fields |
| 50 | `abstract int? foo;` | instance + typed + abstract + nullable + fields |
| 51 | `abstract int? _foo;` | instance + typed + abstract + nullable + private + fields |
| 52 | `abstract final int foo;` | instance + typed + abstract + final + public + fields |
| 53 | `abstract final int foo;` | instance + typed + abstract + final + fields |
| 54 | `abstract final int _foo;` | instance + typed + abstract + final + private + fields |
| 55 | `abstract final int? foo;` | instance + typed + abstract + final + nullable + public + fields |
| 56 | `abstract final int? foo;` | instance + typed + abstract + final + nullable + fields |
| 57 | `abstract final int? _foo;` | instance + typed + abstract + final + nullable + private + fields |

## 6. Instance Fields - External (12 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 58 | `external int foo;` | external + instance + typed + public + fields |
| 59 | `external int foo;` | external + instance + typed + fields |
| 60 | `external int _foo;` | external + instance + typed + private + fields |
| 61 | `external int? foo;` | external + instance + typed + nullable + public + fields |
| 62 | `external int? foo;` | external + instance + typed + nullable + fields |
| 63 | `external int? _foo;` | external + instance + typed + nullable + private + fields |
| 64 | `external final int foo;` | external + instance + typed + final + public + fields |
| 65 | `external final int foo;` | external + instance + typed + final + fields |
| 66 | `external final int _foo;` | external + instance + typed + final + private + fields |
| 67 | `external final int? foo;` | external + instance + typed + final + nullable + public + fields |
| 68 | `external final int? foo;` | external + instance + typed + final + nullable + fields |
| 69 | `external final int? _foo;` | external + instance + typed + final + nullable + private + fields |

## 7. Instance Fields - Overridden (18 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 70 | `@override int foo = 0;` | instance + overridden + typed + initialized + public + fields |
| 71 | `@override int foo = 0;` | instance + overridden + typed + initialized + fields |
| 72 | `@override int _foo = 0;` | instance + overridden + typed + initialized + private + fields |
| 73 | `@override int? foo;` | instance + overridden + typed + nullable + public + fields |
| 74 | `@override int? foo;` | instance + overridden + typed + nullable + fields |
| 75 | `@override int? _foo;` | instance + overridden + typed + nullable + private + fields |
| 76 | `@override final int foo = 0;` | instance + overridden + typed + final + initialized + public + fields |
| 77 | `@override final int foo = 0;` | instance + overridden + typed + final + initialized + fields |
| 78 | `@override final int _foo = 0;` | instance + overridden + typed + final + initialized + private + fields |
| 79 | `@override final int? foo;` | instance + overridden + typed + final + nullable + public + fields |
| 80 | `@override final int? foo;` | instance + overridden + typed + final + nullable + fields |
| 81 | `@override final int? _foo;` | instance + overridden + typed + final + nullable + private + fields |
| 82 | `@override late int foo;` | instance + overridden + typed + late + public + fields |
| 83 | `@override late int foo;` | instance + overridden + typed + late + fields |
| 84 | `@override late int _foo;` | instance + overridden + typed + late + private + fields |
| 85 | `@override late final int foo;` | instance + overridden + typed + late + final + public + fields |
| 86 | `@override late final int foo;` | instance + overridden + typed + late + final + fields |
| 87 | `@override late final int _foo;` | instance + overridden + typed + late + final + private + fields |

## 8. Instance Fields - Var (18 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 88 | `var foo = 0;` | instance + dynamic + var + initialized + public + fields |
| 89 | `var foo = 0;` | instance + dynamic + var + initialized + fields |
| 90 | `var _foo = 0;` | instance + dynamic + var + initialized + private + fields |
| 91 | `late var foo;` | instance + dynamic + var + late + public + fields |
| 92 | `late var foo;` | instance + dynamic + var + late + fields |
| 93 | `late var _foo;` | instance + dynamic + var + late + private + fields |
| 94 | `late var foo = 0;` | instance + dynamic + var + late + initialized + public + fields |
| 95 | `late var foo = 0;` | instance + dynamic + var + late + initialized + fields |
| 96 | `late var _foo = 0;` | instance + dynamic + var + late + initialized + private + fields |
| 97 | `late final var foo;` | instance + dynamic + var + late + final + public + fields |
| 98 | `late final var foo;` | instance + dynamic + var + late + final + fields |
| 99 | `late final var _foo;` | instance + dynamic + var + late + final + private + fields |
| 100 | `late final var foo = 0;` | instance + dynamic + var + late + final + initialized + public + fields |
| 101 | `late final var foo = 0;` | instance + dynamic + var + late + final + initialized + fields |
| 102 | `late final var _foo = 0;` | instance + dynamic + var + late + final + initialized + private + fields |
| 103 | `@override var foo = 0;` | instance + overridden + dynamic + var + initialized + public + fields |
| 104 | `@override var foo = 0;` | instance + overridden + dynamic + var + initialized + fields |
| 105 | `@override var _foo = 0;` | instance + overridden + dynamic + var + initialized + private + fields |

## 9. Static Fields - Regular (15 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 109 | `static int foo = 0;` | static + typed + initialized + public + fields |
| 110 | `static int foo = 0;` | static + typed + initialized + fields |
| 111 | `static int _foo = 0;` | static + typed + initialized + private + fields |
| 112 | `static int? foo;` | static + typed + nullable + public + fields |
| 113 | `static int? foo;` | static + typed + nullable + fields |
| 114 | `static int? _foo;` | static + typed + nullable + private + fields |
| 115 | `static int? foo = null;` | static + typed + nullable + initialized + public + fields |
| 116 | `static int? foo = null;` | static + typed + nullable + initialized + fields |
| 117 | `static int? _foo = null;` | static + typed + nullable + initialized + private + fields |
| 118 | `static final int foo = 0;` | static + typed + final + initialized + public + fields |
| 119 | `static final int foo = 0;` | static + typed + final + initialized + fields |
| 120 | `static final int _foo = 0;` | static + typed + final + initialized + private + fields |
| 121 | `static final int? foo = null;` | static + typed + final + nullable + initialized + public + fields |
| 122 | `static final int? foo = null;` | static + typed + final + nullable + initialized + fields |
| 123 | `static final int? _foo = null;` | static + typed + final + nullable + initialized + private + fields |

## 10. Static Fields - Const (6 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 124 | `static const int foo = 0;` | static + typed + const + initialized + public + fields |
| 125 | `static const int foo = 0;` | static + typed + const + initialized + fields |
| 126 | `static const int _foo = 0;` | static + typed + const + initialized + private + fields |
| 127 | `static const int? foo = null;` | static + typed + const + nullable + initialized + public + fields |
| 128 | `static const int? foo = null;` | static + typed + const + nullable + initialized + fields |
| 129 | `static const int? _foo = null;` | static + typed + const + nullable + initialized + private + fields |

## 11. Static Fields - Late (24 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 130 | `static late int foo;` | static + typed + late + public + fields |
| 131 | `static late int foo;` | static + typed + late + fields |
| 132 | `static late int _foo;` | static + typed + late + private + fields |
| 133 | `static late int foo = 0;` | static + typed + late + initialized + public + fields |
| 134 | `static late int foo = 0;` | static + typed + late + initialized + fields |
| 135 | `static late int _foo = 0;` | static + typed + late + initialized + private + fields |
| 136 | `static late int? foo;` | static + typed + late + nullable + public + fields |
| 137 | `static late int? foo;` | static + typed + late + nullable + fields |
| 138 | `static late int? _foo;` | static + typed + late + nullable + private + fields |
| 139 | `static late int? foo = null;` | static + typed + late + nullable + initialized + public + fields |
| 140 | `static late int? foo = null;` | static + typed + late + nullable + initialized + fields |
| 141 | `static late int? _foo = null;` | static + typed + late + nullable + initialized + private + fields |
| 142 | `static late final int foo;` | static + typed + late + final + public + fields |
| 143 | `static late final int foo;` | static + typed + late + final + fields |
| 144 | `static late final int _foo;` | static + typed + late + final + private + fields |
| 145 | `static late final int foo = 0;` | static + typed + late + final + initialized + public + fields |
| 146 | `static late final int foo = 0;` | static + typed + late + final + initialized + fields |
| 147 | `static late final int _foo = 0;` | static + typed + late + final + initialized + private + fields |
| 148 | `static late final int? foo;` | static + typed + late + final + nullable + public + fields |
| 149 | `static late final int? foo;` | static + typed + late + final + nullable + fields |
| 150 | `static late final int? _foo;` | static + typed + late + final + nullable + private + fields |
| 151 | `static late final int? foo = null;` | static + typed + late + final + nullable + initialized + public + fields |
| 152 | `static late final int? foo = null;` | static + typed + late + final + nullable + initialized + fields |
| 153 | `static late final int? _foo = null;` | static + typed + late + final + nullable + initialized + private + fields |

## 12. Static Fields - External (12 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 133 | `external static int foo;` | external + static + typed + public + fields |
| 134 | `external static int foo;` | external + static + typed + fields |
| 135 | `external static int _foo;` | external + static + typed + private + fields |
| 136 | `external static int? foo;` | external + static + typed + nullable + public + fields |
| 137 | `external static int? foo;` | external + static + typed + nullable + fields |
| 138 | `external static int? _foo;` | external + static + typed + nullable + private + fields |
| 139 | `external static final int foo;` | external + static + typed + final + public + fields |
| 140 | `external static final int foo;` | external + static + typed + final + fields |
| 141 | `external static final int _foo;` | external + static + typed + final + private + fields |
| 142 | `external static final int? foo;` | external + static + typed + final + nullable + public + fields |
| 143 | `external static final int? foo;` | external + static + typed + final + nullable + fields |
| 144 | `external static final int? _foo;` | external + static + typed + final + nullable + private + fields |

## Summary of Modifiers

| Modifier | Description |
|----------|-------------|
| `fields` | Base type for all fields |
| `instance` | Field belongs to an instance, not static (mutually exclusive with `static`) |
| `static` | Field belongs to class, not instance (mutually exclusive with `instance`, `overridden`, `new`) |
| `overridden` | Field overrides a superclass abstract field (requires `@override` annotation) (mutually exclusive with `new`) |
| `new` | Field does not override a superclass field (opposite of `overridden`). Indicates the member is new to this class. (mutually exclusive with `overridden`, `static`) |
| `typed` | Field has an explicit type annotation (e.g., `int foo`, `String? bar`) (mutually exclusive with `dynamic`) |
| `dynamic` | Field has inferred or dynamic type (e.g., `var foo`, `final bar = 0`) (mutually exclusive with `typed`) |
| `abstract` | Field has no storage, only defines getter/setter signature (mutually exclusive with `external`, `late`, `initialized`) |
| `external` | Field implementation is provided externally (mutually exclusive with `abstract`, `late`, `initialized`; can be combined with `overridden` or `new`) |
| `late` | Field initialization is deferred until first access (mutually exclusive with `abstract`, `external`) |
| `const` | Compile-time constant (implies `static`, mutually exclusive with `final`, `var`, `late`) |
| `final` | Field can only be assigned once (mutually exclusive with `const`, `var`) |
| `var` | Mutable field (implicit when no `const`/`final`, mutually exclusive with `const`, `final`) |
| `nullable` | Field type is nullable (e.g., `int?`, `T?`) |
| `initialized` | Field has an initializer expression (mutually exclusive with `abstract`, `external`) |
| `private` | Field name starts with `_` |
| `public` | Field name does not start with `_` (explicit visibility) |

## Initialization Rules

| Context | Nullable | Non-nullable |
|---------|----------|--------------|
| Instance field | Can be uninitialized (defaults to `null`) | Must be initialized, `late`, or `final` (constructor init) |
| Instance `final` | Can be uninitialized (constructor init) | Must be initialized or constructor init |
| Instance `late` | Can be uninitialized | Can be uninitialized |
| Static field | Can be uninitialized (defaults to `null`) | Must be initialized or `late` |
| Static `final` | Must be initialized | Must be initialized |
| Static `const` | Must be initialized | Must be initialized |
| Static `late` | Can be uninitialized | Can be uninitialized |
| `abstract` | No initializer allowed | No initializer allowed |
| `external` | No initializer allowed | No initializer allowed |
