part of 'sort_declarations.dart';

/// Groups initializable members.
sealed class Initializable extends Modifiable {
  const Initializable._() : super._();
}

/// Groups initializable overridable members.
sealed class InitializableOverridable extends Initializable
    implements Overridable {
  /// {@macro var}
  const factory InitializableOverridable.var_(Variable modifiable) = Var._;

  /// {@macro final}
  const factory InitializableOverridable.final_(FinalModifiable modifiable) =
      Final._;

  /// {@macro private}
  const factory InitializableOverridable.private(
    PrivateFieldModifiable modifiable,
  ) = Private._;

  /// {@macro public}
  const factory InitializableOverridable.public(
    PublicFieldModifiable modifiable,
  ) = Public._;

  /// {@macro fields}
  static const InitializableOverridable fields = Fields._fields;
}

/// Groups initializable static members.
sealed class InitializableStatical extends Initializable implements Statical {
  /// {@macro public}
  const factory InitializableStatical.public(PublicFieldModifiable modifiable) =
      Public._;

  /// {@macro private}
  const factory InitializableStatical.private(
    PrivateFieldModifiable modifiable,
  ) = Private._;

  /// {@macro nullable}
  const factory InitializableStatical.nullable(
    NullableFieldModifiable modifiable,
  ) = Nullable._;

  /// {@macro fields}
  static const InitializableStatical fields = Fields._fields;
}

/// {@template initialized}
/// Represents initialized members.
/// {@endtemplate}
@InvalidMembers([
  th<Constructors>(),
  th<Getters>(),
  th<Setters>(),
  th<GettersSetters>(),
  th<FieldsGettersSetters>(),
  th<Methods>(),
])
@InvalidModifiers([
  th<Abstract>(),
  th<External>(),
  th<Initialized>(),
  th<Late>(),
  th<Overridden>(),
  th<Static>(),
])
class Initialized<M extends Initializable> extends Modifier<M>
    implements
        Statical,
        Overridable,
        NullableMembersModifiable,
        FinalModifiable,
        Variable,
        ConstantVariables,
        NullableFieldModifiable,
        PrivateModifiable,
        PrivateFieldModifiable,
        PrivateStaticalModifiable {
  /// {@macro initialized}
  const Initialized._(super.modifiable) : super._();
}
