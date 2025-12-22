part of 'sort_declarations.dart';

/// Class representing instance sort declarations.
@_gettersInMemberList
sealed class _Instantiable extends _StaticalContext {
  const _Instantiable._() : super._();

  // ignore: unused_element member list
  static List<_Instantiable> get _members => const [];
}

/// Represents instance members.
@_gettersInMemberList
sealed class InstantiableMembers extends _Instantiable {
  /// {@macro public}
  const factory InstantiableMembers.public(
    PublicStaticalModifiable modifiable,
  ) = _Public._;

  /// {@macro private}
  const factory InstantiableMembers.private(
    PrivateStaticalModifiable modifiable,
  ) = _Private._;

  /// {@macro nullable}
  const factory InstantiableMembers.nullable(
    NullableMembersModifiable modifiable,
  ) = _Nullable._;

  /// {@macro typed}
  const factory InstantiableMembers.typed(TypedMembersModifiable modifiable) =
      _Typed._;

  /// {@macro dynamic}
  const factory InstantiableMembers.dynamic(
    DynamicMembersModifiable modifiable,
  ) = _Dynamic._;

  /// {@macro abstract}
  const factory InstantiableMembers.abstract(Abstractable modifiable) =
      _Abstract._;

  /// {@macro operator}
  const factory InstantiableMembers.operator([OperatorModifiable modifiable]) =
      _Operator._;

  /// {@macro initialized}
  const factory InstantiableMembers.initialized(
    InitializableOverridable modifiable,
  ) = _Initialized._;

  /// {@macro late_modifiable}
  const factory InstantiableMembers.late(LateModifiable modifiable) = _Late._;

  /// {@macro var}
  const factory InstantiableMembers.var_(Variable modifiable) = _Var._;

  /// {@macro final}
  const factory InstantiableMembers.final_(FinalModifiable modifiable) =
      _Final._;

  /// {@macro overridden}
  const factory InstantiableMembers.overridden(OverridableMembers modifiable) =
      _Overridden._;

  /// {@macro new}
  const factory InstantiableMembers.new_(NewMemberModifiable modifiable) =
      _New._;

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
  static List<InstantiableMembers> get _members => [
    fields,
    fieldsGettersSetters,
    getters,
    gettersSetters,
    setters,
    methods,
  ];
}

/// Class representing instance sort declarations.
@_gettersInMemberList
sealed class InstantiableExternal extends _Instantiable {
  /// {@macro public}
  const factory InstantiableExternal.public(
    PublicStaticalModifiable modifiable,
  ) = _Public._;

  /// {@macro private}
  const factory InstantiableExternal.private(
    PrivateStaticalModifiable modifiable,
  ) = _Private._;

  /// {@macro nullable}
  const factory InstantiableExternal.nullable(
    NullableExternableModifiable modifiable,
  ) = _Nullable._;

  /// {@macro typed}
  const factory InstantiableExternal.typed(
    TypedExternableModifiable modifiable,
  ) = _Typed._;

  /// {@macro dynamic}
  const factory InstantiableExternal.dynamic(
    DynamicExternableModifiable modifiable,
  ) = _Dynamic._;

  /// {@macro operator}
  const factory InstantiableExternal.operator([OperatorModifiable modifiable]) =
      _Operator._;

  /// {@macro var}
  const factory InstantiableExternal.var_(VariableAbstractable modifiable) =
      _Var._;

  /// {@macro final}
  const factory InstantiableExternal.final_(
    FinalAbstractModifiable modifiable,
  ) = _Final._;

  /// {@macro overridden}
  const factory InstantiableExternal.overridden(
    OverridableExternal modifiable,
  ) = _Overridden._;

  /// {@macro new}
  const factory InstantiableExternal.new_(NewExternalModifiable modifiable) =
      _New._;

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
  static List<InstantiableExternal> get _members => [
    fields,
    fieldsGettersSetters,
    getters,
    gettersSetters,
    setters,
    methods,
  ];
}

@InvalidMembers({th<Constructors>()})
@InvalidModifiers({
  th<_Static>(),
  th<_Instance>(),
  th<_External>(),
})
@MutuallyExclusive(#context)
final class _Instance extends Modifier<_Instantiable>
    implements ExternalMembersModifiable {
  const _Instance._(super.modifiable) : super._();
}
