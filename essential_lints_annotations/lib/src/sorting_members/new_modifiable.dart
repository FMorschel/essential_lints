part of 'sort_declarations.dart';

/*final*/ class _NewModifiable extends _StaticalContext {
  const _NewModifiable._() : super._();
}

/// {@template new_modifiable}
/// Represents new members (not-overridden).
/// {@endtemplate}
@_gettersInMemberList
/*sealed*/ abstract class NewMemberModifiable extends _NewModifiable {
  /// {@macro public}
  const factory NewMemberModifiable.public(
    PublicStaticalModifiable modifiable,
  ) = _Public._;

  /// {@macro private}
  const factory NewMemberModifiable.private(
    PrivateStaticalModifiable modifiable,
  ) = _Private._;

  /// {@macro nullable}
  const factory NewMemberModifiable.nullable(
    NullableMembersModifiable modifiable,
  ) = _Nullable._;

  /// {@macro typed}
  const factory NewMemberModifiable.typed(TypedMembersModifiable modifiable) =
      _Typed._;

  /// {@macro dynamic}
  const factory NewMemberModifiable.dynamic(
    DynamicMembersModifiable modifiable,
  ) = _Dynamic._;

  /// {@macro abstract}
  const factory NewMemberModifiable.abstract(Abstractable modifiable) =
      _Abstract._;

  /// {@macro operator}
  const factory NewMemberModifiable.operator([OperatorModifiable modifiable]) =
      _Operator._;

  /// {@macro initialized}
  const factory NewMemberModifiable.initialized(
    InitializableOverridable modifiable,
  ) = _Initialized._;

  /// {@macro late_modifiable}
  const factory NewMemberModifiable.late(LateModifiable modifiable) = _Late._;

  /// {@macro var}
  const factory NewMemberModifiable.var_(Variable modifiable) = _Var._;

  /// {@macro final}
  const factory NewMemberModifiable.final_(FinalModifiable modifiable) =
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
  static List<NewMemberModifiable> get _members => [
        fields,
        fieldsGettersSetters,
        getters,
        gettersSetters,
        setters,
        methods,
      ];
}

/// {@macro new_modifiable}
@_gettersInMemberList
/*sealed*/ abstract class NewExternalModifiable extends _NewModifiable {
  /// {@macro public}
  const factory NewExternalModifiable.public(
    PublicStaticalModifiable modifiable,
  ) = _Public._;

  /// {@macro private}
  const factory NewExternalModifiable.private(
    PrivateStaticalModifiable modifiable,
  ) = _Private._;

  /// {@macro nullable}
  const factory NewExternalModifiable.nullable(
    NullableExternableModifiable modifiable,
  ) = _Nullable._;

  /// {@macro typed}
  const factory NewExternalModifiable.typed(
    TypedExternableModifiable modifiable,
  ) = _Typed._;

  /// {@macro dynamic}
  const factory NewExternalModifiable.dynamic(
    DynamicExternableModifiable modifiable,
  ) = _Dynamic._;

  /// {@macro operator}
  const factory NewExternalModifiable.operator([
    OperatorModifiable modifiable,
  ]) = _Operator._;

  /// {@macro var}
  const factory NewExternalModifiable.var_(VariableAbstractable modifiable) =
      _Var._;

  /// {@macro final}
  const factory NewExternalModifiable.final_(
    FinalAbstractModifiable modifiable,
  ) = _Final._;

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
  static List<NewExternalModifiable> get _members => [
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
  th<_Overridden>(),
  th<_New>(),
})
@MutuallyExclusive(#overriding)
/*final*/ class _New<M extends _NewModifiable> extends Modifier<M>
    implements
        InstantiableMembers,
        ExternalMembersModifiable,
        InstantiableExternal {
  const _New._(super.modifiable) : super._();
}
