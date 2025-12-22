part of 'sort_declarations.dart';

/// Represents external modifiable members.
@_gettersInMemberList
sealed class _ExternalModifiable extends _StaticalContext {
  const _ExternalModifiable._() : super._();

  // ignore: unused_element member list
  static List<DynamicExternableModifiable> get _members => const [];
}

/// {@template externalMembers}
/// Represents members that can be external and their modifiers.
/// {@endtemplate}
@_gettersInMemberList
sealed class ExternalMembersModifiable extends _ExternalModifiable {
  /// {@macro factory}
  const factory ExternalMembersModifiable.factory_(
    FactoryExternalModifiable modifiable,
  ) = _Factory._;

  /// {@macro nullable}
  const factory ExternalMembersModifiable.nullable(
    NullableExternableModifiable modifiable,
  ) = _Nullable._;

  /// {@macro typed}
  const factory ExternalMembersModifiable.typed(
    TypedExternableModifiable modifiable,
  ) = _Typed._;

  /// {@macro dynamic}
  const factory ExternalMembersModifiable.dynamic(
    DynamicExternableModifiable modifiable,
  ) = _Dynamic._;

  /// {@macro operator}
  const factory ExternalMembersModifiable.operator([
    OperatorModifiable modifiable,
  ]) = _Operator._;

  /// {@macro public}
  const factory ExternalMembersModifiable.public(PublicModifiable modifiable) =
      _Public._;

  /// {@macro private}
  const factory ExternalMembersModifiable.private(
    PrivateModifiable modifiable,
  ) = _Private._;

  /// {@macro unnamed}
  const factory ExternalMembersModifiable.unnamed(
    UnnamedModifiable modifiable,
  ) = _Unnamed._;

  /// {@macro var}
  const factory ExternalMembersModifiable.var_(
    VariableAbstractable modifiable,
  ) = _Var._;

  /// {@macro final}
  const factory ExternalMembersModifiable.final_(
    FinalAbstractModifiable modifiable,
  ) = _Final._;

  /// {@macro static}
  const factory ExternalMembersModifiable.static(StaticalExternal modifiable) =
      _Static._;

  /// {@macro named}
  const factory ExternalMembersModifiable.named(NamedModifiable modifiable) =
      _Named._;

  /// {@macro overridden}
  const factory ExternalMembersModifiable.overridden(
    OverridableExternal modifiable,
  ) = _Overridden._;

  /// {@macro new}
  const factory ExternalMembersModifiable.new_(
    NewExternalModifiable modifiable,
  ) = _New._;

  /// {@macro instance}
  const factory ExternalMembersModifiable.instance(
    InstantiableExternal modifiable,
  ) = _Instance._;

  /// {@macro constructors}
  static const Constructors constructors = Constructors._constructors;

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
  static List<ExternalMembersModifiable> get _members => [
    constructors,
    fields,
    fieldsGettersSetters,
    getters,
    gettersSetters,
    setters,
    methods,
  ];
}

@InvalidModifiers({
  th<_Abstract>(),
  th<_Late>(),
  th<_Initialized>(),
  th<_Redirecting>(),
  th<_External>(),
})
@InvalidMembers(<TypeHolder<Group>>{})
final class _External<M extends _ExternalModifiable> extends Modifier<M> {
  const _External._(super.modifiable) : super._();
}
