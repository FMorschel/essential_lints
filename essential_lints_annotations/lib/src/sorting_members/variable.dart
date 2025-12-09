part of 'sort_declarations.dart';

/// {@template variable}
/// Represents variable members.
/// {@endtemplate}
sealed class Variable extends Modifiable
    implements
        LateModifiable,
        Statical,
        Abstractable,
        ExternalModifiable,
        Overridable {
  const Variable();

  /// {@macro fields}
  static const Variable fields = Fields.fields;
}

/// A helper typedef for generating variable modifiers.
typedef VariableGenerator<I extends Variable, O extends Var<I>> =
    ModifierGenerator<I, O>;

/// {@template var}
/// Represents variable members.
/// {@endtemplate}
final class Var<M extends Variable> extends Modifier<M>
    implements ExternalInstanceModifiable {
  /// {@macro var}
  const Var(super.modifiable);

  /// {@macro var}
  static const VariableGenerator variable = Var.new;
}
