part of 'sort_declarations.dart';

/// Represents a member.
sealed class _Member extends SortDeclaration {
  const _Member._(this.name) : super._();

  /// The name of the member.
  final Symbol? name;
}

/// Represents a member.
sealed class _NonConstructorMember extends _Member {
  const _NonConstructorMember._(this.name) : super._(name);

  /// The name of the member.
  @override
  // ignore: overridden_fields type promotion trick
  final Symbol name;
}

final class _Constructor extends _Member {
  const _Constructor._([super.name]) : super._();
}

final class _Field extends _NonConstructorMember {
  const _Field._(super.name) : super._();
}

final class _Getter extends _NonConstructorMember {
  const _Getter._(super.name) : super._();
}

final class _Method extends _NonConstructorMember {
  const _Method._(super.name) : super._();
}

final class _Setter extends _NonConstructorMember {
  const _Setter._(super.name) : super._();
}
