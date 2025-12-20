part of 'sort_declarations.dart';

/// {@template named_modifiable}
/// Represents named modifiable members (constructors).
/// {@endtemplate}
@_gettersInMemberList
sealed class NamedModifiable extends StaticalContext {
  /// {@macro private}
  const factory NamedModifiable.private(
    PrivateConstructorModifiable modifiable,
  ) = Private._;

  /// {@macro public}
  const factory NamedModifiable.public(PublicConstructorModifiable modifiable) =
      Public._;

  /// {@macro constructors}
  static const Constructors constructors = Constructors._constructors;

  // ignore: unused_element member list
  static List<NamedModifiable> get _members => [constructors];
}

/// {@template named}
/// Represents named constructors.
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
  th<Unnamed>(),
  th<Named>(),
  th<Factory>(),
  th<Const>(),
  th<External>(),
})
@MutuallyExclusive(#named)
final class Named<M extends NamedModifiable> extends Modifier<M>
    implements
        ExternalMembersModifiable,
        Constant,
        FactoryConstructorModifiable,
        RedirectingModifiable,
        FactoryExternalModifiable {
  /// {@macro named}
  const Named._(super.modifiable) : super._();
}
