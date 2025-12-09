part of 'sort_declarations.dart';

/// Groups initializable members.
sealed class Initializable extends Modifiable {
  const Initializable();

  /// {@macro fields}
  static const Initializable fields = Fields.fields;
}

/// A helper typedef for generating initializable modifiers.
typedef InitializableGenerator<
  I extends Initializable,
  O extends InitializedModifier<I>
> = ModifierGenerator<I, O>;

/// {@template initialized}
/// Represents initialized members.
/// {@endtemplate}
class InitializedModifier<M extends Initializable> extends Modifier<M>
    implements Statical, Overridable {
  /// {@macro initialized}
  const InitializedModifier(super.modifiable);

  /// {@macro initialized}
  static const InitializableGenerator initialized = InitializedModifier.new;
}
