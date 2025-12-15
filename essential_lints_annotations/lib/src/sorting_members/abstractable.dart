part of 'sort_declarations.dart';

/// Represents abstractable members.
sealed class Abstractable extends Modifiable
    implements Overridable, OperatorModifiable {
  /// {@macro public}
  const factory Abstractable.public(PublicStaticalModifiable modifiable) =
      Public._;

  /// {@macro private}
  const factory Abstractable.private(PrivateStaticalModifiable modifiable) =
      Private._;

  /// {@macro nullable}
  const factory Abstractable.nullable(NullableMembersModifiable modifiable) =
      Nullable._;

  /// {@macro operator}
  const factory Abstractable.operator(OperatorModifiable modifiable) =
      Operator._;

  /// {@macro var}
  const factory Abstractable.var_(VariableAbstractable modifiable) = Var._;

  /// {@macro final}
  const factory Abstractable.final_(FinalAbstractModifiable modifiable) =
      Final._;

  /// {@macro fields}
  static const Abstractable fields = Fields._fields;

  /// {@macro getters}
  static const Abstractable getters = Getters._getters;

  /// {@macro setters}
  static const Abstractable setters = Setters._setters;

  /// {@macro methods}
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
class Abstract<M extends Abstractable> extends Modifier<M>
    implements Overridable {
  /// {@macro abstract}
  const Abstract._(super.modifiable) : super._();
}
