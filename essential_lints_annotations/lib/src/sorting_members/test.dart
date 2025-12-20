part of 'sort_declarations.dart';

/// {@template wrapper}
/// Represents a wrapper modifier that can contain other modifiers.
/// This is used to test nested modifier detection.
/// This wrapper does NOT restrict Test, to demonstrate the nesting issue.
/// {@endtemplate}
@visibleForTesting
@InvalidMembers({})
@InvalidModifiers({th<TestWrapper>()})
@Deprecated('Only used for testing')
final class TestWrapper extends Modifier<Testable> implements Testable {
  @Deprecated('Only used for testing')
  /// {@macro wrapper}
  const TestWrapper._(super.modifiable) : super._();
}

/// Testable modifiable member.
@visibleForTesting
@_gettersInMemberList
@Deprecated('Only used for testing')
sealed class Testable extends StaticalContext {
  /// {@macro test}
  @Deprecated('Only used for testing')
  const factory Testable.test(Testable modifiable) = Test._;

  /// {@macro wrapper}
  @Deprecated('Only used for testing')
  const factory Testable.wrapper(Testable modifiable) = TestWrapper._;

  /// {@macro tests}
  @Deprecated('Only used for testing')
  static const Tests tests = Tests._tests;

  @Deprecated('Only used for testing')
  // ignore: unused_element member list
  static List<Testable> get _members => [tests];
}

/// {@template tests}
/// Represents all test members.
/// {@endtemplate}
@visibleForTesting
@Deprecated('Only used for testing')
final class Tests extends Group implements Testable {
  @Deprecated('Only used for testing')
  /// {@macro tests}
  const Tests._() : super._();

  /// {@macro tests}
  static const Tests _tests = Tests._();
}

/// {@template test}
/// Represents a test modifier.
/// {@endtemplate}
@visibleForTesting
@InvalidMembers({th<Tests>()})
@InvalidModifiers({th<Test>()})
@Deprecated('Only used for testing')
final class Test extends Modifier<Testable> implements Testable {
  @Deprecated('Only used for testing')
  /// {@macro test}
  const Test._(super.modifiable) : super._();
}
