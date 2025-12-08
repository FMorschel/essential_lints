# essential_lints_annotations

This package provides annotations that configure lint rules from the [`essential_lints`](https://pub.dev/packages/essential_lints) package. These annotations help Dart/Flutter developers define custom lint behavior for their codebases.

## Features

This package includes the following annotations:

- **`GettersInMemberList`** - Ensures that getters and fields are included in a specified member list (useful for ensuring completeness of introspection lists)
- **`SubtypeAnnotating`** - Requires specific annotations on subtypes of an annotated class, mixin, enum, or extension type
- **`SubtypeNaming`** - Enforces naming conventions (prefix, suffix, or containing pattern) for subtypes of an annotated type

## Getting started

Add `essential_lints_annotations` to your `analysis_options.yaml` plugins:

```yaml
dependencies:
  essential_lints_annotations: ^0.1.0
```

Ensure you have the [`essential_lints`](https://pub.dev/packages/essential_lints) package configured in your `analysis_options.yaml` to enable these lint rules.

## Usage

### GettersInMemberList

Use this annotation to ensure that all relevant getters and fields of a class are included in a specific member list. This is useful for classes that need introspection capabilities or validation of their members.

```dart
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@GettersInMemberList(memberListName: 'members')
class Person {
  Person(this.name, this.age);

  final String name;
  final int age;

  // The lint will warn if 'name' or 'age' are not included in this list
  List<Object?> get members => [name, age];
}
```

You can customize the behavior with optional parameters:

```dart
// Only check fields, not getters
@GettersInMemberList(memberListName: 'members', getters: false)
class MyClass { ... }

// Only check getters, not fields
@GettersInMemberList(memberListName: 'members', fields: false)
class MyClass { ... }

// Only check members that are subtypes of `int`
@GettersInMemberList(
  memberListName: 'members',
  superTypes: [th<int>()],
)
class MyClass { ... }

// Only check members with specific exact types
@GettersInMemberList(
  memberListName: 'members',
  types: [th<String>(), th<int>()],
)
class MyClass { ... }
```

**Note:** Use the `th<T>()` type alias (short for `TypeHolder`) to specify types in the annotation parameters.

### SubtypeAnnotating

Use this annotation to enforce that all subtypes of a class, mixin, enum, or extension type have specific annotations applied.

```dart
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

@SubtypeAnnotating(annotations: [Deprecated])
abstract class BaseService {
  void execute();
}

// This will trigger a warning - missing @Deprecated annotation
class UserService extends BaseService {
  @override
  void execute() {}
}

// This is correct
@Deprecated('Use NewService instead')
class PaymentService extends BaseService {
  @override
  void execute() {}
}
```

You can require multiple annotations:

```dart
const experimental = 'experimental';

@SubtypeAnnotating(annotations: [Deprecated, experimental])
abstract class ExperimentalApi {}
```

Use the `onlyConcrete` parameter to only enforce the rule on concrete (non-abstract) subtypes:

```dart
@SubtypeAnnotating(
  annotations: [Deprecated],
  onlyConcrete: true,
)
abstract class BaseClass {}

// No warning - abstract class is allowed without the annotation
abstract class IntermediateClass extends BaseClass {}

// Warning - concrete class must have @Deprecated
class ConcreteClass extends BaseClass {}
```

### SubtypeNaming

Use this annotation to enforce naming conventions on all subtypes of a class, mixin, enum, or extension type.

```dart
import 'package:essential_lints_annotations/essential_lints_annotations.dart';

// Require 'I' prefix for all subtypes (interface naming convention)
@SubtypeNaming(prefix: 'I')
abstract class Interface {}

class IUserRepository extends Interface {} // ✓ Correct
class UserRepository extends Interface {}  // ✗ Missing 'I' prefix

// Require 'Service' suffix
@SubtypeNaming(suffix: 'Service')
abstract class BaseService {}

class UserService extends BaseService {}      // ✓ Correct
class PaymentHandler extends BaseService {}   // ✗ Missing 'Service' suffix

// Require name contains 'Repository'
@SubtypeNaming(containing: 'Repository')
abstract class DataAccess {}

class UserRepositoryImpl extends DataAccess {}    // ✓ Correct
class UserDao extends DataAccess {}           // ✗ Doesn't contain 'Repository'

// Combine multiple requirements
@SubtypeNaming(prefix: 'My', suffix: 'Class')
abstract class Base {}

class MyCustomClass extends Base {}           // ✓ Correct
class MyCustom extends Base {}                // ✗ Missing 'Class' suffix
class CustomClass extends Base {}             // ✗ Missing 'My' prefix
```

Use the `onlyConcrete` parameter to only enforce naming on concrete (non-abstract) subtypes:

```dart
@SubtypeNaming(prefix: 'I', onlyConcrete: true)
abstract class Interface {}

abstract class BaseImplementation extends Interface {} // ✓ Allowed
class IUserRepository extends Interface {}             // ✓ Correct
class UserRepository extends Interface {}              // ✗ Missing 'I' prefix
```

## Additional information

### Contributing

Contributions are welcome! Please file issues and pull requests on the [GitHub repository](https://github.com/FMorschel/essential_lints).

### Issues and Support

If you encounter any issues or have questions, please file them in the [issue tracker](https://github.com/FMorschel/essential_lints/issues).

### License

This package is licensed under the MIT License. See the LICENSE file for details.
