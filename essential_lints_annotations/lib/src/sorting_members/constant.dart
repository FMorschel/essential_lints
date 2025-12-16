part of 'sort_declarations.dart';

/// Represents constant members.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class Constant extends StaticalContext {
  /// {@macro named}
  @Consider<Named>()
  const factory Constant.named(NamedModifiable modifiable) = Named._;

  /// {@macro unnamed}
  @Consider<Unnamed>()
  const factory Constant.unnamed(UnnamedModifiable modifiable) = Unnamed._;

  /// {@macro public}
  @Consider<Public>()
  const factory Constant.public(PublicConstantModifiable modifiable) = Public._;

  /// {@macro private}
  @Consider<Private>()
  const factory Constant.private(PrivateConstantModifiable modifiable) =
      Private._;

  /// {@macro factory}
  @Consider<Factory>()
  const factory Constant.factory_(FactoryModifiable modifiable) = Factory._;

  /// {@macro initialized}
  @Consider<Initialized>()
  const factory Constant.initialized(InitializableStatical modifiable) =
      Initialized._;

  /// {@macro fields}
  @Consider<Fields>()
  static const ConstantVariables fields = Fields._fields;

  /// {@macro constructors}
  @Consider<Constructors>()
  static const Constant constructors = Constructors._constructors;
}

/// Represents constant fields.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class ConstantVariables extends Constant
    implements
        LateModifiable,
        Statical,
        Abstractable,
        ExternalModifiable,
        Overridable {
  /// {@macro initialized}
  @Consider<Initialized>()
  const factory ConstantVariables.initialized(
    InitializableStatical modifiable,
  ) = Initialized._;

  /// {@macro public}
  @Consider<Public>()
  const factory ConstantVariables.public(PublicFieldModifiable modifiable) =
      Public._;

  /// {@macro private}
  @Consider<Private>()
  const factory ConstantVariables.private(PrivateFieldModifiable modifiable) =
      Private._;

  /// {@macro nullable}
  @Consider<Nullable>()
  const factory ConstantVariables.nullable(
    NullableFieldModifiable modifiable,
  ) = Nullable._;

  /// {@macro fields}
  @Consider<Fields>()
  static const ConstantVariables fields = Fields._fields;
}

/// {@template const}
/// Represents constant members.
/// {@endtemplate}
@InvalidMembers([
  th<Getters>(),
  th<Setters>(),
  th<GettersSetters>(),
  th<FieldsGettersSetters>(),
  th<Methods>(),
])
@InvalidModifiers([
  th<Final>(),
  th<Late>(),
  th<Var>(),
  th<Const>(),
  th<Abstract>(),
  th<External>(),
  th<Overridden>(),
])
final class Const<M extends Constant> extends Modifier<M>
    implements InitializableStatical, ExternalMembersModifiable {
  /// {@macro const}
  const Const._(super.modifiable) : super._();
}
