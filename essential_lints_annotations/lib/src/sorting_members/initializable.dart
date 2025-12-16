part of 'sort_declarations.dart';

/// Groups initializable members.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class Initializable extends StaticalContext {
  const Initializable._() : super._();
}

/// Groups initializable overridable members.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class InitializableOverridable extends Initializable
    implements Overridable {
  /// {@macro var}
  @Consider<Var>()
  const factory InitializableOverridable.var_(Variable modifiable) = Var._;

  /// {@macro final}
  @Consider<Final>()
  const factory InitializableOverridable.final_(FinalModifiable modifiable) =
      Final._;

  /// {@macro private}
  @Consider<Private>()
  const factory InitializableOverridable.private(
    PrivateFieldModifiable modifiable,
  ) = Private._;

  /// {@macro public}
  @Consider<Public>()
  const factory InitializableOverridable.public(
    PublicFieldModifiable modifiable,
  ) = Public._;

  /// {@macro fields}
  @Consider<Fields>()
  static const InitializableOverridable fields = Fields._fields;
}

/// Groups initializable static members.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class InitializableStatical extends Initializable implements Statical {
  /// {@macro public}
  @Consider<Public>()
  const factory InitializableStatical.public(PublicFieldModifiable modifiable) =
      Public._;

  /// {@macro private}
  @Consider<Private>()
  const factory InitializableStatical.private(
    PrivateFieldModifiable modifiable,
  ) = Private._;

  /// {@macro nullable}
  @Consider<Nullable>()
  const factory InitializableStatical.nullable(
    NullableFieldModifiable modifiable,
  ) = Nullable._;

  /// {@macro fields}
  @Consider<Fields>()
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
final class Initialized<M extends Initializable> extends Modifier<M>
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
