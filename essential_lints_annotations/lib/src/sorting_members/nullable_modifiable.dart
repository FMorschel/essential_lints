part of 'sort_declarations.dart';

/// Represents final members.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class NullableModifiable extends StaticalContext {
  const NullableModifiable._() : super._();
}

/// Represents nullable fields.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class NullableFieldModifiable extends NullableModifiable
    implements ConstantVariables {
  /// {@macro public}
  @Consider<Public>()
  const factory NullableFieldModifiable.public(
    PublicFieldModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  @Consider<Private>()
  const factory NullableFieldModifiable.private(
    PrivateFieldModifiable modifiable,
  ) = Private._;

  /// {@macro initialized}
  @Consider<Initialized>()
  const factory NullableFieldModifiable.initialized(
    InitializableStatical modifiable,
  ) = Initialized._;

  /// {@macro fields}
  @Consider<Fields>()
  static const NullableFieldModifiable fields = Fields._fields;
}

/// Represents nullable fields that are also abstractable.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class NullableAbstractableFieldModifiable extends NullableFieldModifiable
    implements Abstractable {
  /// {@macro public}
  @Consider<Public>()
  const factory NullableAbstractableFieldModifiable.public(
    PublicFieldModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  @Consider<Private>()
  const factory NullableAbstractableFieldModifiable.private(
    PrivateFieldModifiable modifiable,
  ) = Private._;

  /// {@macro fields}
  @Consider<Fields>()
  static const NullableAbstractableFieldModifiable fields = Fields._fields;
}

/// Represents nullable externable members.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class NullableExternableModifiable extends NullableModifiable {
  /// {@macro public}
  @Consider<Public>()
  const factory NullableExternableModifiable.public(
    PublicStaticalModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  @Consider<Private>()
  const factory NullableExternableModifiable.private(
    PrivateStaticalModifiable modifiable,
  ) = Private._;

  /// {@macro fields}
  @Consider<Fields>()
  static const NullableExternableModifiable fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  @Consider<FieldsGettersSetters>()
  static const NullableExternableModifiable fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  @Consider<Getters>()
  static const NullableExternableModifiable getters = Getters._getters;

  /// {@macro gettersSetters}
  @Consider<GettersSetters>()
  static const NullableExternableModifiable gettersSetters =
      GettersSetters._gettersSetters;

  /// {@macro methods}
  @Consider<Methods>()
  static const NullableExternableModifiable methods = Methods._methods;

  /// {@macro setters}
  @Consider<Setters>()
  static const NullableExternableModifiable setters = Setters._setters;
}

/// Represents all member that can be nullable.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class NullableMembersModifiable extends NullableModifiable
    implements Statical {
  /// {@macro public}
  @Consider<Public>()
  const factory NullableMembersModifiable.public(
    PublicStaticalModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  @Consider<Private>()
  const factory NullableMembersModifiable.private(
    PrivateStaticalModifiable modifiable,
  ) = Private._;

  /// {@macro initialized}
  @Consider<Initialized>()
  const factory NullableMembersModifiable.initialized(
    InitializableStatical modifiable,
  ) = Initialized._;

  /// {@macro fields}
  @Consider<Fields>()
  static const NullableMembersModifiable fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  @Consider<FieldsGettersSetters>()
  static const NullableMembersModifiable fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  @Consider<Getters>()
  static const NullableMembersModifiable getters = Getters._getters;

  /// {@macro gettersSetters}
  @Consider<GettersSetters>()
  static const NullableMembersModifiable gettersSetters =
      GettersSetters._gettersSetters;

  /// {@macro methods}
  @Consider<Methods>()
  static const NullableMembersModifiable methods = Methods._methods;

  /// {@macro setters}
  @Consider<Setters>()
  static const NullableMembersModifiable setters = Setters._setters;
}

/// Represents nullable operator members.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class NullableOperatorModifiable extends NullableModifiable {
  const NullableOperatorModifiable._() : super._();

  /// {@macro methods}
  @Consider<Methods>()
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
final class Nullable extends Modifier<NullableModifiable>
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
  const Nullable._operator([
    NullableOperatorModifiable super.modifiable =
        NullableOperatorModifiable.methods,
  ]) : super._();
}
