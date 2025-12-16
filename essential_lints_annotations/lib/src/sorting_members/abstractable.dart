part of 'sort_declarations.dart';

/// Represents abstractable members.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class Abstractable extends StaticalContext
    implements Overridable, OperatorModifiable {
  /// {@macro public}
  @Consider<Public>()
  const factory Abstractable.public(PublicStaticalModifiable modifiable) =
      Public._;

  /// {@macro private}
  @Consider<Private>()
  const factory Abstractable.private(PrivateStaticalModifiable modifiable) =
      Private._;

  /// {@macro nullable}
  @Consider<Nullable>()
  const factory Abstractable.nullable(NullableMembersModifiable modifiable) =
      Nullable._;

  /// {@macro operator}
  @Consider<Operator>()
  const factory Abstractable.operator([OperatorModifiable modifiable]) =
      Operator._;

  /// {@macro var}
  @Consider<Variable>()
  const factory Abstractable.var_(VariableAbstractable modifiable) = Var._;

  /// {@macro final}
  @Consider<Final>()
  const factory Abstractable.final_(FinalAbstractModifiable modifiable) =
      Final._;

  /// {@macro fields}
  @Consider<Fields>()
  static const Abstractable fields = Fields._fields;

  /// {@macro getters}
  @Consider<Getters>()
  static const Abstractable getters = Getters._getters;

  /// {@macro setters}
  @Consider<Setters>()
  static const Abstractable setters = Setters._setters;

  /// {@macro methods}
  @Consider<Methods>()
  static const Abstractable methods = Methods._methods;
}

/// {@template abstract}
/// Represents abstract members.
/// {@endtemplate}
@InvalidMembers([th<Constructors>()])
@InvalidModifiers([
  th<External>(),
  th<Static>(),
  th<Initialized>(),
  th<Late>(),
  th<Abstract>(),
])
final class Abstract<M extends Abstractable> extends Modifier<M>
    implements Overridable {
  /// {@macro abstract}
  const Abstract._(super.modifiable) : super._();
}
