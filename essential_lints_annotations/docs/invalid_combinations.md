# Dart Class Member Declaration: Invalid Combinations

This document collects all invalid modifier combinations for Dart class member declarations, as referenced in the pattern documentation for constructors, fields, getters, setters, and methods.

---

## Modifier-to-Member Type Compatibility

Each modifier can only be applied to specific member types. Applying a modifier to an incompatible member type is invalid.

### Modifiers and Their Valid Member Types

- `abstract` → fields, getters, setters, methods
- `const` → fields (must be static), constructors
- `dynamic` → fields, getters, setters, methods (mutually exclusive with `typed`)
- `external` → fields, getters, setters, methods, constructors
- `factory` → constructors only
- `final` → fields only
- `initialized` → fields only
- `instance` → fields, getters, setters, methods (mutually exclusive with `static`)
- `late` → fields only
- `named` → constructors only
- `new` → fields, getters, setters, methods (mutually exclusive with `overridden`, `static`)
- `operator` → methods only
- `overridden` (@override) → fields, getters, setters, methods (mutually exclusive with `static`, `new`)
- `redirecting` → constructors only
- `static` → fields, getters, setters, methods (mutually exclusive with `instance`, `overridden`, `new`)
- `typed` → fields, getters, setters, methods (mutually exclusive with `dynamic`)
- `var` → fields only

### Invalid Modifier Applications

- Applying `factory` to fields, getters, setters, or methods
- Applying `late` to constructors, getters, setters, or methods
- Applying `final` or `var` to constructors, getters, setters, or methods
- Applying `operator` to fields, getters, setters, or constructors
- Applying `redirecting` to fields, getters, setters, or methods
- Applying `static` to constructors
- Applying `overridden` to constructors or static members
- Applying `new` to constructors or static members
- Applying `typed` or `dynamic` to constructors
- Applying `const` to getters, setters, or methods
- Applying `instance` to constructors

---

## Restrictions by Modifier

This section organizes restrictions by modifier, showing which other modifiers and contexts are invalid for each modifier.

### `abstract`

- Cannot apply to: constructors
- Cannot be combined with: `external`, `static`, `initialized`, `late`
- Cannot have inside: `abstract`, `instance`, `static`, `overridden`, `new`, `external`, `late`, `final`, `var`, `const`

### `const`

- Cannot apply to: getters, setters, methods (only fields and constructors)
- Cannot be combined with: `final`, `late`, `var`, `instance`, `abstract`, `external`, `overridden`, `new`
- Cannot have inside: `const`, `external`
- Additional: When applied to fields, must be static (not instance)

### `dynamic`

- Cannot apply to: constructors
- Cannot be combined with: `typed`
- Cannot have inside: `dynamic`, `instance`, `static`, `overridden`, `new`, `external`, `late`, `final`, `var`, `const`, `abstract`

### `external`

- Cannot apply to: (applies to all member types)
- Cannot be combined with: `abstract`, `late`, `initialized`, `redirecting`
- Cannot have inside: `external`

### `factory`

- Cannot apply to: fields, getters, setters, methods (only constructors)
- Cannot be combined with: (no incompatibilities)
- Cannot have inside: `factory`

### `final`

- Cannot apply to: constructors, getters, setters, methods (only fields)
- Cannot be combined with: `const`, `var`
- Cannot have inside: `final`, `late`

### `initialized`

- Cannot apply to: constructors, getters, setters, methods (only fields)
- Cannot be combined with: `abstract`, `external`
- Cannot have inside: `initialized`, `instance`, `static`, `overridden`, `new`, `external`, `late`, `final`, `var`, `const`, `abstract`, `typed`, `dynamic`, `nullable`

### `instance`

- Cannot apply to: constructors (always instance-level)
- Cannot be combined with: `static`
- Cannot have inside: `instance`

### `late`

- Cannot apply to: constructors, getters, setters, methods (only fields)
- Cannot be combined with: `abstract`, `external`, `const`
- Cannot have inside: `late`, `instance`, `static`

### `named`

- Cannot apply to: fields, getters, setters, methods (only constructors)
- Cannot be combined with: `unnamed`
- Cannot have inside: `named`, `external`, `const`, `factory`

### `new`

- Cannot apply to: constructors (only fields, getters, setters, methods)
- Cannot be combined with: `overridden`, `static`
- Cannot have inside: `new`, `instance`

### `nullable`

- Cannot apply to: constructors (only fields, getters, setters, methods)
- Cannot be combined with: (no incompatibilities)
- Cannot have inside: `nullable`, `instance`, `static`, `overridden`, `new`, `external`, `late`, `final`, `var`, `const`, `abstract`, `typed`, `dynamic`

### `operator`

- Cannot apply to: constructors, fields, getters, setters (only methods)
- Cannot be combined with: `static`, `private`, `public`
- Cannot have inside: `operator`, `instance`, `overridden`, `external`, `abstract`, `typed`, `nullable`

### `overridden` (@override)

- Cannot apply to: constructors (only fields, getters, setters, methods)
- Cannot be combined with: `static`, `new`, `const`
- Cannot have inside: `overridden`, `instance`

### `private`

- Cannot apply to: (applies to all member types except operators)
- Cannot be combined with: `public`, `operator`, `unnamed`
- Cannot have inside: `private`, `instance`, `static`, `overridden`, `new`, `external`, `late`, `final`, `var`, `const`, `abstract`, `typed`, `dynamic`, `nullable`, `operator`, `factory`, `redirecting`, `named`, `unnamed`

### `public`

- Cannot apply to: (applies to all member types except operators)
- Cannot be combined with: `private`, `operator`, `unnamed`
- Cannot have inside: `public`, `instance`, `static`, `overridden`, `new`, `external`, `late`, `final`, `var`, `const`, `abstract`, `typed`, `dynamic`, `nullable`, `operator`, `factory`, `redirecting`, `named`, `unnamed`

### `redirecting`

- Cannot apply to: fields, getters, setters, methods (only constructors)
- Cannot be combined with: `external`
- Cannot have inside: `redirecting`, `external`, `const`, `factory`

### `static`

- Cannot apply to: constructors (only fields, getters, setters, methods)
- Cannot be combined with: `instance`, `overridden`, `new`, `abstract`, `operator`
- Cannot have inside: `static`

### `typed`

- Cannot apply to: constructors
- Cannot be combined with: `dynamic`
- Cannot have inside: `typed`, `instance`, `static`, `overridden`, `new`, `external`, `late`, `final`, `var`, `const`, `abstract`

### `unnamed`

- Cannot apply to: fields, getters, setters, methods (only constructors)
- Cannot be combined with: `private`, `public`, `named`
- Cannot have inside: `unnamed`, `external`, `const`, `factory`

### `var`

- Cannot apply to: constructors, getters, setters, methods (only fields)
- Cannot be combined with: `const`, `final`
- Cannot have inside: `var`, `late`, `final`, `instance`, `static`

---

## Constructors

- `const` + `factory` (non-redirecting) — Factory constructors with bodies cannot be const
- `external` + `redirecting` — External factories cannot redirect
- `external` + body — External constructors cannot have a body
- `private` + unnamed — Private constructors must be named (e.g., `A._()`)
- `static` — Constructors cannot be static
- `overridden` — Constructors cannot be overridden
- `new` — Constructors cannot have the `new` modifier
- `instance` — Constructors cannot be instance

---

## Fields

- `static` + `overridden` - Cannot override static fields
- `static` + `new` - Static fields cannot have the `new` modifier
- `static` + `abstract` - Static fields cannot be abstract
- `overridden` + `new` - Mutually exclusive modifiers (a member cannot be both overridden and new)
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
- `static` + `new` — Static getters cannot have the `new` modifier
- `static` + `abstract` — Static getters cannot be abstract
- `overridden` + `new` — Mutually exclusive modifiers (a member cannot be both overridden and new)
- `abstract` + `external` — A getter cannot be both abstract and external
- `public` + `private` — Mutually exclusive visibility modifiers

---

## Setters

- `static` + `overridden` — Cannot override static setters
- `static` + `new` — Static setters cannot have the `new` modifier
- `static` + `abstract` — Static setters cannot be abstract
- `overridden` + `new` — Mutually exclusive modifiers (a member cannot be both overridden and new)
- `abstract` + `external` — A setter cannot be both abstract and external
- `public` + `private` — Mutually exclusive visibility modifiers

---

## Methods

- `static` + `overridden` — Cannot override static methods
- `static` + `new` — Static methods cannot have the `new` modifier
- `static` + `abstract` — Static methods cannot be abstract
- `static` + `operator` — Operators cannot be static
- `overridden` + `new` — Mutually exclusive modifiers (a member cannot be both overridden and new)
- `abstract` + `external` — A method cannot be both abstract and external
- `operator` + `private` — Operators use symbols, not identifiable names
- `public` + `private` — Mutually exclusive visibility modifiers

---
