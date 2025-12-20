part of 'sort_declarations.dart';

/// Represents unnamed members.
@_gettersInMemberList
sealed class UnnamedModifiable extends StaticalContext {
  const UnnamedModifiable._() : super._();

  /// {@macro constructors}
  static const Constructors constructors = Constructors._constructors;

  // ignore: unused_element member list
  static List<UnnamedModifiable> get _members => [constructors];
}

/// {@template unnamed}
/// Represents unnamed members.
/// {@endtemplate}
@InvalidMembers({
  th<Fields>(),
  th<Getters>(),
  th<Setters>(),
  th<GettersSetters>(),
  th<FieldsGettersSetters>(),
  th<Methods>(),
})
@InvalidModifiers({
  th<Private>(),
  th<Public>(),
  th<Named>(),
  th<Unnamed>(),
  th<Factory>(),
  th<Const>(),
  th<External>(),
})
@MutuallyExclusive(#named)
final class Unnamed<M extends UnnamedModifiable> extends Modifier<M>
    implements
        RedirectingModifiable,
        FactoryConstructorModifiable,
        ExternalMembersModifiable,
        Constant,
        FactoryExternalModifiable {
  /// {@macro unnamed}
  const Unnamed._(super.modifiable) : super._();
}
