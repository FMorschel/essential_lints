part of 'sort_declarations.dart';

/// Represents final members.
sealed class FinalModifiable extends Modifiable
    implements LateModifiable, Statical, ExternalModifiable, Overridable {
  /// {@macro initialized}
  const factory FinalModifiable.initialized(
    InitializableStatical modifiable,
  ) = Initialized._;

  /// {@macro public}
  const factory FinalModifiable.public(
    PublicFieldModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory FinalModifiable.private(
    PrivateFieldModifiable modifiable,
  ) = Private._;

  /// {@macro nullable}
  const factory FinalModifiable.nullable(
    NullableFieldModifiable modifiable,
  ) = Nullable._;

  /// {@macro fields}
  static const FinalModifiable fields = Fields._fields;
}

/// Represents final members that are also abstractable.
sealed class FinalAbstractModifiable extends FinalModifiable
    implements Abstractable {
  /// {@macro public}
  const factory FinalAbstractModifiable.public(
    PublicFieldModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory FinalAbstractModifiable.private(
    PrivateFieldModifiable modifiable,
  ) = Private._;

  /// {@macro nullable}
  const factory FinalAbstractModifiable.nullable(
    NullableAbstractableFieldModifiable modifiable,
  ) = Nullable._;

  /// {@macro fields}
  static const FinalAbstractModifiable fields = Fields._fields;
}

/// {@template final}
/// Represents final members.
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
  th<Const>(),
  th<Var>(),
  th<Final>(),
  th<Late>(),
  th<Abstract>(),
  th<External>(),
  th<Overridden>(),
  th<Static>(),
])
final class Final<M extends FinalModifiable> extends Modifier<M>
    implements
        ExternalInstanceModifiable,
        ExternalMembersModifiable,
        Abstractable,
        InitializableOverridable,
        InitializableStatical,
        LateModifiable,
        StaticalExternal {
  /// {@macro final}
  const Final._(super.modifiable) : super._();
}
