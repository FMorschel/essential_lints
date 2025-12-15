# Complete Dart Class Constructor Declaration Patterns

This document lists all valid Dart class constructor declaration patterns and their corresponding modifiers.

## 1. Unnamed Constructors (18 patterns)

Unnamed constructors cannot be private (no `_` prefix possible).

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 1 | `A();` | unnamed + constructors |
| 2 | `A();` | public + constructors |
| 3 | `const A();` | const + unnamed + constructors |
| 4 | `const A();` | const + public + constructors |
| 5 | `external A();` | external + unnamed + constructors |
| 6 | `external A();` | external + public + constructors |
| 7 | `external const A();` | external + const + unnamed + constructors |
| 8 | `external const A();` | external + const + public + constructors |
| 9 | `factory A() { ... }` | factory + unnamed + constructors |
| 10 | `factory A() { ... }` | factory + public + constructors |
| 11 | `external factory A();` | external + factory + unnamed + constructors |
| 12 | `external factory A();` | external + factory + public + constructors |
| 13 | `factory A() = B;` | factory + redirecting + unnamed + constructors |
| 14 | `factory A() = B;` | factory + redirecting + public + constructors |
| 15 | `const factory A() = B;` | const + factory + redirecting + unnamed + constructors |
| 16 | `const factory A() = B;` | const + factory + redirecting + public + constructors |
| 17 | `external const factory A();` | external + const + factory + unnamed + constructors |
| 18 | `external const factory A();` | external + const + factory + public + constructors |

## 2. Named Constructors - Public (18 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 19 | `A.named();` | named + constructors |
| 20 | `A.named();` | public + constructors |
| 21 | `const A.named();` | const + named + constructors |
| 22 | `const A.named();` | const + public + constructors |
| 23 | `external A.named();` | external + named + constructors |
| 24 | `external A.named();` | external + public + constructors |
| 25 | `external const A.named();` | external + const + named + constructors |
| 26 | `external const A.named();` | external + const + public + constructors |
| 27 | `factory A.named() { ... }` | factory + named + constructors |
| 28 | `factory A.named() { ... }` | factory + public + constructors |
| 29 | `external factory A.named();` | external + factory + named + constructors |
| 30 | `external factory A.named();` | external + factory + public + constructors |
| 31 | `factory A.named() = B;` | factory + redirecting + named + constructors |
| 32 | `factory A.named() = B;` | factory + redirecting + public + constructors |
| 33 | `const factory A.named() = B;` | const + factory + redirecting + named + constructors |
| 34 | `const factory A.named() = B;` | const + factory + redirecting + public + constructors |
| 35 | `external const factory A.named();` | external + const + factory + named + constructors |
| 36 | `external const factory A.named();` | external + const + factory + public + constructors |

## 3. Named Constructors - Private (27 patterns)

| # | Dart Declaration | Modifiers |
|---|------------------|-----------|
| 37 | `A._();` | named + constructors |
| 38 | `A._();` | private + constructors |
| 39 | `A._();` | named + private + constructors |
| 40 | `const A._();` | const + named + constructors |
| 41 | `const A._();` | const + private + constructors |
| 42 | `const A._();` | const + named + private + constructors |
| 43 | `external A._();` | external + named + constructors |
| 44 | `external A._();` | external + private + constructors |
| 45 | `external A._();` | external + named + private + constructors |
| 46 | `external const A._();` | external + const + named + constructors |
| 47 | `external const A._();` | external + const + private + constructors |
| 48 | `external const A._();` | external + const + named + private + constructors |
| 49 | `factory A._() { ... }` | factory + named + constructors |
| 50 | `factory A._() { ... }` | factory + private + constructors |
| 51 | `factory A._() { ... }` | factory + named + private + constructors |
| 52 | `external factory A._();` | external + factory + named + constructors |
| 53 | `external factory A._();` | external + factory + private + constructors |
| 54 | `external factory A._();` | external + factory + named + private + constructors |
| 55 | `factory A._() = B;` | factory + redirecting + named + constructors |
| 56 | `factory A._() = B;` | factory + redirecting + private + constructors |
| 57 | `factory A._() = B;` | factory + redirecting + named + private + constructors |
| 58 | `const factory A._() = B;` | const + factory + redirecting + named + constructors |
| 59 | `const factory A._() = B;` | const + factory + redirecting + private + constructors |
| 60 | `const factory A._() = B;` | const + factory + redirecting + named + private + constructors |
| 61 | `external const factory A._();` | external + const + factory + named + constructors |
| 62 | `external const factory A._();` | external + const + factory + private + constructors |
| 63 | `external const factory A._();` | external + const + factory + named + private + constructors |

## Summary of Modifiers

| Modifier | Description |
|----------|-------------|
| `constructors` | Base type for all constructors |
| `named` | Constructor has a name (e.g., `A.named()` or `A._()`) |
| `const` | Constructor can create compile-time constants |
| `external` | Constructor implementation is provided externally |
| `factory` | Factory constructor that may return existing instance or subtype |
| `redirecting` | Factory constructor that redirects to another constructor (e.g., `= B`) |
| `unnamed` | Constructor has no name (e.g., `A()`) - mutually exclusive with `public`/`private` |
| `private` | Constructor name starts with `_` (e.g., `A._()`) - requires `named` |
| `(public)` | Constructor name does not start with `_` (implicit, shown for clarity) - requires `named` |

## Visibility Modifiers

The modifiers `unnamed`, `public`, and `private` are mutually exclusive siblings:

- `unnamed` - The default constructor with no name (e.g., `A()`)
- `public` - A named constructor with a public name (e.g., `A.create()`)
- `private` - A named constructor with a private name starting with `_` (e.g., `A._()`)

A constructor can only have one of these three modifiers
.
