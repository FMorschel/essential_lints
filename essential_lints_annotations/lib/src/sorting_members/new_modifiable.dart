part of 'sort_declarations.dart';

/// {@template new_modifiable}
/// Represents new members (not-overridden).
/// {@endtemplate}
@_gettersInMemberList
sealed class NewModifiable extends StaticalContext {
  const NewModifiable._() : super._();

  // ignore: unused_element member list
  static List<NewModifiable> get _members => const [];
}

/// {@macro new_modifiable}
@_gettersInMemberList
sealed class NewMemberModifiable extends NewModifiable {
  /// {@macro public}
  const factory NewMemberModifiable.public(
    PublicStaticalModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory NewMemberModifiable.private(
    PrivateStaticalModifiable modifiable,
  ) = Private._;

  /// {@macro nullable}
  const factory NewMemberModifiable.nullable(
    NullableMembersModifiable modifiable,
  ) = Nullable._;

  /// {@macro typed}
  const factory NewMemberModifiable.typed(TypedMembersModifiable modifiable) =
      Typed._;

  /// {@macro dynamic}
  const factory NewMemberModifiable.dynamic(
    DynamicMembersModifiable modifiable,
  ) = Dynamic._;

  /// {@macro abstract}
  const factory NewMemberModifiable.abstract(Abstractable modifiable) =
      Abstract._;

  /// {@macro operator}
  const factory NewMemberModifiable.operator([OperatorModifiable modifiable]) =
      Operator._;

  /// {@macro initializable}
  const factory NewMemberModifiable.initialized(
    InitializableOverridable modifiable,
  ) = Initialized._;

  /// {@macro late_modifiable}
  const factory NewMemberModifiable.late(LateModifiable modifiable) = Late._;

  /// {@macro var}
  const factory NewMemberModifiable.var_(Variable modifiable) = Var._;

  /// {@macro final}
  const factory NewMemberModifiable.final_(FinalModifiable modifiable) =
      Final._;

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
sealed class NewExternalModifiable extends NewModifiable {
  /// {@macro public}
  const factory NewExternalModifiable.public(
    PublicStaticalModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory NewExternalModifiable.private(
    PrivateStaticalModifiable modifiable,
  ) = Private._;

  /// {@macro nullable}
  const factory NewExternalModifiable.nullable(
    NullableExternableModifiable modifiable,
  ) = Nullable._;

  /// {@macro typed}
  const factory NewExternalModifiable.typed(
    TypedExternableModifiable modifiable,
  ) = Typed._;

  /// {@macro dynamic}
  const factory NewExternalModifiable.dynamic(
    DynamicExternableModifiable modifiable,
  ) = Dynamic._;

  /// {@macro operator}
  const factory NewExternalModifiable.operator([
    OperatorModifiable modifiable,
  ]) = Operator._;

  /// {@macro var}
  const factory NewExternalModifiable.var_(VariableAbstractable modifiable) =
      Var._;

  /// {@macro final}
  const factory NewExternalModifiable.final_(
    FinalAbstractModifiable modifiable,
  ) = Final._;

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

/// {@template new}
/// Represents new members (non-overridden).
/// {@endtemplate}
@InvalidMembers({th<Constructors>()})
@InvalidModifiers({
  th<Static>(),
  th<Overridden>(),
  th<New>(),
})
@MutuallyExclusive(#overriding)
final class New<M extends NewModifiable> extends Modifier<M>
    implements
        InstanciableMembers,
        ExternalMembersModifiable,
        InstanciableExternal {
  /// {@macro new}
  const New._(super.modifiable) : super._();
}
