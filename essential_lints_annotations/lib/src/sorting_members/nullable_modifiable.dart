part of 'sort_declarations.dart';

/// Represents final members.
@_gettersInMemberList
sealed class NullableModifiable extends StaticalContext {
  const NullableModifiable._() : super._();

  // ignore: unused_element member list
  static List<NullableModifiable> get _members => const [];
}

/// Represents nullable fields.
@_gettersInMemberList
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
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<ExternalMembersModifiable> get _members => [fields];
}

/// Represents nullable fields that are also abstractable.
@_gettersInMemberList
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
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<NullableAbstractableFieldModifiable> get _members => [fields];
}

/// Represents nullable externable members.
@_gettersInMemberList
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
  static const Fields fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  static const FieldsGettersSetters fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  static const Getters getters = Getters._getters;

  /// {@macro gettersSetters}
  static const GettersSetters gettersSetters = GettersSetters._gettersSetters;

  /// {@macro methods}
  static const Methods methods = Methods._methods;

  /// {@macro setters}
  static const Setters setters = Setters._setters;

  // ignore: unused_element member list
  static List<NullableExternableModifiable> get _members => [
    fields,
    fieldsGettersSetters,
    getters,
    gettersSetters,
    setters,
    methods,
  ];
}

/// Represents all member that can be nullable.
@_gettersInMemberList
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
  static const Fields fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  static const FieldsGettersSetters fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  static const Getters getters = Getters._getters;

  /// {@macro gettersSetters}
  static const GettersSetters gettersSetters = GettersSetters._gettersSetters;

  /// {@macro methods}
  static const Methods methods = Methods._methods;

  /// {@macro setters}
  static const Setters setters = Setters._setters;

  // ignore: unused_element member list
  static List<NullableMembersModifiable> get _members => [
    fields,
    fieldsGettersSetters,
    getters,
    gettersSetters,
    setters,
    methods,
  ];
}

/// Represents nullable operator members.
@_gettersInMemberList
sealed class NullableOperatorModifiable extends NullableModifiable {
  const NullableOperatorModifiable._() : super._();

  /// {@macro methods}
  static const Methods methods = Methods._methods;

  // ignore: unused_element member list
  static List<NullableOperatorModifiable> get _members => [methods];
}

/// {@template nullable}
/// Represents nullable members.
/// {@endtemplate}
@InvalidMembers({th<Constructors>()})
@InvalidModifiers({
  th<Late>(),
  th<Abstract>(),
  th<External>(),
  th<Overridden>(),
  th<Static>(),
  th<Const>(),
  th<Var>(),
  th<Final>(),
  th<Nullable>(),
})
final class Nullable extends Modifier<NullableModifiable>
    implements
        FinalModifiable,
        ExternalMembersModifiable,
        ConstantVariables,
        FinalAbstractModifiable,
        StaticalExternal,
        TypedFieldModifiable,
        TypedAbstractableFieldModifiable,
        TypedExternableModifiable,
        TypedMembersModifiable,
        TypedOperatorModifiable,
        InstanciableMembers,
        OverridableMembers,
        OverridableExternal,
        InstanciableExternal,
        NewExternalModifiable {
  /// {@macro nullable}
  const Nullable._(super.modifiable) : super._();
  const Nullable._operator([
    NullableOperatorModifiable super.modifiable =
        NullableOperatorModifiable.methods,
  ]) : super._();
}
