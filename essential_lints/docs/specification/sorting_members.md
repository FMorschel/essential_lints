# SortingMembers Rule Specification

## Overview

The `SortingMembers` rule enforces a consistent order of class members through an annotation-based system. This rule allows developers to specify custom member ordering using the `@SortingMembers` annotation with a flexible, declarative syntax.

## Purpose

- Enforce consistent member ordering across classes, mixins, extensions, extension types, and enums
- Support fine-grained control over member ordering based on modifiers, types, and names
- Enable project-specific conventions for code organization
- Improve code readability and maintainability through predictable structure

## Annotation Syntax

### Basic Syntax

```dart
@SortingMembers({
  <declaration1>,
  <declaration2>,
  ...
})
```

The annotation accepts a `Set<SortDeclaration>` where declarations are evaluated in the order they appear. Each declaration specifies a pattern that members should match.

### Declaration Types

Declarations use Dart's enhanced enum-style syntax with leading dots:

#### 1. Member Groups

These match all members of a specific type:

- `.fields` - All field declarations
- `.constructors` - All constructors
- `.methods` - All method declarations
- `.getters` - All getter declarations
- `.setters` - All setter declarations
- `.gettersSetters` - All getters and setters (treated as a group)
- `.fieldsGettersSetters` - All fields, getters, and setters (treated as a group)

#### 2. Specific Members

These target individual members by name:

- `.field(#name)` - A specific field
- `.constructor([#name])` - A specific constructor (optional name for unnamed constructor)
- `.method(#name)` - A specific method
- `.getter(#name)` - A specific getter
- `.setter(#name)` - A specific setter

#### 3. Modifiers

Modifiers can be applied to groups or combined to create more specific patterns:

**Access Modifiers:**

- `.public(...)` - Public members
- `.private(...)` - Private members (prefixed with `_`)

**State Modifiers:**

- `.abstract(...)` - Abstract members
- `.static(...)` - Static members
- `.external(...)` - External members
- `.overridden(...)` - Overridden members (with `@override`)

**Field Modifiers:**

- `.var_(...)` - Fields declared with `var`
- `.final_(...)` - Final fields
- `.const_(...)` - Const fields
- `.late(...)` - Late fields
- `.initialized(...)` - Initialized fields
- `.nullable(...)` - Nullable fields

**Constructor Modifiers:**

- `.factory_(...)` - Factory constructors
- `.named(...)` - Named constructors
- `.unnamed(...)` - Unnamed constructors
- `.redirecting(...)` - Redirecting constructors

**Method Modifiers:**

- `.operator(...)` - Operator methods

## Member Matching Algorithm

### Validation Process

When a member is encountered, the rule:

1. **Checks current validator** - Determines if the member matches the current declaration in the sequence
2. **Searches for more specific matches** - If matched, checks ALL validators (not just future ones) for a more specific match
3. **Handles specificity** - If a more specific validator exists:
   - If ahead: jumps to that validator (member is correctly ordered)
   - If behind: reports an error (member should have appeared earlier)
4. **Checks previous validators** - If no match found, checks if member matches any previous validator (incorrect ordering) and reports an error
5. **Advances to next validator** - If no match in current or previous, searches forward for a matching validator

### Specificity Rules

A validator is considered "more specific" than another if:

- It has all the validators from the less specific one
- It has additional validators (making it more restrictive)

Example:

- `.unnamed(.constructors)` is more specific than `.constructors`
- `.static(.public(.fields))` is more specific than `.static(.fields)`

### Error Reporting

The rule reports a diagnostic at the member's name token (or return type for unnamed constructors) when:

- A member matches a validator that appears earlier in the sequence (wrong order)
- A more specific validator exists behind the current position

## Examples

### Example 1: Basic Constructor Ordering

```dart
@SortingMembers({
  .unnamed(.constructors),
  .constructors,
})
class A {
  A.named(); // ERROR: named constructor before unnamed
  A();
}
```

**Explanation:** The annotation specifies unnamed constructors should come first, then all other constructors. The unnamed constructor `A()` appears after the named constructor, violating the rule.

### Example 2: Correct Constructor Ordering

```dart
@SortingMembers({
  .unnamed(.constructors),
  .constructors,
})
class A {
  A();       // OK: unnamed constructor first
  A.named(); // OK: named constructor follows
}
```

### Example 3: Named Constructor Priority

```dart
@SortingMembers({
  .constructors,
  .unnamed(.constructors),
})
class A {
  A();       // ERROR: unnamed should come last
  A.named();
}
```

**Explanation:** When all constructors come before unnamed constructors, the unnamed constructor must appear last.

### Example 4: Complex Field Ordering

```dart
@SortingMembers({
  .static(.const_(.fields)),
  .static(.final_(.fields)),
  .static(.fields),
  .final_(.fields),
  .fields,
})
class MyClass {
  static const int CONSTANT = 1;
  static final String config = 'value';
  static int counter = 0;
  final String name;
  int value = 0;
}
```

### Example 5: Member Type Grouping

```dart
@SortingMembers({
  .constructors,
  .fields,
  .getters,
  .setters,
  .methods,
})
class UserProfile {
  // Constructors
  UserProfile(this.name, this.email);
  UserProfile.guest() : name = 'Guest', email = '';

  // Fields
  final String name;
  final String email;

  // Getters
  String get displayName => name.toUpperCase();

  // Setters
  set updateEmail(String newEmail) { /* ... */ }

  // Methods
  void save() { /* ... */ }
  void delete() { /* ... */ }
}
```

### Example 6: Public/Private Separation

```dart
@SortingMembers({
  .public(.fields),
  .private(.fields),
  .public(.methods),
  .private(.methods),
})
class DataStore {
  // Public fields
  String version = '1.0';

  // Private fields
  String _apiKey = '';

  // Public methods
  void loadData() { /* ... */ }

  // Private methods
  void _validateKey() { /* ... */ }
}
```

### Example 7: Specific Member Ordering

```dart
@SortingMembers({
  .field(#id),
  .field(#name),
  .fields,
})
class Entity {
  final int id;      // Must be first
  final String name; // Must be second
  String? description; // Other fields follow
  DateTime? createdAt;
}
```

## Supported Targets

The `@SortingMembers` annotation can be applied to:

- Classes (`@Target.classType`)
- Mixins (`@Target.mixinType`)
- Extensions (`@Target.extension`)
- Extension Types (`@Target.extensionType`)
- Enums (`@Target.enumType`)

## Diagnostic Information

**Diagnostic Code:** `sorting_members`

**Severity:** Warning

**Message:** Displayed when a member is out of order according to the specified declaration sequence.

## Implementation Notes

### Current Limitations

1. **Single Error per Class** - The rule stops after reporting the first ordering violation (`_reported` flag)
2. **No Automatic Fixing** - The rule identifies violations but does not provide automatic code fixes
3. **Declaration Order Matters** - The sequence in the Set is significant

### Validator Types

The implementation uses a hierarchy of validator classes:

- `_MemberTypeValidator` - Base sealed class for all validators
- `_ListMemberTypeValidator` - Combines multiple validators with AND logic
- Type-specific validators (e.g., `_FieldMemberTypeValidator`, `_ConstructorMemberTypeValidator`)
- Modifier validators (e.g., `_StaticMemberTypeValidator`, `_PrivateMemberTypeValidator`)
- Named validators (e.g., `_ExpectedNamedMemberTypeValidator`)

### Member Visitation

The rule uses a `_MemberVisitor` that extends `RecursiveAstVisitor<void>` and visits:

- Constructor declarations
- Field declarations (with special handling for multiple variables)
- Method declarations

## Best Practices

1. **Order by Specificity** - Place more specific declarations before general ones when they overlap
2. **Group Related Members** - Use member groups (`.fieldsGettersSetters`) to keep related code together

## Related Issues

- GitHub Issue #3: Initial proposal for sorting-members lint rule
- GitHub Issue #5: Sort members annotation design
- Inspired by DCM's `member-ordering` rule

## See Also

- [SortingMembers Annotation Documentation](../../essential_lints_annotations/lib/src/sorting_members.dart)
- [Sort Declaration Types](../../essential_lints_annotations/lib/src/sorting_members/sort_declarations.dart)
- [Example Field Patterns](../../essential_lints_annotations/docs/examples/example_fields.dart)
- [Example Constructor Patterns](../../essential_lints_annotations/docs/examples/example_constructors.dart)
