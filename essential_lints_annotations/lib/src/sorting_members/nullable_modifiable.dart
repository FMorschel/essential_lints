part of 'sort_declarations.dart';

/// Represents nullable members.
/*final*/ class _NullableModifiable extends _StaticalContext {
  const _NullableModifiable._() : super._();
}

/// Represents nullable fields.
@_gettersInMemberList
/*sealed*/ abstract class NullableFieldModifiable extends _NullableModifiable
    implements ConstantVariables {
  /// {@macro public}
  const factory NullableFieldModifiable.public(
    PublicFieldModifiable modifiable,
  ) = _Public._;

  /// {@macro private}
  const factory NullableFieldModifiable.private(
    PrivateFieldModifiable modifiable,
  ) = _Private._;

  /// {@macro initialized}
  const factory NullableFieldModifiable.initialized(
    InitializableStatical modifiable,
  ) = _Initialized._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<ExternalMembersModifiable> get _members => [fields];
}

/// Represents nullable fields that are also abstractable.
@_gettersInMemberList
/*sealed*/ abstract class NullableAbstractableFieldModifiable
    extends NullableFieldModifiable implements Abstractable {
  /// {@macro public}
  const factory NullableAbstractableFieldModifiable.public(
    PublicFieldModifiable modifiable,
  ) = _Public._;

  /// {@macro private}
  const factory NullableAbstractableFieldModifiable.private(
    PrivateFieldModifiable modifiable,
  ) = _Private._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<NullableAbstractableFieldModifiable> get _members => [fields];
}

/// Represents nullable externable members.
@_gettersInMemberList
/*sealed*/ abstract class NullableExternableModifiable
    extends _NullableModifiable {
  /// {@macro public}
  const factory NullableExternableModifiable.public(
    PublicStaticalModifiable modifiable,
  ) = _Public._;

  /// {@macro private}
  const factory NullableExternableModifiable.private(
    PrivateStaticalModifiable modifiable,
  ) = _Private._;

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
/*sealed*/ abstract class NullableMembersModifiable extends _NullableModifiable
    implements Statical {
  /// {@macro public}
  const factory NullableMembersModifiable.public(
    PublicStaticalModifiable modifiable,
  ) = _Public._;

  /// {@macro private}
  const factory NullableMembersModifiable.private(
    PrivateStaticalModifiable modifiable,
  ) = _Private._;

  /// {@macro initialized}
  const factory NullableMembersModifiable.initialized(
    InitializableStatical modifiable,
  ) = _Initialized._;

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
/*sealed*/ abstract class NullableOperatorModifiable
    extends _NullableModifiable {
  const NullableOperatorModifiable._() : super._();

  /// {@macro methods}
  static const Methods methods = Methods._methods;

  // ignore: unused_element member list
  static List<NullableOperatorModifiable> get _members => [methods];
}

@InvalidMembers({th<Constructors>()})
@InvalidModifiers({
  th<_Late>(),
  th<_Abstract>(),
  th<_External>(),
  th<_Overridden>(),
  th<_Static>(),
  th<_Const>(),
  th<_Var>(),
  th<_Final>(),
  th<_Nullable>(),
})
/*final*/ class _Nullable extends Modifier<_NullableModifiable>
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
        InstantiableMembers,
        OverridableMembers,
        OverridableExternal,
        InstantiableExternal,
        NewExternalModifiable {
  const _Nullable._(super.modifiable) : super._();
  const _Nullable._operator([
    NullableOperatorModifiable super.modifiable =
        NullableOperatorModifiable.methods,
  ]) : super._();
}
