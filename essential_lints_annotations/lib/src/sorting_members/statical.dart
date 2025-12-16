part of 'sort_declarations.dart';

/// Represents statical members.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class Statical extends StaticalContext implements OperatorModifiable {
  /// {@macro initialized}
  @Consider<Initialized>()
  const factory Statical.initialized(InitializableStatical modifiable) =
      Initialized._;

  /// {@macro nullable}
  @Consider<Nullable>()
  const factory Statical.nullable(NullableMembersModifiable modifiable) =
      Nullable._;

  /// {@macro late_modifiable}
  @Consider<Late>()
  const factory Statical.late(LateModifiable modifiable) = Late._;

  /// {@macro var}
  @Consider<Var>()
  const factory Statical.var_(Variable modifiable) = Var._;

  /// {@macro final}
  @Consider<Final>()
  const factory Statical.final_(FinalModifiable modifiable) = Final._;

  /// {@macro const}
  @Consider<Const>()
  const factory Statical.const_(ConstantVariables modifiable) = Const._;

  /// {@macro private}
  @Consider<Private>()
  const factory Statical.private(PrivateStaticalModifiable modifiable) =
      Private._;

  /// {@macro public}
  @Consider<Public>()
  const factory Statical.public(PublicStaticalModifiable modifiable) = Public._;

  /// {@macro fields}
  @Consider<Fields>()
  static const Statical fields = Fields._fields;

  /// {@macro methods}
  @Consider<Methods>()
  static const Statical methods = Methods._methods;

  /// {@macro getters}
  @Consider<Getters>()
  static const Statical getters = Getters._getters;

  /// {@macro setters}
  @Consider<Setters>()
  static const Statical setters = Setters._setters;
}

/// Represents statical members that are external.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class StaticalExternal extends Statical {
  /// {@macro nullable}
  @Consider<Nullable>()
  const factory StaticalExternal.nullable(
    NullableMembersModifiable modifiable,
  ) = Nullable._;

  /// {@macro var}
  @Consider<Var>()
  const factory StaticalExternal.var_(VariableAbstractable modifiable) = Var._;

  /// {@macro final}
  @Consider<Final>()
  const factory StaticalExternal.final_(FinalAbstractModifiable modifiable) =
      Final._;

  /// {@macro private}
  @Consider<Private>()
  const factory StaticalExternal.private(PrivateStaticalModifiable modifiable) =
      Private._;

  /// {@macro public}
  @Consider<Public>()
  const factory StaticalExternal.public(PublicStaticalModifiable modifiable) =
      Public._;

  /// {@macro fields}
  @Consider<Fields>()
  static const StaticalExternal fields = Fields._fields;

  /// {@macro methods}
  @Consider<Methods>()
  static const StaticalExternal methods = Methods._methods;

  /// {@macro getters}
  @Consider<Getters>()
  static const StaticalExternal getters = Getters._getters;

  /// {@macro setters}
  @Consider<Setters>()
  static const StaticalExternal setters = Setters._setters;
}

/// {@template static}
/// Represents static members.
/// {@endtemplate}
@InvalidMembers([th<Constructors>()])
@InvalidModifiers([
  th<Overridden>(),
  th<Abstract>(),
  th<Operator>(),
  th<Static>(),
  th<External>(),
])
final class Static<M extends Statical> extends Modifier<M>
    implements OperatorModifiable, Overridable, ExternalMembersModifiable {
  /// {@macro static}
  const Static._(super.modifiable) : super._();
}
