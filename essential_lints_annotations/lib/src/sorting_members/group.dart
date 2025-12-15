part of 'sort_declarations.dart';

/// Groups of members.
sealed class Group extends Modifiable implements ExternalMembersModifiable {
  const Group._() : super._();
}

/// {@template constructors}
/// Represents all constructors.
/// {@endtemplate}
final class Constructors extends Group
    implements
        Constant,
        FactoryModifiable,
        NamedModifiable,
        RedirectingModifiable,
        PrivateConstructorModifiable,
        PublicConstructorModifiable,
        UnnamedModifiable,
        PublicConstantModifiable,
        PrivateConstantModifiable {
  /// {@macro constructors}
  const Constructors._() : super._();

  /// {@macro constructors}
  static const Constructors _constructors = ._();
}

/// {@template gettersSetters}
/// Represents all getters and setters
/// {@endtemplate}
final class GettersSetters extends Group
    implements FieldsMethodsGettersSetters, Abstractable {
  /// {@macro gettersSetters}
  const GettersSetters._() : super._();

  /// {@macro gettersSetters}
  static const GettersSetters _gettersSetters = ._();
}

/// {@template fieldsGettersSetters}
/// Represents all fields, getters, and setters.
/// {@endtemplate}
final class FieldsGettersSetters extends Group
    implements GettersSetters, FieldsMethodsGettersSetters {
  /// {@macro fieldsGettersSetters}
  const FieldsGettersSetters._() : super._();

  /// {@macro fieldsGettersSetters}
  static const FieldsGettersSetters _fieldsGettersSetters = ._();
}

/// Groups fields and methods.
sealed class FieldsMethods extends Group implements Abstractable {
  const FieldsMethods._() : super._();
}

/// Groups fields, methods, getters, and setters.
sealed class FieldsMethodsGettersSetters extends Group
    implements
        ExternalInstanceModifiable,
        NullableMembersModifiable,
        PrivateModifiable,
        PublicModifiable,
        PrivateStaticalModifiable,
        PublicStaticalModifiable,
        StaticalExternal,
        NullableExternableModifiable,
        PublicConstantModifiable {
  const FieldsMethodsGettersSetters._() : super._();
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
        InitializableOverridable,
        InitializableStatical,
        NullableFieldModifiable,
        PublicFieldModifiable,
        PrivateFieldModifiable,
        VariableAbstractable,
        FinalAbstractModifiable,
        NullableAbstractableFieldModifiable,
        PrivateConstantModifiable {
  /// {@macro fields}
  const Fields._() : super._();

  /// {@macro fields}
  static const Fields _fields = ._();
}

/// {@template methods}
/// Represents all methods.
/// {@endtemplate}
final class Methods extends Group
    implements
        FieldsMethodsGettersSetters,
        FieldsMethods,
        OperatorModifiable,
        NullableOperatorModifiable {
  /// {@macro methods}
  const Methods._() : super._();

  /// {@macro methods}
  static const Methods _methods = ._();
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
  const Getters._() : super._();

  /// {@macro getters}
  static const Getters _getters = ._();
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
  const Setters._() : super._();

  /// {@macro setters}
  static const Setters _setters = ._();
}
