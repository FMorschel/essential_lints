part of 'sort_declarations.dart';

/// Groups of members.
sealed class Group extends Modifiable implements ExternalMembersModifiable {
  const Group();

  /// {@macro constructors}
  static const Group constructors = Constructors.constructors;

  /// {@macro fields}
  static const Group fields = Fields.fields;

  /// {@macro fieldsGettersSetters}
  static const Group fieldsGettersSetters =
      FieldsGettersSetters.fieldsGettersSetters;

  /// {@macro getters}
  static const Group getters = Getters.getters;

  /// {@macro gettersSetters}
  static const Group gettersSetters = GettersSetters.gettersSetters;

  /// {@macro methods}
  static const Group methods = Methods.methods;

  /// {@macro setters}
  static const Group setters = Setters.setters;
}

/// {@template constructors}
/// Represents all constructors.
/// {@endtemplate}
final class Constructors extends Group implements ConstantConstructors {
  /// {@macro constructors}
  const Constructors();

  /// {@macro constructors}
  static const Constructors constructors = .new();
}

/// {@template gettersSetters}
/// Represents all getters and setters
/// {@endtemplate}
final class GettersSetters extends Group
    implements FieldsMethodsGettersSetters {
  /// {@macro gettersSetters}
  const GettersSetters();

  /// {@macro gettersSetters}
  static const GettersSetters gettersSetters = .new();

  /// {@macro getters}
  static const GettersSetters getters = Getters.getters;

  /// {@macro setters}
  static const GettersSetters setters = Setters.setters;
}

/// {@template fieldsGettersSetters}
/// Represents all fields, getters, and setters.
/// {@endtemplate}
final class FieldsGettersSetters extends Group
    implements GettersSetters, FieldsMethodsGettersSetters {
  /// {@macro fieldsGettersSetters}
  const FieldsGettersSetters();

  /// {@macro fields}
  static const FieldsGettersSetters fields = Fields.fields;

  /// {@macro fieldsGettersSetters}
  static const FieldsGettersSetters fieldsGettersSetters = .new();

  /// {@macro getters}
  static const FieldsGettersSetters getters = Getters.getters;

  /// {@macro setters}
  static const FieldsGettersSetters setters = Setters.setters;
}

/// Groups fields and methods.
sealed class FieldsMethods extends Group implements Abstractable {
  const FieldsMethods();

  /// {@macro fields}
  static const FieldsMethods fields = Fields.fields;

  /// {@macro methods}
  static const FieldsMethods methods = Methods.methods;
}

/// Groups fields, methods, getters, and setters.
sealed class FieldsMethodsGettersSetters extends Group
    implements
        ExternalInstanceModifiable,
        NullableModifiable,
        PrivateModifiable,
        PublicModifiable {
  const FieldsMethodsGettersSetters();

  /// {@macro fieldsGettersSetters}
  static const FieldsMethodsGettersSetters fieldsGettersSetters =
      FieldsGettersSetters.fieldsGettersSetters;

  /// {@macro fields}
  static const FieldsMethodsGettersSetters fields = Fields.fields;

  /// {@macro getters}
  static const FieldsMethodsGettersSetters getters = Getters.getters;

  /// {@macro gettersSetters}
  static const FieldsMethodsGettersSetters gettersSetters =
      GettersSetters.gettersSetters;

  /// {@macro methods}
  static const FieldsMethodsGettersSetters methods = Methods.methods;

  /// {@macro setters}
  static const FieldsMethodsGettersSetters setters = Setters.setters;
}

/// {@template fields}
/// Represents all fields
/// {@endtemplate}
final class Fields extends Group
    implements
        FieldsMethodsGettersSetters,
        FieldsMethods,
        FieldsGettersSetters,
        Variable,
        ConstantVariables,
        FinalModifiable,
        Initializable {
  /// {@macro fields}
  const Fields();

  /// {@macro fields}
  static const Fields fields = .new();
}

/// {@template methods}
/// Represents all methods.
/// {@endtemplate}
final class Methods extends Group
    implements FieldsMethodsGettersSetters, FieldsMethods, OperatorModifiable {
  /// {@macro methods}
  const Methods();

  /// {@macro methods}
  static const Methods methods = .new();
}

/// {@template getters}
/// Represents all getters.
/// {@endtemplate}
final class Getters extends Group
    implements
        FieldsMethodsGettersSetters,
        FieldsGettersSetters,
        GettersSetters {
  /// {@macro getters}
  const Getters();

  /// {@macro getters}
  static const Getters getters = .new();
}

/// {@template setters}
/// Represents all setters.
/// {@endtemplate}
final class Setters extends Group
    implements
        FieldsMethodsGettersSetters,
        FieldsGettersSetters,
        GettersSetters {
  /// {@macro setters}
  const Setters();

  /// {@macro setters}
  static const Setters setters = .new();
}
