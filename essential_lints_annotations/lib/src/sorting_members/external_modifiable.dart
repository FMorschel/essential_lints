part of 'sort_declarations.dart';

/// Represents external modifiable members.
@_gettersInMemberList
sealed class ExternalModifiable extends StaticalContext {
  const ExternalModifiable._() : super._();

  // ignore: unused_element member list
  static List<DynamicExternableModifiable> get _members => const [];
}

/// {@template externalMembers}
/// Represents members that can be external and their modifiers.
/// {@endtemplate}
@_gettersInMemberList
sealed class ExternalMembersModifiable extends ExternalModifiable {
  /// {@macro factory}
  const factory ExternalMembersModifiable.factory_(
    FactoryExternalModifiable modifiable,
  ) = Factory._;

  /// {@macro nullable}
  const factory ExternalMembersModifiable.nullable(
    NullableExternableModifiable modifiable,
  ) = Nullable._;

  /// {@macro typed}
  const factory ExternalMembersModifiable.typed(
    TypedExternableModifiable modifiable,
  ) = Typed._;

  /// {@macro dynamic}
  const factory ExternalMembersModifiable.dynamic(
    DynamicExternableModifiable modifiable,
  ) = Dynamic._;

  /// {@macro operator}
  const factory ExternalMembersModifiable.operator([
    OperatorModifiable modifiable,
  ]) = Operator._;

  /// {@macro public}
  const factory ExternalMembersModifiable.public(PublicModifiable modifiable) =
      Public._;

  /// {@macro private}
  const factory ExternalMembersModifiable.private(
    PrivateModifiable modifiable,
  ) = Private._;

  /// {@macro static}
  const factory ExternalMembersModifiable.unnamed(
    UnnamedModifiable modifiable,
  ) = Unnamed._;

  /// {@macro var}
  const factory ExternalMembersModifiable.var_(
    VariableAbstractable modifiable,
  ) = Var._;

  /// {@macro final}
  const factory ExternalMembersModifiable.final_(
    FinalAbstractModifiable modifiable,
  ) = Final._;

  /// {@macro static}
  const factory ExternalMembersModifiable.static(StaticalExternal modifiable) =
      Static._;

  /// {@macro named}
  const factory ExternalMembersModifiable.named(NamedModifiable modifiable) =
      Named._;

  /// {@macro overridden}
  const factory ExternalMembersModifiable.overridden(
    OverridableExternal modifiable,
  ) = Overridden._;

  /// {@macro new}
  const factory ExternalMembersModifiable.new_(
    NewExternalModifiable modifiable,
  ) = New._;

  /// {@macro instance}
  const factory ExternalMembersModifiable.instance(
    InstanciableExternal modifiable,
  ) = Instance._;

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

/// {@template external}
/// Represents external members.
/// {@endtemplate}
@InvalidModifiers({
  th<Abstract>(),
  th<Late>(),
  th<Initialized>(),
  th<Redirecting>(),
  th<External>(),
})
@InvalidMembers(<TypeHolder<Group>>{})
final class External<M extends ExternalModifiable> extends Modifier<M> {
  /// {@macro external}
  const External._(super.modifiable) : super._();
}
