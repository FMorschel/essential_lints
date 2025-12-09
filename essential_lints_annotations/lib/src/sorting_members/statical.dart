part of 'sort_declarations.dart';

/// Represents statical members.
sealed class Statical extends Modifiable implements OperatorModifiable {
  const Statical();

  /// {@macro late_modifiable}
  static const LateGenerator late = Late.late;

  /// {@macro var}
  static const VariableGenerator variable = Var.variable;

  /// {@macro fields}
  static const Statical fields = Fields.fields;

  /// {@macro methods}
  static const Statical methods = Methods.methods;

  /// {@macro getters}
  static const Statical getters = Getters.getters;

  /// {@macro setters}
  static const Statical setters = Setters.setters;
}

/// A helper typedef for generating static modifiers.
typedef StaticGenerator<I extends Statical, O extends Static<I>> =
    ModifierGenerator<I, O>;

/// {@template static}
/// Represents static members.
/// {@endtemplate}
final class Static<M extends Statical> extends Modifier<M>
    implements OperatorModifiable {
  /// {@macro static}
  const Static(super.modifiable);

  /// {@macro static}
  static const StaticGenerator static = Static.new;
}
