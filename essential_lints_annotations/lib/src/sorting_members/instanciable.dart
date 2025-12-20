part of 'sort_declarations.dart';

/// Class representing instance sort declarations.
@_gettersInMemberList
sealed class Instanciable extends StaticalContext {
  const Instanciable._() : super._();

  // ignore: unused_element member list
  static List<Instanciable> get _members => const [];
}

/// Represents instance members.
@_gettersInMemberList
sealed class InstanciableMembers extends Instanciable {
  /// {@macro public}
  const factory InstanciableMembers.public(
    PublicStaticalModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory InstanciableMembers.private(
    PrivateStaticalModifiable modifiable,
  ) = Private._;

  /// {@macro nullable}
  const factory InstanciableMembers.nullable(
    NullableMembersModifiable modifiable,
  ) = Nullable._;

  /// {@macro typed}
  const factory InstanciableMembers.typed(TypedMembersModifiable modifiable) =
      Typed._;

  /// {@macro dynamic}
  const factory InstanciableMembers.dynamic(
    DynamicMembersModifiable modifiable,
  ) = Dynamic._;

  /// {@macro abstract}
  const factory InstanciableMembers.abstract(Abstractable modifiable) =
      Abstract._;

  /// {@macro operator}
  const factory InstanciableMembers.operator([OperatorModifiable modifiable]) =
      Operator._;

  /// {@macro initializable}
  const factory InstanciableMembers.initialized(
    InitializableOverridable modifiable,
  ) = Initialized._;

  /// {@macro late_modifiable}
  const factory InstanciableMembers.late(LateModifiable modifiable) = Late._;

  /// {@macro var}
  const factory InstanciableMembers.var_(Variable modifiable) = Var._;

  /// {@macro final}
  const factory InstanciableMembers.final_(FinalModifiable modifiable) =
      Final._;

  /// {@macro overridden}
  const factory InstanciableMembers.overridden(OverridableMembers modifiable) =
      Overridden._;

  /// {@macro new}
  const factory InstanciableMembers.new_(NewMemberModifiable modifiable) =
      New._;

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
  static List<InstanciableMembers> get _members => [
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
sealed class InstanciableExternal extends Instanciable {
  /// {@macro public}
  const factory InstanciableExternal.public(
    PublicStaticalModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory InstanciableExternal.private(
    PrivateStaticalModifiable modifiable,
  ) = Private._;

  /// {@macro nullable}
  const factory InstanciableExternal.nullable(
    NullableExternableModifiable modifiable,
  ) = Nullable._;

  /// {@macro typed}
  const factory InstanciableExternal.typed(
    TypedExternableModifiable modifiable,
  ) = Typed._;

  /// {@macro dynamic}
  const factory InstanciableExternal.dynamic(
    DynamicExternableModifiable modifiable,
  ) = Dynamic._;

  /// {@macro operator}
  const factory InstanciableExternal.operator([OperatorModifiable modifiable]) =
      Operator._;

  /// {@macro var}
  const factory InstanciableExternal.var_(VariableAbstractable modifiable) =
      Var._;

  /// {@macro final}
  const factory InstanciableExternal.final_(
    FinalAbstractModifiable modifiable,
  ) = Final._;

  /// {@macro overridden}
  const factory InstanciableExternal.overridden(
    OverridableExternal modifiable,
  ) = Overridden._;

  /// {@macro new}
  const factory InstanciableExternal.new_(NewExternalModifiable modifiable) =
      New._;

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
  static List<InstanciableExternal> get _members => [
    fields,
    fieldsGettersSetters,
    getters,
    gettersSetters,
    setters,
    methods,
  ];
}

/// {@template instance}
/// Represents instance members.
/// {@endtemplate}
@InvalidMembers({th<Constructors>()})
@InvalidModifiers({
  th<Static>(),
  th<Instance>(),
  th<External>(),
})
@MutuallyExclusive(#context)
final class Instance extends Modifier<Instanciable>
    implements ExternalMembersModifiable {
  /// {@macro instance}
  const Instance._(super.modifiable) : super._();
}
