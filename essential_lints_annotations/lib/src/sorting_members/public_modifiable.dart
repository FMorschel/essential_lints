part of 'sort_declarations.dart';

/// Represents final members.
sealed class PublicModifiable extends Modifiable implements Statical {
  const PublicModifiable();

  /// {@macro fields}
  static const PublicModifiable fields = Fields.fields;

  /// {@macro fieldsGettersSetters}
  static const PublicModifiable fieldsGettersSetters =
      FieldsGettersSetters.fieldsGettersSetters;

  /// {@macro getters}
  static const PublicModifiable getters = Getters.getters;

  /// {@macro gettersSetters}
  static const PublicModifiable gettersSetters = GettersSetters.gettersSetters;

  /// {@macro methods}
  static const PublicModifiable methods = Methods.methods;

  /// {@macro setters}
  static const PublicModifiable setters = Setters.setters;
}

/// A helper typedef for generating variable modifiers.
typedef PublicModifiableGenerator<
  I extends PublicModifiable,
  O extends Public<I>
> = ModifierGenerator<I, O>;

/// {@template public}
/// Represents public members.
/// {@endtemplate}
final class Public<M extends PublicModifiable> extends Modifier<M> {
  /// {@macro public}

  const Public(super.modifiable);

  /// {@macro public}
  static const PublicModifiableGenerator public = Public.new;
}
