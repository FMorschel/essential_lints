part of 'sort_declarations.dart';

/// {@template methodModifiers}
/// Represents modifiers that can be applied to methods and methods themselves.
/// {@endtemplate}
sealed class OperatorModifiable extends Modifiable {
  const OperatorModifiable();

  /// {@macro methods}
  static const OperatorModifiable methods = Methods.methods;
}

/// A helper typedef for generating operator modifiers.
typedef OperatorGenerator<I extends OperatorModifiable, O extends Operator<I>> =
    ModifierGenerator<I, O>;

/// {@template operator}
/// Represents operator members.
/// {@endtemplate}
final class Operator<M extends OperatorModifiable> extends Modifier<M> {
  /// {@macro operator}
  const Operator(super.modifiable);

  /// {@macro operator}
  static const OperatorGenerator operator = Operator.new;
}
