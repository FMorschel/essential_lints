part of 'sort_declarations.dart';

/// Represents private members.
sealed class PrivateModifiable extends Modifiable implements Statical {
  const PrivateModifiable();

  /// {@macro fields}
  static const PrivateModifiable fields = Fields.fields;

  /// {@macro fieldsGettersSetters}
  static const PrivateModifiable fieldsGettersSetters =
      FieldsGettersSetters.fieldsGettersSetters;

  /// {@macro getters}
  static const PrivateModifiable getters = Getters.getters;

  /// {@macro gettersSetters}
  static const PrivateModifiable gettersSetters = GettersSetters.gettersSetters;

  /// {@macro methods}
  static const PrivateModifiable methods = Methods.methods;

  /// {@macro setters}
  static const PrivateModifiable setters = Setters.setters;
}

/// A helper typedef for generating variable modifiers.
typedef PrivateModifiableGenerator<
  I extends PrivateModifiable,
  O extends Private<I>
> = ModifierGenerator<I, O>;

/// {@template private}
/// Represents private members.
/// {@endtemplate}
final class Private<M extends PrivateModifiable> extends Modifier<M> {
  /// {@macro private}
  const Private(super.modifiable);

  /// {@macro private}
  static const PrivateModifiableGenerator private = Private.new;
}
