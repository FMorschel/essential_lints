part of 'sort_declarations.dart';

/// Represents statical members.
@_gettersInMemberList
sealed class Statical extends StaticalContext implements OperatorModifiable {
  /// {@macro initialized}
  const factory Statical.initialized(InitializableStatical modifiable) =
      Initialized._;

  /// {@macro nullable}
  const factory Statical.nullable(NullableMembersModifiable modifiable) =
      Nullable._;

  /// {@macro typed}
  const factory Statical.typed(TypedMembersModifiable modifiable) = Typed._;

  /// {@macro dynamic}
  const factory Statical.dynamic(DynamicMembersModifiable modifiable) =
      Dynamic._;

  /// {@macro late_modifiable}
  const factory Statical.late(LateModifiable modifiable) = Late._;

  /// {@macro var}
  const factory Statical.var_(Variable modifiable) = Var._;

  /// {@macro final}
  const factory Statical.final_(FinalModifiable modifiable) = Final._;

  /// {@macro const}
  const factory Statical.const_(ConstantVariables modifiable) = Const._;

  /// {@macro private}
  const factory Statical.private(PrivateStaticalModifiable modifiable) =
      Private._;

  /// {@macro public}
  const factory Statical.public(PublicStaticalModifiable modifiable) = Public._;

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
  ) = Nullable._;

  /// {@macro typed}
  const factory StaticalExternal.typed(TypedExternableModifiable modifiable) =
      Typed._;

  /// {@macro dynamic}
  const factory StaticalExternal.dynamic(
    DynamicExternableModifiable modifiable,
  ) = Dynamic._;

  /// {@macro var}
  const factory StaticalExternal.var_(VariableAbstractable modifiable) = Var._;

  /// {@macro final}
  const factory StaticalExternal.final_(FinalAbstractModifiable modifiable) =
      Final._;

  /// {@macro private}
  const factory StaticalExternal.private(PrivateStaticalModifiable modifiable) =
      Private._;

  /// {@macro public}
  const factory StaticalExternal.public(PublicStaticalModifiable modifiable) =
      Public._;

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

/// {@template static}
/// Represents static members.
/// {@endtemplate}
@InvalidMembers({th<Constructors>()})
@InvalidModifiers({
  th<Overridden>(),
  th<Abstract>(),
  th<Operator>(),
  th<Static>(),
  th<Instance>(),
  th<External>(),
})
@MutuallyExclusive(#context)
final class Static<M extends Statical> extends Modifier<M>
    implements ExternalMembersModifiable {
  /// {@macro static}
  const Static._(super.modifiable) : super._();
}
