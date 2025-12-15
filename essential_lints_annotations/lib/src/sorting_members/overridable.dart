part of 'sort_declarations.dart';

/// {@template overridable}
/// Represents overridable members.
/// {@endtemplate}
sealed class Overridable extends Modifiable {
  /// {@macro public}
  const factory Overridable.public(PublicStaticalModifiable modifiable) =
      Public._;

  /// {@macro private}
  const factory Overridable.private(PrivateStaticalModifiable modifiable) =
      Private._;

  /// {@macro nullable}
  const factory Overridable.nullable(NullableMembersModifiable modifiable) =
      Nullable._;

  /// {@macro abstract}
  const factory Overridable.abstract(Abstractable modifiable) = Abstract._;

  /// {@macro externalMembers}
  const factory Overridable.external(ExternalInstanceModifiable modifiable) =
      External._;

  /// {@macro operator}
  const factory Overridable.operator(OperatorModifiable modifiable) =
      Operator._;

  /// {@macro initializable}
  const factory Overridable.initialized(InitializableOverridable modifiable) =
      Initialized._;

  /// {@macro late_modifiable}
  const factory Overridable.late(LateModifiable modifiable) = Late._;

  /// {@macro var}
  const factory Overridable.var_(Variable modifiable) = Var._;

  /// {@macro final}
  const factory Overridable.final_(FinalModifiable modifiable) = Final._;

  /// {@macro fields}
  static const Overridable fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  static const Overridable fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  static const Overridable getters = Getters._getters;

  /// {@macro gettersSetters}
  static const Overridable gettersSetters = GettersSetters._gettersSetters;

  /// {@macro methods}
  static const Overridable methods = Methods._methods;

  /// {@macro setters}
  static const Overridable setters = Setters._setters;
}

/// {@template overridden}
/// Represents overridden members.
/// {@endtemplate}
@InvalidMembers([th<Constructors>()])
@InvalidModifiers([
  th<Static>(),
  th<Overridden>(),
])
final class Overridden<M extends Overridable> extends Modifier<M>
    implements OperatorModifiable {
  /// {@macro overridden}
  const Overridden._(super.modifiable) : super._();
}
