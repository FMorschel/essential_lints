part of 'sort_declarations.dart';

/// Represents constant members.
sealed class Constant extends Modifiable {
  const Constant();
}

/// Represents constant fields.
sealed class ConstantVariables extends Constant
    implements
        LateModifiable,
        Statical,
        Abstractable,
        ExternalModifiable,
        Overridable {
  const ConstantVariables();

  /// {@macro fields}
  static const ConstantVariables fields = Fields.fields;
}

/// Represents constant constructors.
sealed class ConstantConstructors extends Constant
    implements ExternalModifiable {
  const ConstantConstructors();

  /// {@macro constructors}
  static const ConstantConstructors constructors = Constructors.constructors;
}

/// A helper typedef for generating constant modifiers.
typedef ConstGenerator = ModifierGenerator<Constant, Const<Constant>>;

/// A helper typedef for generating variable modifiers.
typedef ConstVarGenerator<I extends ConstantVariables, O extends Const<I>> =
    ModifierGenerator<I, O>;

/// A helper typedef for generating constant constructor modifiers.
typedef ConstConstructorGenerator<
  I extends ConstantConstructors,
  O extends Const<I>
> = ModifierGenerator<I, O>;

/// {@template const}
/// Represents constant members.
/// {@endtemplate}
final class Const<M extends Constant> extends Modifier<M> {
  /// {@macro const}
  const Const(super.modifiable);

  /// {@macro const}
  static const ConstGenerator constant = Const.new;
}
