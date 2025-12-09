part of 'sort_declarations.dart';

/// Represents final members.
sealed class FinalModifiable extends Modifiable
    implements
        LateModifiable,
        Statical,
        Abstractable,
        ExternalModifiable,
        Overridable {
  const FinalModifiable();

  /// {@macro fields}
  static const FinalModifiable fields = Fields.fields;
}

/// A helper typedef for generating variable modifiers.
typedef FinalModifiableGenerator<
  I extends FinalModifiable,
  O extends Final<I>
> = ModifierGenerator<I, O>;

/// {@template final}
/// Represents final members.
/// {@endtemplate}
final class Final<M extends FinalModifiable> extends Modifier<M> {
  /// {@macro final}
  const Final(super.modifiable);

  /// {@macro final}
  static const FinalModifiableGenerator finalModifiable = Final.new;
}
