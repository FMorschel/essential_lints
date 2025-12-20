part of 'sort_declarations.dart';

/// {@template factory_modifiable}
/// Represents factory modifiable members (constructors).
/// {@endtemplate}
@_gettersInMemberList
sealed class FactoryModifiable extends StaticalContext {
  const FactoryModifiable._() : super._();

  // ignore: unused_element member list
  static List<ExternalMembersModifiable> get _members => [];
}

/// Represents factory external modifiable members.
@_gettersInMemberList
sealed class FactoryExternalModifiable extends FactoryModifiable {
  /// {@macro named}
  const factory FactoryExternalModifiable.named(NamedModifiable modifiable) =
      Named._;

  /// {@macro public}
  const factory FactoryExternalModifiable.public(
    PublicConstructorModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory FactoryExternalModifiable.private(
    PrivateConstructorModifiable modifiable,
  ) = Private._;

  /// {@macro unnamed}
  const factory FactoryExternalModifiable.unnamed(
    UnnamedModifiable modifiable,
  ) = Unnamed._;

  /// {@macro constructors}
  static const Constructors constructors = Constructors._constructors;

  // ignore: unused_element member list
  static List<FactoryExternalModifiable> get _members => [constructors];
}

/// Represents factory constructor modifiable members.
@_gettersInMemberList
sealed class FactoryConstructorModifiable extends FactoryModifiable {
  /// {@macro redirecting}
  const factory FactoryConstructorModifiable.redirecting(
    RedirectingModifiable modifiable,
  ) = Redirecting._;

  /// {@macro named}
  const factory FactoryConstructorModifiable.named(NamedModifiable modifiable) =
      Named._;

  /// {@macro public}
  const factory FactoryConstructorModifiable.public(
    PublicConstructorModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory FactoryConstructorModifiable.private(
    PrivateConstructorModifiable modifiable,
  ) = Private._;

  /// {@macro unnamed}
  const factory FactoryConstructorModifiable.unnamed(
    UnnamedModifiable modifiable,
  ) = Unnamed._;

  /// {@macro constructors}
  static const Constructors constructors = Constructors._constructors;

  // ignore: unused_element member list
  static List<FactoryConstructorModifiable> get _members => [constructors];
}

/// {@template factory}
/// Represents factory constructors.
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
  th<Factory>(),
})
final class Factory<M extends FactoryModifiable> extends Modifier<M>
    implements Constant, ExternalMembersModifiable {
  /// {@macro factory}
  const Factory._(super.modifiable) : super._();
}
