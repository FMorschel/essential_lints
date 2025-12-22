part of 'sort_declarations.dart';

/// Represents unnamed members.
@_gettersInMemberList
sealed class UnnamedModifiable extends _StaticalContext {
  const UnnamedModifiable._() : super._();

  /// {@macro constructors}
  static const Constructors constructors = Constructors._constructors;

  // ignore: unused_element member list
  static List<UnnamedModifiable> get _members => [constructors];
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
  th<_Private>(),
  th<_Public>(),
  th<_Named>(),
  th<_Unnamed>(),
  th<_Factory>(),
  th<_Const>(),
  th<_External>(),
})
@MutuallyExclusive(#named)
final class _Unnamed<M extends UnnamedModifiable> extends Modifier<M>
    implements
        RedirectingModifiable,
        FactoryConstructorModifiable,
        ExternalMembersModifiable,
        Constant,
        FactoryExternalModifiable {
  const _Unnamed._(super.modifiable) : super._();
}
