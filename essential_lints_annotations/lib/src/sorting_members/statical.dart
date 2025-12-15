part of 'sort_declarations.dart';

/// Represents statical members.
sealed class Statical extends Modifiable implements OperatorModifiable {
  /// {@macro initialized}
  const factory Statical.initialized(InitializableStatical modifiable) =
      Initialized._;

  /// {@macro nullable}
  const factory Statical.nullable(NullableMembersModifiable modifiable) =
      Nullable._;

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
  static const Statical fields = Fields._fields;

  /// {@macro methods}
  static const Statical methods = Methods._methods;

  /// {@macro getters}
  static const Statical getters = Getters._getters;

  /// {@macro setters}
  static const Statical setters = Setters._setters;
}

/// Represents statical members that are external.
sealed class StaticalExternal extends Statical {
  /// {@macro nullable}
  const factory StaticalExternal.nullable(
    NullableMembersModifiable modifiable,
  ) = Nullable._;

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
  static const StaticalExternal fields = Fields._fields;

  /// {@macro methods}
  static const StaticalExternal methods = Methods._methods;

  /// {@macro getters}
  static const StaticalExternal getters = Getters._getters;

  /// {@macro setters}
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
