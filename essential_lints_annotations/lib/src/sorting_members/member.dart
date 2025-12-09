part of 'sort_declarations.dart';

/// A helper typedef for generating members.
typedef MemberGenerator = SortDeclarationGenerator<Symbol, Member>;

/// Represents a member.
sealed class Member extends SortDeclaration {
  const Member(this.name);

  /// The name of the member.
  final Symbol name;
}

/// {@template constructor}
/// Represents a constructor
/// {@endtemplate}
final class Constructor extends Member {
  /// {@macro constructor}
  const Constructor(super.name);

  /// {@macro constructor}
  static const MemberGenerator constructor = Constructor.new;
}

/// {@template field}
/// Represents a field.
/// {@endtemplate}
final class Field extends Member {
  /// {@macro field}
  const Field(super.name);

  /// {@macro field}
  static const MemberGenerator field = Field.new;
}

/// {@template getter}
/// Represents a getter.
/// {@endtemplate}
final class Getter extends Member {
  /// {@macro getter}
  const Getter(super.name);

  /// {@macro getter}
  static const MemberGenerator getter = Getter.new;
}

/// {@template method}
/// Represents a method.
/// {@endtemplate}
final class Method extends Member {
  /// {@macro method}
  const Method(super.name);

  /// {@macro method}
  static const MemberGenerator method = Method.new;
}

/// {@template setter}
/// Represents a setter.
/// {@endtemplate}
final class Setter extends Member {
  /// {@macro setter}
  const Setter(super.name);

  /// {@macro setter}
  static const MemberGenerator setter = Setter.new;
}
