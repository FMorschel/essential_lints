part of 'sort_declarations.dart';

/// Represents a member.
sealed class Member extends SortDeclaration {
  const Member._(this.name) : super._();

  /// The name of the member.
  final Symbol? name;
}

/// Represents a member.
sealed class NonConstructorMember extends Member {
  const NonConstructorMember._(this.name) : super._(name);

  /// The name of the member.
  @override
  // ignore: overridden_fields type promotion trick
  final Symbol name;
}

/// {@template constructor}
/// Represents a constructor
/// {@endtemplate}
final class Constructor extends Member {
  /// {@macro constructor}
  const Constructor._([super.name]) : super._();
}

/// {@template field}
/// Represents a field.
/// {@endtemplate}
final class Field extends NonConstructorMember {
  /// {@macro field}
  const Field._(super.name) : super._();
}

/// {@template getter}
/// Represents a getter.
/// {@endtemplate}
final class Getter extends NonConstructorMember {
  /// {@macro getter}
  const Getter._(super.name) : super._();
}

/// {@template method}
/// Represents a method.
/// {@endtemplate}
final class Method extends NonConstructorMember {
  /// {@macro method}
  const Method._(super.name) : super._();
}

/// {@template setter}
/// Represents a setter.
/// {@endtemplate}
final class Setter extends NonConstructorMember {
  /// {@macro setter}
  const Setter._(super.name) : super._();
}
