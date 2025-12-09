part of 'sort_declarations.dart';

/// {@template late_modifiable}
/// Represents late modifiable members.
/// {@endtemplate}
sealed class LateModifiable extends Modifiable
    implements Statical, Overridable {
  const LateModifiable();

  /// {@macro fields}
  static const LateModifiable fields = Fields.fields;

  /// {@macro var}
  static const VariableGenerator variable = Var.variable;
}

/// A helper typedef for generating late modifiers.
typedef LateGenerator<I extends LateModifiable, O extends Late<I>> =
    ModifierGenerator<I, O>;

/// {@template late_modifiable}
/// Represents late members.
/// {@endtemplate}
final class Late<M extends LateModifiable> extends Modifier<M> {
  /// {@macro late_modifiable}
  const Late(super.modifiable);

  /// {@macro late_modifiable}
  static const LateGenerator late = Late.new;
}
