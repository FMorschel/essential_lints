part of 'sort_declarations.dart';

/// Represents a member.
/*sealed*/ abstract class _Member extends SortDeclaration {
  const _Member._(this.name) : super._();

  /// The name of the member.
  final Symbol? name;
}

/// Represents a member.
/*sealed*/ abstract class _NonConstructorMember extends _Member {
  const _NonConstructorMember._(this.name) : super._(name);

  @override
  // ignore: overridden_fields type promotion trick
  final Symbol name;
}

/*final*/ class _Constructor extends _Member {
  // ignore: use_super_parameters, annotation trick
  const _Constructor._([this.name]) : super._(name);

  @override
  // ignore: overridden_fields annotation trick
  final Symbol? name;
}

/*final*/ class _Field extends _NonConstructorMember {
  const _Field._(this.name) : super._(name);

  @override
  // ignore: overridden_fields annotation trick
  final Symbol name;
}

/*final*/ class _Getter extends _NonConstructorMember {
  const _Getter._(this.name) : super._(name);

  @override
  // ignore: overridden_fields annotation trick
  final Symbol name;
}

/*final*/ class _Method extends _NonConstructorMember {
  const _Method._(this.name) : super._(name);

  @override
  // ignore: overridden_fields annotation trick
  final Symbol name;
}

/*final*/ class _Setter extends _NonConstructorMember {
  const _Setter._(this.name) : super._(name);

  @override
  // ignore: overridden_fields annotation trick
  final Symbol name;
}
