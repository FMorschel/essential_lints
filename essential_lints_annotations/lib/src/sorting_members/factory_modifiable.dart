part of 'sort_declarations.dart';

/// {@template factory_modifiable}
/// Represents factory modifiable members (constructors).
/// {@endtemplate}
@_gettersInMemberList
sealed class _FactoryModifiable extends _StaticalContext {
  const _FactoryModifiable._() : super._();

  // ignore: unused_element member list
  static List<ExternalMembersModifiable> get _members => [];
}

/// Represents factory external modifiable members.
@_gettersInMemberList
sealed class FactoryExternalModifiable extends _FactoryModifiable {
  /// {@macro named}
  const factory FactoryExternalModifiable.named(NamedModifiable modifiable) =
      _Named._;

  /// {@macro public}
  const factory FactoryExternalModifiable.public(
    PublicConstructorModifiable modifiable,
  ) = _Public._;

  /// {@macro private}
  const factory FactoryExternalModifiable.private(
    PrivateConstructorModifiable modifiable,
  ) = _Private._;

  /// {@macro unnamed}
  const factory FactoryExternalModifiable.unnamed(
    UnnamedModifiable modifiable,
  ) = _Unnamed._;

  /// {@macro constructors}
  static const Constructors constructors = Constructors._constructors;

  // ignore: unused_element member list
  static List<FactoryExternalModifiable> get _members => [constructors];
}

/// Represents factory constructor modifiable members.
@_gettersInMemberList
sealed class FactoryConstructorModifiable extends _FactoryModifiable {
  /// {@macro redirecting}
  const factory FactoryConstructorModifiable.redirecting(
    RedirectingModifiable modifiable,
  ) = _Redirecting._;

  /// {@macro named}
  const factory FactoryConstructorModifiable.named(NamedModifiable modifiable) =
      _Named._;

  /// {@macro public}
  const factory FactoryConstructorModifiable.public(
    PublicConstructorModifiable modifiable,
  ) = _Public._;

  /// {@macro private}
  const factory FactoryConstructorModifiable.private(
    PrivateConstructorModifiable modifiable,
  ) = _Private._;

  /// {@macro unnamed}
  const factory FactoryConstructorModifiable.unnamed(
    UnnamedModifiable modifiable,
  ) = _Unnamed._;

  /// {@macro constructors}
  static const Constructors constructors = Constructors._constructors;

  // ignore: unused_element member list
  static List<FactoryConstructorModifiable> get _members => [constructors];
}

@InvalidMembers({
  th<Fields>(),
  th<Getters>(),
  th<Setters>(),
  th<GettersSetters>(),
  th<FieldsGettersSetters>(),
  th<Methods>(),
})
@InvalidModifiers({
  th<_Factory>(),
})
final class _Factory<M extends _FactoryModifiable> extends Modifier<M>
    implements Constant, ExternalMembersModifiable {
  const _Factory._(super.modifiable) : super._();
}
