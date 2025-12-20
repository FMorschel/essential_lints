part of 'sort_declarations.dart';

/// {@template overridable}
/// Represents overridable members.
/// {@endtemplate}
@_gettersInMemberList
sealed class Overridable extends StaticalContext {
  const Overridable._() : super._();

  // ignore: unused_element member list
  static List<Overridable> get _members => const [];
}

@_gettersInMemberList
/// {@macro overridable}
sealed class OverridableMembers extends Overridable {
  /// {@macro public}
  const factory OverridableMembers.public(PublicStaticalModifiable modifiable) =
      Public._;

  /// {@macro private}
  const factory OverridableMembers.private(
    PrivateStaticalModifiable modifiable,
  ) = Private._;

  /// {@macro nullable}
  const factory OverridableMembers.nullable(
    NullableMembersModifiable modifiable,
  ) = Nullable._;

  /// {@macro typed}
  const factory OverridableMembers.typed(TypedMembersModifiable modifiable) =
      Typed._;

  /// {@macro dynamic}
  const factory OverridableMembers.dynamic(
    DynamicMembersModifiable modifiable,
  ) = Dynamic._;

  /// {@macro abstract}
  const factory OverridableMembers.abstract(Abstractable modifiable) =
      Abstract._;

  /// {@macro operator}
  const factory OverridableMembers.operator([OperatorModifiable modifiable]) =
      Operator._;

  /// {@macro initializable}
  const factory OverridableMembers.initialized(
    InitializableOverridable modifiable,
  ) = Initialized._;

  /// {@macro late_modifiable}
  const factory OverridableMembers.late(LateModifiable modifiable) = Late._;

  /// {@macro var}
  const factory OverridableMembers.var_(Variable modifiable) = Var._;

  /// {@macro final}
  const factory OverridableMembers.final_(FinalModifiable modifiable) = Final._;

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

@_gettersInMemberList
/// {@macro overridable}
sealed class OverridableExternal extends Overridable {
  /// {@macro public}
  const factory OverridableExternal.public(
    PublicStaticalModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory OverridableExternal.private(
    PrivateStaticalModifiable modifiable,
  ) = Private._;

  /// {@macro nullable}
  const factory OverridableExternal.nullable(
    NullableExternableModifiable modifiable,
  ) = Nullable._;

  /// {@macro typed}
  const factory OverridableExternal.typed(
    TypedExternableModifiable modifiable,
  ) = Typed._;

  /// {@macro dynamic}
  const factory OverridableExternal.dynamic(
    DynamicExternableModifiable modifiable,
  ) = Dynamic._;

  /// {@macro operator}
  const factory OverridableExternal.operator([OperatorModifiable modifiable]) =
      Operator._;

  /// {@macro var}
  const factory OverridableExternal.var_(VariableAbstractable modifiable) =
      Var._;

  /// {@macro final}
  const factory OverridableExternal.final_(FinalAbstractModifiable modifiable) =
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
  static List<OverridableExternal> get _members => [
    fields,
    fieldsGettersSetters,
    getters,
    gettersSetters,
    setters,
    methods,
  ];
}

/// {@template overridden}
/// Represents overridden members.
/// {@endtemplate}
@InvalidMembers({th<Constructors>()})
@InvalidModifiers({
  th<Static>(),
  th<Instance>(),
  th<Overridden>(),
  th<New>(),
  th<External>(),
})
@MutuallyExclusive(#overriding)
final class Overridden<M extends Overridable> extends Modifier<M>
    implements
        InstanciableMembers,
        ExternalMembersModifiable,
        InstanciableExternal {
  /// {@macro overridden}
  const Overridden._(super.modifiable) : super._();
}
