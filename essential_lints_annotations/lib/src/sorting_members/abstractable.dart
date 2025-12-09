part of 'sort_declarations.dart';

/// {@template abstractable}
/// Represents abstractable members.
/// {@endtemplate}
class Abstractable extends Modifiable
    implements Overridable, OperatorModifiable {
  /// {@macro abstractable}
  const Abstractable();

  /// {@macro var}
  static const VariableGenerator variable = Var.variable;

  /// {@macro fields}
  static const Abstractable fields = Fields.fields;

  /// {@macro methods}
  static const Abstractable methods = Methods.methods;
}

/// A helper typedef for generating abstract modifiers.
typedef AbstractGenerator = ModifierGenerator<Abstractable, Abstract>;

/// {@template abstractable}
/// Represents abstract members.
/// {@endtemplate}
class Abstract<M extends Abstractable> extends Modifier<M> {
  /// {@macro abstractable}
  const Abstract(super.modifiable);

  /// {@macro abstractable}
  static const AbstractGenerator abstract = Abstract.new;
}
