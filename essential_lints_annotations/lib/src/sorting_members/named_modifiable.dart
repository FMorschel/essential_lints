part of 'sort_declarations.dart';

/// {@template named_modifiable}
/// Represents named modifiable members (constructors).
/// {@endtemplate}
@_gettersInMemberList
/*sealed*/ abstract class NamedModifiable extends _StaticalContext {
  /// {@macro private}
  const factory NamedModifiable.private(
    PrivateConstructorModifiable modifiable,
  ) = _Private._;

  /// {@macro public}
  const factory NamedModifiable.public(PublicConstructorModifiable modifiable) =
      _Public._;

  /// {@macro constructors}
  static const Constructors constructors = Constructors._constructors;

  // ignore: unused_element member list
  static List<NamedModifiable> get _members => [constructors];
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
  th<_Unnamed>(),
  th<_Named>(),
  th<_Factory>(),
  th<_Const>(),
  th<_External>(),
})
@MutuallyExclusive(#named)
/*final*/ class _Named<M extends NamedModifiable> extends Modifier<M>
    implements
        ExternalMembersModifiable,
        Constant,
        FactoryConstructorModifiable,
        RedirectingModifiable,
        FactoryExternalModifiable {
  const _Named._(super.modifiable) : super._();
}
