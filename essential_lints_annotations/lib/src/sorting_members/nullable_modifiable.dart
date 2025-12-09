part of 'sort_declarations.dart';

/// Represents final members.
sealed class NullableModifiable extends Modifiable implements Statical {
  const NullableModifiable();

  /// {@macro fields}
  static const NullableModifiable fields = Fields.fields;

  /// {@macro fieldsGettersSetters}
  static const NullableModifiable fieldsGettersSetters =
      FieldsGettersSetters.fieldsGettersSetters;

  /// {@macro getters}
  static const NullableModifiable getters = Getters.getters;

  /// {@macro gettersSetters}
  static const NullableModifiable gettersSetters =
      GettersSetters.gettersSetters;

  /// {@macro methods}
  static const NullableModifiable methods = Methods.methods;

  /// {@macro setters}
  static const NullableModifiable setters = Setters.setters;
}

/// A helper typedef for generating variable modifiers.
typedef NullableModifiableGenerator<
  I extends NullableModifiable,
  O extends Nullable<I>
> = ModifierGenerator<I, O>;

/// {@template nullable}
/// Represents nullable members.
/// {@endtemplate}
final class Nullable<M extends NullableModifiable> extends Modifier<M> {
  /// {@macro nullable}
  const Nullable(super.modifiable);

  /// {@macro nullable}
  static const NullableModifiableGenerator nullableModifiable = Nullable.new;
}
