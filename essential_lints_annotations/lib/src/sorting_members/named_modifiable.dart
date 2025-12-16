part of 'sort_declarations.dart';

/// {@template named_modifiable}
/// Represents named modifiable members (constructors).
/// {@endtemplate}
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class NamedModifiable extends StaticalContext {
  /// {@macro private}
  @Consider<Private>()
  const factory NamedModifiable.private(
    PrivateConstructorModifiable modifiable,
  ) = Private._;

  /// {@macro public}
  @Consider<Public>()
  const factory NamedModifiable.public(PublicConstructorModifiable modifiable) =
      Public._;

  /// {@macro constructors}
  @Consider<Constructors>()
  static const NamedModifiable constructors = Constructors._constructors;
}

/// {@template named}
/// Represents named constructors.
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
  th<Unnamed>(),
  th<Named>(),
  th<Factory>(),
  th<Const>(),
  th<External>(),
])
final class Named<M extends NamedModifiable> extends Modifier<M>
    implements
        ExternalMembersModifiable,
        Constant,
        FactoryModifiable,
        RedirectingModifiable {
  /// {@macro named}
  const Named._(super.modifiable) : super._();
}
