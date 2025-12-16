part of 'sort_declarations.dart';

/// {@template redirecting_modifiable}
/// Represents redirecting modifiable members (constructors).
/// {@endtemplate}
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class RedirectingModifiable extends StaticalContext {
  /// {@macro private}
  @Consider<Private>()
  const factory RedirectingModifiable.private(
    PrivateConstructorModifiable modifiable,
  ) = Private._;

  /// {@macro public}
  @Consider<Public>()
  const factory RedirectingModifiable.public(
    PublicConstructorModifiable modifiable,
  ) = Public._;

  /// {@macro named}
  @Consider<Named>()
  const factory RedirectingModifiable.named(NamedModifiable modifiable) =
      Named._;

  /// {@macro unnamed}
  @Consider<Unnamed>()
  const factory RedirectingModifiable.unnamed(UnnamedModifiable modifiable) =
      Unnamed._;

  /// {@macro constructors}
  @Consider<Constructors>()
  static const RedirectingModifiable constructors = Constructors._constructors;
}

/// {@template redirecting}
/// Represents redirecting constructors.
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
  th<External>(),
  th<Redirecting>(),
  th<Factory>(),
  th<Const>(),
])
final class Redirecting<M extends RedirectingModifiable> extends Modifier<M>
    implements FactoryModifiable, NamedModifiable {
  /// {@macro redirecting}
  const Redirecting._(super.modifiable) : super._();
}
