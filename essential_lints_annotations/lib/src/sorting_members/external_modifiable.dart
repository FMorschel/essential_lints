part of 'sort_declarations.dart';

/// Represents external modifiable members.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class ExternalModifiable extends StaticalContext {
  const ExternalModifiable._() : super._();
}

/// {@template externalMembers}
/// Represents members that can be external and their modifiers.
/// {@endtemplate}
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class ExternalMembersModifiable extends ExternalModifiable {
  /// {@macro factory}
  @Consider<Factory>()
  const factory ExternalMembersModifiable.factory_(
    FactoryModifiable modifiable,
  ) = Factory._;

  /// {@macro nullable}
  @Consider<Nullable>()
  const factory ExternalMembersModifiable.nullable(
    NullableExternableModifiable modifiable,
  ) = Nullable._;

  /// {@macro operator}
  @Consider<Operator>()
  const factory ExternalMembersModifiable.operator([
    OperatorModifiable modifiable,
  ]) = Operator._;

  /// {@macro public}
  @Consider<Public>()
  const factory ExternalMembersModifiable.public(PublicModifiable modifiable) =
      Public._;

  /// {@macro private}
  @Consider<Private>()
  const factory ExternalMembersModifiable.private(
    PrivateModifiable modifiable,
  ) = Private._;

  /// {@macro static}
  @Consider<Unnamed>()
  const factory ExternalMembersModifiable.unnamed(
    UnnamedModifiable modifiable,
  ) = Unnamed._;

  /// {@macro var}
  @Consider<Var>()
  const factory ExternalMembersModifiable.var_(
    VariableAbstractable modifiable,
  ) = Var._;

  /// {@macro final}
  @Consider<Final>()
  const factory ExternalMembersModifiable.final_(
    FinalAbstractModifiable modifiable,
  ) = Final._;

  /// {@macro static}
  @Consider<Static>()
  const factory ExternalMembersModifiable.static(StaticalExternal modifiable) =
      Static._;

  /// {@macro named}
  @Consider<Named>()
  const factory ExternalMembersModifiable.named(NamedModifiable modifiable) =
      Named._;

  /// {@macro constructors}
  @Consider<Constructors>()
  static const ExternalMembersModifiable constructors =
      Constructors._constructors;

  /// {@macro fields}
  @Consider<Fields>()
  static const ExternalMembersModifiable fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  @Consider<FieldsGettersSetters>()
  static const ExternalMembersModifiable fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  @Consider<Getters>()
  static const ExternalMembersModifiable getters = Getters._getters;

  /// {@macro gettersSetters}
  @Consider<GettersSetters>()
  static const ExternalMembersModifiable gettersSetters =
      GettersSetters._gettersSetters;

  /// {@macro methods}
  @Consider<Methods>()
  static const ExternalMembersModifiable methods = Methods._methods;

  /// {@macro setters}
  @Consider<Setters>()
  static const ExternalMembersModifiable setters = Setters._setters;
}

/// {@template externalMembers}
/// Represents members that can be external and their modifiers.
/// {@endtemplate}
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class ExternalInstanceModifiable extends ExternalModifiable
    implements Overridable {
  /// {@macro operator}
  @Consider<Operator>()
  const factory ExternalInstanceModifiable.operator([
    OperatorModifiable modifiable,
  ]) = Operator._;

  /// {@macro var}
  @Consider<Var>()
  const factory ExternalInstanceModifiable.var_(
    VariableAbstractable modifiable,
  ) = Var._;

  /// {@macro final}
  @Consider<Final>()
  const factory ExternalInstanceModifiable.final_(
    FinalAbstractModifiable modifiable,
  ) = Final._;

  /// {@macro public}
  @Consider<Public>()
  const factory ExternalInstanceModifiable.public(
    PublicStaticalModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  @Consider<Private>()
  const factory ExternalInstanceModifiable.private(
    PrivateStaticalModifiable modifiable,
  ) = Private._;

  /// {@macro nullable}
  @Consider<Nullable>()
  const factory ExternalInstanceModifiable.nullable(
    NullableExternableModifiable modifiable,
  ) = Nullable._;

  /// {@macro fields}
  @Consider<Fields>()
  static const ExternalInstanceModifiable fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  @Consider<FieldsGettersSetters>()
  static const ExternalInstanceModifiable fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  @Consider<Getters>()
  static const ExternalInstanceModifiable getters = Getters._getters;

  /// {@macro gettersSetters}
  @Consider<GettersSetters>()
  static const ExternalInstanceModifiable gettersSetters =
      GettersSetters._gettersSetters;

  /// {@macro methods}
  @Consider<Methods>()
  static const ExternalInstanceModifiable methods = Methods._methods;

  /// {@macro setters}
  @Consider<Setters>()
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
@InvalidMembers(<TypeHolder<Group>>[])
final class External<M extends ExternalModifiable> extends Modifier<M>
    implements Overridable {
  /// {@macro external}
  const External._(super.modifiable) : super._();
}
