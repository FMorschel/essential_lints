part of 'sort_declarations.dart';

/// Class representing typed sort declarations.
final class _TypedModifiable extends _StaticalContext {
  const _TypedModifiable._() : super._();
}

/// Represents typed fields.
@_gettersInMemberList
sealed class TypedFieldModifiable extends _TypedModifiable
    implements ConstantVariables {
  /// {@macro public}
  const factory TypedFieldModifiable.public(
    PublicFieldModifiable modifiable,
  ) = _Public._;

  /// {@macro private}
  const factory TypedFieldModifiable.private(
    PrivateFieldModifiable modifiable,
  ) = _Private._;

  /// {@macro initialized}
  const factory TypedFieldModifiable.initialized(
    InitializableStatical modifiable,
  ) = _Initialized._;

  /// {@macro nullable}
  const factory TypedFieldModifiable.nullable(
    NullableFieldModifiable modifiable,
  ) = _Nullable._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<TypedFieldModifiable> get _members => [fields];
}

/// Represents typed fields that are also abstractable.
@_gettersInMemberList
sealed class TypedAbstractableFieldModifiable extends TypedFieldModifiable
    implements Abstractable {
  /// {@macro public}
  const factory TypedAbstractableFieldModifiable.public(
    PublicFieldModifiable modifiable,
  ) = _Public._;

  /// {@macro private}
  const factory TypedAbstractableFieldModifiable.private(
    PrivateFieldModifiable modifiable,
  ) = _Private._;

  /// {@macro nullable}
  const factory TypedAbstractableFieldModifiable.nullable(
    NullableAbstractableFieldModifiable modifiable,
  ) = _Nullable._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<TypedAbstractableFieldModifiable> get _members => [fields];
}

/// Represents typed externable members.
@_gettersInMemberList
sealed class TypedExternableModifiable extends _TypedModifiable {
  /// {@macro public}
  const factory TypedExternableModifiable.public(
    PublicStaticalModifiable modifiable,
  ) = _Public._;

  /// {@macro private}
  const factory TypedExternableModifiable.private(
    PrivateStaticalModifiable modifiable,
  ) = _Private._;

  /// {@macro nullable}
  const factory TypedExternableModifiable.nullable(
    NullableExternableModifiable modifiable,
  ) = _Nullable._;

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
  static List<TypedExternableModifiable> get _members => [
    fields,
    fieldsGettersSetters,
    getters,
    gettersSetters,
    setters,
    methods,
  ];
}

/// Represents all member that can be typed.
@_gettersInMemberList
sealed class TypedMembersModifiable extends _TypedModifiable
    implements Statical {
  /// {@macro public}
  const factory TypedMembersModifiable.public(
    PublicStaticalModifiable modifiable,
  ) = _Public._;

  /// {@macro private}
  const factory TypedMembersModifiable.private(
    PrivateStaticalModifiable modifiable,
  ) = _Private._;

  /// {@macro initialized}
  const factory TypedMembersModifiable.initialized(
    InitializableStatical modifiable,
  ) = _Initialized._;

  /// {@macro nullable}
  const factory TypedMembersModifiable.nullable(
    NullableMembersModifiable modifiable,
  ) = _Nullable._;

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
  static List<TypedMembersModifiable> get _members => [
    fields,
    fieldsGettersSetters,
    getters,
    gettersSetters,
    setters,
    methods,
  ];
}

/// Represents typed operator members.
@_gettersInMemberList
sealed class TypedOperatorModifiable extends _TypedModifiable {
  /// {@macro nullable}
  const factory TypedOperatorModifiable.nullable([
    NullableOperatorModifiable modifiable,
  ]) = _Nullable._operator;

  /// {@macro methods}
  static const Methods methods = Methods._methods;

  // ignore: unused_element member list
  static List<TypedOperatorModifiable> get _members => [methods];
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
  th<_Typed>(),
})
@MutuallyExclusive(#typeAnnotation)
final class _Typed extends Modifier<_TypedModifiable>
    implements
        FinalModifiable,
        ExternalMembersModifiable,
        ConstantVariables,
        FinalAbstractModifiable,
        StaticalExternal,
        InstantiableMembers,
        OverridableMembers,
        OverridableExternal,
        InstantiableExternal,
        NewExternalModifiable {
  const _Typed._(super.modifiable) : super._();
  const _Typed._operator([
    TypedOperatorModifiable super.modifiable = TypedOperatorModifiable.methods,
  ]) : super._();
}
