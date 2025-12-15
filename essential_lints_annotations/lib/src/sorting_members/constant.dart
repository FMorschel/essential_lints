part of 'sort_declarations.dart';

/// Represents constant members.
sealed class Constant extends Modifiable {
  /// {@macro named}
  const factory Constant.named(NamedModifiable modifiable) = Named._;

  /// {@macro unnamed}
  const factory Constant.unnamed(UnnamedModifiable modifiable) = Unnamed._;

  /// {@macro public}
  const factory Constant.public(PublicConstantModifiable modifiable) = Public._;

  /// {@macro private}
  const factory Constant.private(PrivateConstantModifiable modifiable) =
      Private._;

  /// {@macro factory}
  const factory Constant.factory_(FactoryModifiable modifiable) = Factory._;

  /// {@macro initialized}
  const factory Constant.initialized(InitializableStatical modifiable) =
      Initialized._;

  /// {@macro fields}
  static const ConstantVariables fields = Fields._fields;

  /// {@macro constructors}
  static const Constant constructors = Constructors._constructors;
}

/// Represents constant fields.
sealed class ConstantVariables extends Constant
    implements
        LateModifiable,
        Statical,
        Abstractable,
        ExternalModifiable,
        Overridable {
  /// {@macro initialized}
  const factory ConstantVariables.initialized(
    InitializableStatical modifiable,
  ) = Initialized._;

  /// {@macro public}
  const factory ConstantVariables.public(PublicFieldModifiable modifiable) =
      Public._;

  /// {@macro private}
  const factory ConstantVariables.private(PrivateFieldModifiable modifiable) =
      Private._;

  /// {@macro nullable}
  const factory ConstantVariables.nullable(
    NullableFieldModifiable modifiable,
  ) = Nullable._;

  /// {@macro fields}
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
