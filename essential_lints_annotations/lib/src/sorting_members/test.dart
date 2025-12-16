part of 'sort_declarations.dart';

/// Testable modifiable member.
@AnnotateMembersWith(Consider, onlyPublic: true)
@visibleForTesting
sealed class Testable extends StaticalContext {
  /// {@macro test}

  // ignore: _internal_plugin/annotate_members_with just a test
  const factory Testable.test(Testable modifiable) = Test._;

  /// {@macro test}
  @Consider<Test>()
  const factory Testable.test2(Testable modifiable) = Test._;

  /// {@macro tests}

  // ignore: _internal_plugin/annotate_members_with just a test
  static const Testable tests = Tests._tests;

  /// {@macro tests}
  @Consider<Tests>()
  static const Testable tests2 = Tests._tests;
}

/// {@template tests}
/// Represents all test members.
/// {@endtemplate}
@visibleForTesting
final class Tests extends Group implements Testable {
  /// {@macro tests}
  const Tests._() : super._();

  /// {@macro tests}
  static const Tests _tests = Tests._();
}

/// {@template test}
/// Represents a test modifier.
/// {@endtemplate}
@visibleForTesting
@InvalidMembers([th<Tests>()])
@InvalidModifiers([th<Test>()])
final class Test extends Modifier<Testable> implements Testable {
  /// {@macro test}
  const Test._(super.modifiable) : super._();
}
