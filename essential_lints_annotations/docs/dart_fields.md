# Complete Dart Class Field Declaration Patterns

This document lists all valid Dart class field declaration patterns and their corresponding modifiers.

## 1. Instance Fields - Regular (9 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 1 | `int foo = 0;` | initialized + public + fields |
| 2 | `int foo = 0;` | initialized + fields |
| 3 | `int _foo = 0;` | initialized + private + fields |
| 4 | `int? foo;` | nullable + public + fields |
| 5 | `int? foo;` | nullable + fields |
| 6 | `int? _foo;` | nullable + private + fields |
| 7 | `int? foo = null;` | nullable + initialized + public + fields |
| 8 | `int? foo = null;` | nullable + initialized + fields |
| 9 | `int? _foo = null;` | nullable + initialized + private + fields |

## 2. Instance Fields - Final (12 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 10 | `final int foo = 0;` | final + initialized + public + fields |
| 11 | `final int foo = 0;` | final + initialized + fields |
| 12 | `final int _foo = 0;` | final + initialized + private + fields |
| 13 | `final int foo;` | final + public + fields |
| 14 | `final int foo;` | final + fields |
| 15 | `final int _foo;` | final + private + fields |
| 16 | `final int? foo;` | final + nullable + public + fields |
| 17 | `final int? foo;` | final + nullable + fields |
| 18 | `final int? _foo;` | final + nullable + private + fields |
| 19 | `final int? foo = null;` | final + nullable + initialized + public + fields |
| 20 | `final int? foo = null;` | final + nullable + initialized + fields |
| 21 | `final int? _foo = null;` | final + nullable + initialized + private + fields |

## 3. Instance Fields - Late (12 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 22 | `late int foo;` | late + public + fields |
| 23 | `late int foo;` | late + fields |
| 24 | `late int _foo;` | late + private + fields |
| 25 | `late int foo = 0;` | late + initialized + public + fields |
| 26 | `late int foo = 0;` | late + initialized + fields |
| 27 | `late int _foo = 0;` | late + initialized + private + fields |
| 28 | `late int? foo;` | late + nullable + public + fields |
| 29 | `late int? foo;` | late + nullable + fields |
| 30 | `late int? _foo;` | late + nullable + private + fields |
| 31 | `late int? foo = null;` | late + nullable + initialized + public + fields |
| 32 | `late int? foo = null;` | late + nullable + initialized + fields |
| 33 | `late int? _foo = null;` | late + nullable + initialized + private + fields |

## 4. Instance Fields - Late Final (12 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 34 | `late final int foo;` | late + final + public + fields |
| 35 | `late final int foo;` | late + final + fields |
| 36 | `late final int _foo;` | late + final + private + fields |
| 37 | `late final int foo = 0;` | late + final + initialized + public + fields |
| 38 | `late final int foo = 0;` | late + final + initialized + fields |
| 39 | `late final int _foo = 0;` | late + final + initialized + private + fields |
| 40 | `late final int? foo;` | late + final + nullable + public + fields |
| 41 | `late final int? foo;` | late + final + nullable + fields |
| 42 | `late final int? _foo;` | late + final + nullable + private + fields |
| 43 | `late final int? foo = null;` | late + final + nullable + initialized + public + fields |
| 44 | `late final int? foo = null;` | late + final + nullable + initialized + fields |
| 45 | `late final int? _foo = null;` | late + final + nullable + initialized + private + fields |

## 5. Instance Fields - Abstract (12 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 46 | `abstract int foo;` | abstract + public + fields |
| 47 | `abstract int foo;` | abstract + fields |
| 48 | `abstract int _foo;` | abstract + private + fields |
| 49 | `abstract int? foo;` | abstract + nullable + public + fields |
| 50 | `abstract int? foo;` | abstract + nullable + fields |
| 51 | `abstract int? _foo;` | abstract + nullable + private + fields |
| 52 | `abstract final int foo;` | abstract + final + public + fields |
| 53 | `abstract final int foo;` | abstract + final + fields |
| 54 | `abstract final int _foo;` | abstract + final + private + fields |
| 55 | `abstract final int? foo;` | abstract + final + nullable + public + fields |
| 56 | `abstract final int? foo;` | abstract + final + nullable + fields |
| 57 | `abstract final int? _foo;` | abstract + final + nullable + private + fields |

## 6. Instance Fields - External (12 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 58 | `external int foo;` | external + public + fields |
| 59 | `external int foo;` | external + fields |
| 60 | `external int _foo;` | external + private + fields |
| 61 | `external int? foo;` | external + nullable + public + fields |
| 62 | `external int? foo;` | external + nullable + fields |
| 63 | `external int? _foo;` | external + nullable + private + fields |
| 64 | `external final int foo;` | external + final + public + fields |
| 65 | `external final int foo;` | external + final + fields |
| 66 | `external final int _foo;` | external + final + private + fields |
| 67 | `external final int? foo;` | external + final + nullable + public + fields |
| 68 | `external final int? foo;` | external + final + nullable + fields |
| 69 | `external final int? _foo;` | external + final + nullable + private + fields |

## 7. Instance Fields - Overridden (18 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 70 | `@override int foo = 0;` | overridden + initialized + public + fields |
| 71 | `@override int foo = 0;` | overridden + initialized + fields |
| 72 | `@override int _foo = 0;` | overridden + initialized + private + fields |
| 73 | `@override int? foo;` | overridden + nullable + public + fields |
| 74 | `@override int? foo;` | overridden + nullable + fields |
| 75 | `@override int? _foo;` | overridden + nullable + private + fields |
| 76 | `@override final int foo = 0;` | overridden + final + initialized + public + fields |
| 77 | `@override final int foo = 0;` | overridden + final + initialized + fields |
| 78 | `@override final int _foo = 0;` | overridden + final + initialized + private + fields |
| 79 | `@override final int? foo;` | overridden + final + nullable + public + fields |
| 80 | `@override final int? foo;` | overridden + final + nullable + fields |
| 81 | `@override final int? _foo;` | overridden + final + nullable + private + fields |
| 82 | `@override late int foo;` | overridden + late + public + fields |
| 83 | `@override late int foo;` | overridden + late + fields |
| 84 | `@override late int _foo;` | overridden + late + private + fields |
| 85 | `@override late final int foo;` | overridden + late + final + public + fields |
| 86 | `@override late final int foo;` | overridden + late + final + fields |
| 87 | `@override late final int _foo;` | overridden + late + final + private + fields |

## 8. Instance Fields - Var (18 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 88 | `var foo = 0;` | var + initialized + public + fields |
| 89 | `var foo = 0;` | var + initialized + fields |
| 90 | `var _foo = 0;` | var + initialized + private + fields |
| 91 | `late var foo;` | var + late + public + fields |
| 92 | `late var foo;` | var + late + fields |
| 93 | `late var _foo;` | var + late + private + fields |
| 94 | `late var foo = 0;` | var + late + initialized + public + fields |
| 95 | `late var foo = 0;` | var + late + initialized + fields |
| 96 | `late var _foo = 0;` | var + late + initialized + private + fields |
| 97 | `late final var foo;` | var + late + final + public + fields |
| 98 | `late final var foo;` | var + late + final + fields |
| 99 | `late final var _foo;` | var + late + final + private + fields |
| 100 | `late final var foo = 0;` | var + late + final + initialized + public + fields |
| 101 | `late final var foo = 0;` | var + late + final + initialized + fields |
| 102 | `late final var _foo = 0;` | var + late + final + initialized + private + fields |
| 103 | `@override var foo = 0;` | var + overridden + initialized + public + fields |
| 104 | `@override var foo = 0;` | var + overridden + initialized + fields |
| 105 | `@override var _foo = 0;` | var + overridden + initialized + private + fields |

## 9. Static Fields - Regular (15 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 109 | `static int foo = 0;` | static + initialized + public + fields |
| 110 | `static int foo = 0;` | static + initialized + fields |
| 111 | `static int _foo = 0;` | static + initialized + private + fields |
| 112 | `static int? foo;` | static + nullable + public + fields |
| 113 | `static int? foo;` | static + nullable + fields |
| 114 | `static int? _foo;` | static + nullable + private + fields |
| 115 | `static int? foo = null;` | static + nullable + initialized + public + fields |
| 116 | `static int? foo = null;` | static + nullable + initialized + fields |
| 117 | `static int? _foo = null;` | static + nullable + initialized + private + fields |
| 118 | `static final int foo = 0;` | static + final + initialized + public + fields |
| 119 | `static final int foo = 0;` | static + final + initialized + fields |
| 120 | `static final int _foo = 0;` | static + final + initialized + private + fields |
| 121 | `static final int? foo = null;` | static + final + nullable + initialized + public + fields |
| 122 | `static final int? foo = null;` | static + final + nullable + initialized + fields |
| 123 | `static final int? _foo = null;` | static + final + nullable + initialized + private + fields |

## 10. Static Fields - Const (6 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 124 | `static const int foo = 0;` | static + const + initialized + public + fields |
| 125 | `static const int foo = 0;` | static + const + initialized + fields |
| 126 | `static const int _foo = 0;` | static + const + initialized + private + fields |
| 127 | `static const int? foo = null;` | static + const + nullable + initialized + public + fields |
| 128 | `static const int? foo = null;` | static + const + nullable + initialized + fields |
| 129 | `static const int? _foo = null;` | static + const + nullable + initialized + private + fields |

## 11. Static Fields - Late (24 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 130 | `static late int foo;` | static + late + public + fields |
| 131 | `static late int foo;` | static + late + fields |
| 132 | `static late int _foo;` | static + late + private + fields |
| 133 | `static late int foo = 0;` | static + late + initialized + public + fields |
| 134 | `static late int foo = 0;` | static + late + initialized + fields |
| 135 | `static late int _foo = 0;` | static + late + initialized + private + fields |
| 136 | `static late int? foo;` | static + late + nullable + public + fields |
| 137 | `static late int? foo;` | static + late + nullable + fields |
| 138 | `static late int? _foo;` | static + late + nullable + private + fields |
| 139 | `static late int? foo = null;` | static + late + nullable + initialized + public + fields |
| 140 | `static late int? foo = null;` | static + late + nullable + initialized + fields |
| 141 | `static late int? _foo = null;` | static + late + nullable + initialized + private + fields |
| 142 | `static late final int foo;` | static + late + final + public + fields |
| 143 | `static late final int foo;` | static + late + final + fields |
| 144 | `static late final int _foo;` | static + late + final + private + fields |
| 145 | `static late final int foo = 0;` | static + late + final + initialized + public + fields |
| 146 | `static late final int foo = 0;` | static + late + final + initialized + fields |
| 147 | `static late final int _foo = 0;` | static + late + final + initialized + private + fields |
| 148 | `static late final int? foo;` | static + late + final + nullable + public + fields |
| 149 | `static late final int? foo;` | static + late + final + nullable + fields |
| 150 | `static late final int? _foo;` | static + late + final + nullable + private + fields |
| 151 | `static late final int? foo = null;` | static + late + final + nullable + initialized + public + fields |
| 152 | `static late final int? foo = null;` | static + late + final + nullable + initialized + fields |
| 153 | `static late final int? _foo = null;` | static + late + final + nullable + initialized + private + fields |

## 12. Static Fields - External (12 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 133 | `external static int foo;` | external + static + public + fields |
| 134 | `external static int foo;` | external + static + fields |
| 135 | `external static int _foo;` | external + static + private + fields |
| 136 | `external static int? foo;` | external + static + nullable + public + fields |
| 137 | `external static int? foo;` | external + static + nullable + fields |
| 138 | `external static int? _foo;` | external + static + nullable + private + fields |
| 139 | `external static final int foo;` | external + static + final + public + fields |
| 140 | `external static final int foo;` | external + static + final + fields |
| 141 | `external static final int _foo;` | external + static + final + private + fields |
| 142 | `external static final int? foo;` | external + static + final + nullable + public + fields |
| 143 | `external static final int? foo;` | external + static + final + nullable + fields |
| 144 | `external static final int? _foo;` | external + static + final + nullable + private + fields |

## Summary of Modifiers

| Modifier | Description |
|----------|-------------|
| `fields` | Base type for all fields |
| `static` | Field belongs to class, not instance (mutually exclusive with `overridden`) |
| `overridden` | Field overrides a superclass abstract field (requires `@override` annotation) |
| `abstract` | Field has no storage, only defines getter/setter signature (mutually exclusive with `external`, `late`, `initialized`) |
| `external` | Field implementation is provided externally (mutually exclusive with `abstract`, `late`, `initialized`) |
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
