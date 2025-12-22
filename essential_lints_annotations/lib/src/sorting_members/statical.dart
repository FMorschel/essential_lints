part of 'sort_declarations.dart';

/// Represents statical members.
@_gettersInMemberList
sealed class Statical extends _StaticalContext implements OperatorModifiable {
  /// {@macro initialized}
  const factory Statical.initialized(InitializableStatical modifiable) =
      _Initialized._;

  /// {@macro nullable}
  const factory Statical.nullable(NullableMembersModifiable modifiable) =
      _Nullable._;

  /// {@macro typed}
  const factory Statical.typed(TypedMembersModifiable modifiable) = _Typed._;

  /// {@macro dynamic}
  const factory Statical.dynamic(DynamicMembersModifiable modifiable) =
      _Dynamic._;

  /// {@macro late_modifiable}
  const factory Statical.late(LateModifiable modifiable) = _Late._;

  /// {@macro var}
  const factory Statical.var_(Variable modifiable) = _Var._;

  /// {@macro final}
  const factory Statical.final_(FinalModifiable modifiable) = _Final._;

  /// {@macro const}
  const factory Statical.const_(ConstantVariables modifiable) = _Const._;

  /// {@macro private}
  const factory Statical.private(PrivateStaticalModifiable modifiable) =
      _Private._;

  /// {@macro public}
  const factory Statical.public(PublicStaticalModifiable modifiable) =
      _Public._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  static const FieldsGettersSetters fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro methods}
  static const Methods methods = Methods._methods;

  /// {@macro getters}
  static const Getters getters = Getters._getters;

  /// {@macro gettersSetters}
  static const GettersSetters gettersSetters = GettersSetters._gettersSetters;

  /// {@macro setters}
  static const Setters setters = Setters._setters;

  // ignore: unused_element member list
  static List<Statical> get _members => [
    fields,
    fieldsGettersSetters,
    getters,
    gettersSetters,
    setters,
    methods,
  ];
}

/// Represents statical members that are external.
@_gettersInMemberList
sealed class StaticalExternal extends Statical {
  /// {@macro nullable}
  const factory StaticalExternal.nullable(
    NullableExternableModifiable modifiable,
  ) = _Nullable._;

  /// {@macro typed}
  const factory StaticalExternal.typed(TypedExternableModifiable modifiable) =
      _Typed._;

  /// {@macro dynamic}
  const factory StaticalExternal.dynamic(
    DynamicExternableModifiable modifiable,
  ) = _Dynamic._;

  /// {@macro var}
  const factory StaticalExternal.var_(VariableAbstractable modifiable) = _Var._;

  /// {@macro final}
  const factory StaticalExternal.final_(FinalAbstractModifiable modifiable) =
      _Final._;

  /// {@macro private}
  const factory StaticalExternal.private(PrivateStaticalModifiable modifiable) =
      _Private._;

  /// {@macro public}
  const factory StaticalExternal.public(PublicStaticalModifiable modifiable) =
      _Public._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  static const FieldsGettersSetters fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro methods}
  static const Methods methods = Methods._methods;

  /// {@macro getters}
  static const Getters getters = Getters._getters;

  /// {@macro gettersSetters}
  static const GettersSetters gettersSetters = GettersSetters._gettersSetters;

  /// {@macro setters}
  static const Setters setters = Setters._setters;

  // ignore: unused_element member list
  static List<StaticalExternal> get _members => [
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
  th<_Overridden>(),
  th<_Abstract>(),
  th<_Operator>(),
  th<_Static>(),
  th<_Instance>(),
  th<_External>(),
})
@MutuallyExclusive(#context)
final class _Static<M extends Statical> extends Modifier<M>
    implements ExternalMembersModifiable {
  const _Static._(super.modifiable) : super._();
}
