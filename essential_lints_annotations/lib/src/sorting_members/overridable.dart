part of 'sort_declarations.dart';

/// {@template overridable}
/// Represents overridable members.
/// {@endtemplate}
sealed class Overridable extends Modifiable {
  const Overridable();

  /// {@macro externalMembers}
  static const ExternalInstanceGenerator external = External.new;

  /// {@macro operator}
  static const OperatorGenerator operator = Operator.operator;

  /// {@macro abstractable}
  static const AbstractGenerator abstract = Abstract.abstract;

  /// {@macro initializable}
  static const InitializableGenerator initialized =
      InitializedModifier.initialized;

  /// {@macro static}
  static const StaticGenerator static = Static.static;

  /// {@macro late_modifiable}
  static const LateGenerator late = Late.late;

  /// {@macro var}
  static const VariableGenerator variable = Var.variable;

  /// {@macro fields}
  static const Overridable fields = Fields.fields;

  /// {@macro fieldsGettersSetters}
  static const Overridable fieldsGettersSetters =
      FieldsGettersSetters.fieldsGettersSetters;

  /// {@macro getters}
  static const Overridable getters = Getters.getters;

  /// {@macro gettersSetters}
  static const Overridable gettersSetters = GettersSetters.gettersSetters;

  /// {@macro methods}
  static const Overridable methods = Methods.methods;

  /// {@macro setters}
  static const Overridable setters = Setters.setters;
}

/// A helper typedef for generating overriden modifiers.
typedef OverriddenGenerator<I extends Overridable, O extends Overridden<I>> =
    ModifierGenerator<I, O>;

/// {@template overriden}
/// Represents overriden members.
/// {@endtemplate}
final class Overridden<M extends Overridable> extends Modifier<M>
    implements OperatorModifiable {
  /// {@macro overriden}
  const Overridden(super.modifiable);

  /// {@macro overriden}
  static const OverriddenGenerator overriden = Overridden.new;
}
