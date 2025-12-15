# Dart Class Member Declaration: Invalid Combinations

This document collects all invalid modifier combinations for Dart class member declarations, as referenced in the pattern documentation for constructors, fields, getters, setters, and methods.

---

## Modifier-to-Member Type Compatibility

Each modifier can only be applied to specific member types. Applying a modifier to an incompatible member type is invalid.

### Modifiers and Their Valid Member Types

- `abstract` → fields, getters, setters, methods
- `const` → fields (must be static), constructors
- `external` → fields, getters, setters, methods, constructors
- `factory` → constructors only
- `final` → fields only
- `initialized` → fields only
- `late` → fields only
- `named` → constructors only
- `operator` → methods only
- `overridden` (@override) → fields, getters, setters, methods (non-static/instance members only)
- `redirecting` → constructors only
- `static` → fields, getters, setters, methods
- `var` → fields only

### Invalid Modifier Applications

- Applying `factory` to fields, getters, setters, or methods
- Applying `late` to constructors, getters, setters, or methods
- Applying `final` or `var` to constructors, getters, setters, or methods
- Applying `operator` to fields, getters, setters, or constructors
- Applying `redirecting` to fields, getters, setters, or methods
- Applying `static` to constructors
- Applying `overridden` to constructors or static members

---

## Restrictions by Modifier

This section organizes restrictions by modifier, showing which other modifiers and contexts are invalid for each modifier.

### `abstract`

- Cannot apply to: constructors
- Cannot be combined with: `external`, `static`, `initialized`, `late`
- Cannot have inner modifiers: `abstract`

### `const`

- Cannot apply to: getters, setters, methods (only fields and constructors)
- Cannot be combined with: `final`, `late`, `var`
- Cannot have inner modifiers: `const`, `abstract`, `external`, `overridden`
- Additional: When applied to fields, must be static (not instance).

### `external`

- Cannot apply to: (applies to all member types)
- Cannot be combined with: `abstract`, `late`, `initialized`, `redirecting`
- Cannot have inner modifiers: `external`, `overridden`

### `factory`

- Cannot apply to: fields, getters, setters, methods (only constructors)
- Cannot have inner modifiers: `factory`

### `final`

- Cannot apply to: constructors, getters, setters, methods (only fields)
- Cannot be combined with: `const` and `var`
- Cannot have inner modifiers: `final`, `late`, `abstract`, `external`, `overridden`, `static`

### `initialized`

- Cannot apply to: constructors, getters, setters, methods (only fields)
- Cannot be combined with: `abstract`, `external`
- Cannot have inner modifiers: `initialized`, `late`, `overridden`, `static`

### `late`

- Cannot apply to: constructors, getters, setters, methods (only fields)
- Cannot be combined with: `abstract`, `external`, `const`
- Cannot have inner modifiers: `late`, `overridden`, `static`

### `named`

- Cannot apply to: fields, getters, setters, methods (only constructors)
- Incompatible with: `unnamed`
- Cannot have inner modifiers: `named`, `factory`, `const`, `external`

### `nullable`

- Cannot apply to: constructors (only fields, getters, setters, methods)
- Cannot be combined with: (no direct modifier conflicts)
- Cannot have inner modifiers: `late`, `abstract`, `external`, `overridden`, `static`, `const`, `var`, `final`, `nullable`

### `operator`

- Cannot apply to: constructors, fields, getters, setters (only methods)
- Cannot be combined with: `static`, `private`, `public`
- Cannot have inner modifiers: `operator`

### `overridden` (@override)

- Cannot apply to: constructors (only fields, getters, setters, methods)
- Cannot be combined with: `static`,
- Cannot have inner modifiers: `overridden`

### `private`

- Cannot apply to: (applies to all member types)
- Cannot be combined with: `public`, `operator`
- Cannot have inner modifiers: `private`, `factory`, `const`, `external`, `unnamed`,
  `named`, `late`, `final`, `var`, `nullable`, `overridden`, `static`, `abstract`, `initialized`, `redirecting`

### `public`

- Cannot apply to: (applies to all member types)
- Cannot be combined with: `private`, `operator`
- Cannot have inner modifiers: `public`, `factory`, `const`, `external`, `unnamed`,
  `named`, `late`, `final`, `var`, `nullable`, `overridden`, `static`, `abstract`, `initialized`, `redirecting`

### `redirecting`

- Cannot apply to: fields, getters, setters, methods (only constructors)
- Cannot be combined with: `external`
- Cannot have inner modifiers: `redirecting`, `factory`, `const`, `external`

### `static`

- Cannot apply to: constructors (only fields, getters, setters, methods)
- Cannot be combined with: `overridden`, `abstract`, `operator`
- Cannot have inner modifiers: `static`, `external`

### `unnamed`

- Cannot apply to: fields, getters, setters, methods (only constructors)
- Cannot be combined with: `private`, `public`, `named`
- Cannot have inner modifiers: `unnamed`, `factory`, `const`, `external`

### `var`

- Cannot apply to: constructors, getters, setters, methods (only fields)
- Cannot have inner modifiers: `late`, `abstract`, `external`, `overridden`, `static`, `var`
- Incompatible with `const` and `final` (mutually exclusive mutability modifiers)

---

## Constructors

- `const` + `factory` (non-redirecting) — Factory constructors with bodies cannot be const
- `external` + `redirecting` — External factories cannot redirect
- `external` + body — External constructors cannot have a body
- `private` + unnamed — Private constructors must be named (e.g., `A._()`)
- `static` — Constructors cannot be static
- `overridden` — Constructors cannot be overridden

---

## Fields

- `static` + `overridden` - Cannot override static fields
- `static` + `abstract` - Static fields cannot be abstract
- `abstract` + `external` - A field cannot be both abstract and external
- `abstract` + `late` - Abstract fields cannot be late
- `abstract` + `initialized` - Abstract fields cannot have initializers
- `external` + `late` - External fields cannot be late
- `external` + `initialized` - External fields cannot have initializers
- `const` + `final` - Mutually exclusive mutability modifiers
- `const` + `late` - Const fields cannot be late
- `const` + instance field - Const fields must be static
- `overridden` + `abstract` - Overriding fields provide implementation
- `overridden` + `external` - Overriding fields provide implementation
- `public` + `private` - Mutually exclusive visibility modifiers
- Non-nullable instance field without `late` or `final` - Must be initialized
- Non-nullable static field without `late` - Must be initialized

---

## Getters

- `static` + `overridden` — Cannot override static getters
- `static` + `abstract` — Static getters cannot be abstract
- `abstract` + `external` — A getter cannot be both abstract and external
- `public` + `private` — Mutually exclusive visibility modifiers

---

## Setters

- `static` + `overridden` — Cannot override static setters
- `static` + `abstract` — Static setters cannot be abstract
- `abstract` + `external` — A setter cannot be both abstract and external
- `public` + `private` — Mutually exclusive visibility modifiers

---

## Methods

- `static` + `overridden` — Cannot override static methods
- `static` + `abstract` — Static methods cannot be abstract
- `static` + `operator` — Operators cannot be static
- `abstract` + `external` — A method cannot be both abstract and external
- `operator` + `private` — Operators use symbols, not identifiable names
- `public` + `private` — Mutually exclusive visibility modifiers

---
