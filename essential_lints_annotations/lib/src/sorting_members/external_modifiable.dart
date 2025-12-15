part of 'sort_declarations.dart';

/// Represents external modifiable members.
sealed class ExternalModifiable extends Modifiable {
  const ExternalModifiable._() : super._();
}

/// {@template externalMembers}
/// Represents members that can be external and their modifiers.
/// {@endtemplate}
sealed class ExternalMembersModifiable extends ExternalModifiable {
  /// {@macro factory}
  const factory ExternalMembersModifiable.factory_(
    FactoryModifiable modifiable,
  ) = Factory._;

  /// {@macro nullable}
  const factory ExternalMembersModifiable.nullable(
    NullableExternableModifiable modifiable,
  ) = Nullable._;

  /// {@macro operator}
  const factory ExternalMembersModifiable.operator(
    OperatorModifiable modifiable,
  ) = Operator._;

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

  /// {@macro constructors}
  static const ExternalMembersModifiable constructors =
      Constructors._constructors;

  /// {@macro fields}
  static const ExternalMembersModifiable fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  static const ExternalMembersModifiable fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  static const ExternalMembersModifiable getters = Getters._getters;

  /// {@macro gettersSetters}
  static const ExternalMembersModifiable gettersSetters =
      GettersSetters._gettersSetters;

  /// {@macro methods}
  static const ExternalMembersModifiable methods = Methods._methods;

  /// {@macro setters}
  static const ExternalMembersModifiable setters = Setters._setters;
}

/// {@template externalMembers}
/// Represents members that can be external and their modifiers.
/// {@endtemplate}
sealed class ExternalInstanceModifiable extends ExternalModifiable
    implements Overridable {
  /// {@macro operator}
  const factory ExternalInstanceModifiable.operator(
    OperatorModifiable modifiable,
  ) = Operator._;

  /// {@macro var}
  const factory ExternalInstanceModifiable.var_(
    VariableAbstractable modifiable,
  ) = Var._;

  /// {@macro final}
  const factory ExternalInstanceModifiable.final_(
    FinalAbstractModifiable modifiable,
  ) = Final._;

  /// {@macro public}
  const factory ExternalInstanceModifiable.public(
    PublicStaticalModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory ExternalInstanceModifiable.private(
    PrivateStaticalModifiable modifiable,
  ) = Private._;

  /// {@macro nullable}
  const factory ExternalInstanceModifiable.nullable(
    NullableExternableModifiable modifiable,
  ) = Nullable._;

  /// {@macro fields}
  static const ExternalInstanceModifiable fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  static const ExternalInstanceModifiable fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  static const ExternalInstanceModifiable getters = Getters._getters;

  /// {@macro gettersSetters}
  static const ExternalInstanceModifiable gettersSetters =
      GettersSetters._gettersSetters;

  /// {@macro methods}
  static const ExternalInstanceModifiable methods = Methods._methods;

  /// {@macro setters}
  static const ExternalInstanceModifiable setters = Setters._setters;
}

/// {@template external}
/// Represents external members.
/// {@endtemplate}
@InvalidModifiers([
  th<Abstract>(),
  th<Late>(),
  th<Initialized>(),
  th<Redirecting>(),
  th<External>(),
  th<Overridden>(),
])
final class External<M extends ExternalModifiable> extends Modifier<M>
    implements Overridable {
  /// {@macro external}
  const External._(super.modifiable) : super._();
}
