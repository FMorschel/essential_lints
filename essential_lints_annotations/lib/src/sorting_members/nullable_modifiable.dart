part of 'sort_declarations.dart';

/// Represents final members.
sealed class NullableModifiable extends Modifiable {
  const NullableModifiable._() : super._();
}

/// Represents nullable fields.
sealed class NullableFieldModifiable extends NullableModifiable
    implements ConstantVariables {
  /// {@macro public}
  const factory NullableFieldModifiable.public(
    PublicFieldModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory NullableFieldModifiable.private(
    PrivateFieldModifiable modifiable,
  ) = Private._;

  /// {@macro initialized}
  const factory NullableFieldModifiable.initialized(
    InitializableStatical modifiable,
  ) = Initialized._;

  /// {@macro fields}
  static const NullableFieldModifiable fields = Fields._fields;
}

/// Represents nullable fields that are also abstractable.
sealed class NullableAbstractableFieldModifiable extends NullableFieldModifiable
    implements Abstractable {
  /// {@macro public}
  const factory NullableAbstractableFieldModifiable.public(
    PublicFieldModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory NullableAbstractableFieldModifiable.private(
    PrivateFieldModifiable modifiable,
  ) = Private._;

  /// {@macro fields}
  static const NullableAbstractableFieldModifiable fields = Fields._fields;
}

/// Represents nullable externable members.
sealed class NullableExternableModifiable extends NullableModifiable {
  /// {@macro public}
  const factory NullableExternableModifiable.public(
    PublicStaticalModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory NullableExternableModifiable.private(
    PrivateStaticalModifiable modifiable,
  ) = Private._;

  /// {@macro fields}
  static const NullableExternableModifiable fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  static const NullableExternableModifiable fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  static const NullableExternableModifiable getters = Getters._getters;

  /// {@macro gettersSetters}
  static const NullableExternableModifiable gettersSetters =
      GettersSetters._gettersSetters;

  /// {@macro methods}
  static const NullableExternableModifiable methods = Methods._methods;

  /// {@macro setters}
  static const NullableExternableModifiable setters = Setters._setters;
}

/// Represents all member that can be nullable.
sealed class NullableMembersModifiable extends NullableModifiable
    implements Statical {
  /// {@macro public}
  const factory NullableMembersModifiable.public(
    PublicStaticalModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory NullableMembersModifiable.private(
    PrivateStaticalModifiable modifiable,
  ) = Private._;

  /// {@macro initialized}
  const factory NullableMembersModifiable.initialized(
    InitializableStatical modifiable,
  ) = Initialized._;

  /// {@macro fields}
  static const NullableMembersModifiable fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  static const NullableMembersModifiable fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  static const NullableMembersModifiable getters = Getters._getters;

  /// {@macro gettersSetters}
  static const NullableMembersModifiable gettersSetters =
      GettersSetters._gettersSetters;

  /// {@macro methods}
  static const NullableMembersModifiable methods = Methods._methods;

  /// {@macro setters}
  static const NullableMembersModifiable setters = Setters._setters;
}

/// Represents nullable operator members.
sealed class NullableOperatorModifiable extends NullableModifiable {
  const NullableOperatorModifiable._() : super._();

  /// {@macro methods}
  static const NullableOperatorModifiable methods = Methods._methods;
}

/// {@template nullable}
/// Represents nullable members.
/// {@endtemplate}
@InvalidMembers([th<Constructors>()])
@InvalidModifiers([
  th<Late>(),
  th<Abstract>(),
  th<External>(),
  th<Overridden>(),
  th<Static>(),
  th<Const>(),
  th<Var>(),
  th<Final>(),
  th<Nullable>(),
])
final class Nullable<M extends NullableModifiable> extends Modifier<M>
    implements
        InitializableStatical,
        FinalModifiable,
        ExternalMembersModifiable,
        ConstantVariables,
        ExternalInstanceModifiable,
        FinalAbstractModifiable,
        StaticalExternal {
  /// {@macro nullable}
  const Nullable._(super.modifiable) : super._();
}
