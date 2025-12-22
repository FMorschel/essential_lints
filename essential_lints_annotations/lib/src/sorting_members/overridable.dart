part of 'sort_declarations.dart';

/*final*/ class _Overridable extends _StaticalContext {
  const _Overridable._() : super._();
}

/// {@template overridable}
/// Represents overridable members.
/// {@endtemplate}
@_gettersInMemberList
/*sealed*/ abstract class OverridableMembers extends _Overridable {
  /// {@macro public}
  const factory OverridableMembers.public(PublicStaticalModifiable modifiable) =
      _Public._;

  /// {@macro private}
  const factory OverridableMembers.private(
    PrivateStaticalModifiable modifiable,
  ) = _Private._;

  /// {@macro nullable}
  const factory OverridableMembers.nullable(
    NullableMembersModifiable modifiable,
  ) = _Nullable._;

  /// {@macro typed}
  const factory OverridableMembers.typed(TypedMembersModifiable modifiable) =
      _Typed._;

  /// {@macro dynamic}
  const factory OverridableMembers.dynamic(
    DynamicMembersModifiable modifiable,
  ) = _Dynamic._;

  /// {@macro abstract}
  const factory OverridableMembers.abstract(Abstractable modifiable) =
      _Abstract._;

  /// {@macro operator}
  const factory OverridableMembers.operator([OperatorModifiable modifiable]) =
      _Operator._;

  /// {@macro initialized}
  const factory OverridableMembers.initialized(
    InitializableOverridable modifiable,
  ) = _Initialized._;

  /// {@macro late_modifiable}
  const factory OverridableMembers.late(LateModifiable modifiable) = _Late._;

  /// {@macro var}
  const factory OverridableMembers.var_(Variable modifiable) = _Var._;

  /// {@macro final}
  const factory OverridableMembers.final_(FinalModifiable modifiable) =
      _Final._;

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
  static List<OverridableMembers> get _members => [
        fields,
        fieldsGettersSetters,
        getters,
        gettersSetters,
        setters,
        methods,
      ];
}

/// {@macro overridable}
@_gettersInMemberList
/*sealed*/ abstract class OverridableExternal extends _Overridable {
  /// {@macro public}
  const factory OverridableExternal.public(
    PublicStaticalModifiable modifiable,
  ) = _Public._;

  /// {@macro private}
  const factory OverridableExternal.private(
    PrivateStaticalModifiable modifiable,
  ) = _Private._;

  /// {@macro nullable}
  const factory OverridableExternal.nullable(
    NullableExternableModifiable modifiable,
  ) = _Nullable._;

  /// {@macro typed}
  const factory OverridableExternal.typed(
    TypedExternableModifiable modifiable,
  ) = _Typed._;

  /// {@macro dynamic}
  const factory OverridableExternal.dynamic(
    DynamicExternableModifiable modifiable,
  ) = _Dynamic._;

  /// {@macro operator}
  const factory OverridableExternal.operator([OperatorModifiable modifiable]) =
      _Operator._;

  /// {@macro var}
  const factory OverridableExternal.var_(VariableAbstractable modifiable) =
      _Var._;

  /// {@macro final}
  const factory OverridableExternal.final_(FinalAbstractModifiable modifiable) =
      _Final._;

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
  static List<OverridableExternal> get _members => [
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
  th<_Overridden>(),
  th<_New>(),
  th<_External>(),
})
@MutuallyExclusive(#overriding)
/*final*/ class _Overridden<M extends _Overridable> extends Modifier<M>
    implements
        InstantiableMembers,
        ExternalMembersModifiable,
        InstantiableExternal {
  const _Overridden._(super.modifiable) : super._();
}
