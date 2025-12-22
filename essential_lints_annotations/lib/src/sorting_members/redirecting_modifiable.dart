part of 'sort_declarations.dart';

/// {@template redirecting_modifiable}
/// Represents redirecting modifiable members (constructors).
/// {@endtemplate}
@_gettersInMemberList
sealed class RedirectingModifiable extends _StaticalContext {
  /// {@macro private}
  const factory RedirectingModifiable.private(
    PrivateConstructorModifiable modifiable,
  ) = _Private._;

  /// {@macro public}
  const factory RedirectingModifiable.public(
    PublicConstructorModifiable modifiable,
  ) = _Public._;

  /// {@macro named}
  const factory RedirectingModifiable.named(NamedModifiable modifiable) =
      _Named._;

  /// {@macro unnamed}
  const factory RedirectingModifiable.unnamed(UnnamedModifiable modifiable) =
      _Unnamed._;

  /// {@macro constructors}
  static const Constructors constructors = Constructors._constructors;

  // ignore: unused_element member list
  static List<RedirectingModifiable> get _members => [constructors];
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
  th<_External>(),
  th<_Redirecting>(),
  th<_Factory>(),
  th<_Const>(),
})
final class _Redirecting<M extends RedirectingModifiable> extends Modifier<M>
    implements FactoryConstructorModifiable {
  const _Redirecting._(super.modifiable) : super._();
}
