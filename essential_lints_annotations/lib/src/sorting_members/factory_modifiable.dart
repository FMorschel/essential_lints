part of 'sort_declarations.dart';

/// {@template factory_modifiable}
/// Represents factory modifiable members (constructors).
/// {@endtemplate}
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class FactoryModifiable extends StaticalContext {
  /// {@macro redirecting}
  @Consider<Redirecting>()
  const factory FactoryModifiable.redirecting(
    RedirectingModifiable modifiable,
  ) = Redirecting._;

  /// {@macro named}
  @Consider<Named>()
  const factory FactoryModifiable.named(NamedModifiable modifiable) = Named._;

  /// {@macro public}
  @Consider<Public>()
  const factory FactoryModifiable.public(
    PublicConstructorModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  @Consider<Private>()
  const factory FactoryModifiable.private(
    PrivateConstructorModifiable modifiable,
  ) = Private._;

  /// {@macro unnamed}
  @Consider<Unnamed>()
  const factory FactoryModifiable.unnamed(UnnamedModifiable modifiable) =
      Unnamed._;

  /// {@macro constructors}
  @Consider<Constructors>()
  static const FactoryModifiable constructors = Constructors._constructors;
}

/// {@template factory}
/// Represents factory constructors.
/// {@endtemplate}
@InvalidMembers([
  th<Fields>(),
  th<Getters>(),
  th<Setters>(),
  th<GettersSetters>(),
  th<FieldsGettersSetters>(),
  th<Methods>(),
])
@InvalidModifiers([
  th<Factory>(),
])
final class Factory<M extends FactoryModifiable> extends Modifier<M>
    implements Constant, ExternalMembersModifiable {
  /// {@macro factory}
  const Factory._(super.modifiable) : super._();
}
