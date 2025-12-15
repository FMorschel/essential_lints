part of 'sort_declarations.dart';

/// Represents private members.
sealed class PrivateModifiable extends Modifiable {
  const PrivateModifiable._() : super._();

  /// {@macro fields}
  static const PrivateModifiable fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  static const PrivateModifiable fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  static const PrivateModifiable getters = Getters._getters;

  /// {@macro gettersSetters}
  static const PrivateModifiable gettersSetters =
      GettersSetters._gettersSetters;

  /// {@macro methods}
  static const PrivateModifiable methods = Methods._methods;

  /// {@macro setters}
  static const PrivateModifiable setters = Setters._setters;

  /// {@macro constructors}
  static const PrivateConstructorModifiable constructors =
      Constructors._constructors;
}

/// Represents public constant members.
sealed class PrivateConstantModifiable extends PrivateModifiable {
  const PrivateConstantModifiable._() : super._();

  /// {@macro fields}
  static const PrivateConstantModifiable fields = Fields._fields;

  /// {@macro constructors}
  static const PrivateConstantModifiable constructors =
      Constructors._constructors;
}

/// Represents private field members.
sealed class PrivateFieldModifiable extends PrivateModifiable {
  const PrivateFieldModifiable._() : super._();

  /// {@macro fields}
  static const PrivateFieldModifiable fields = Fields._fields;
}

/// Represents private statical members.
sealed class PrivateStaticalModifiable extends PrivateModifiable
    implements Statical {
  const PrivateStaticalModifiable._() : super._();

  /// {@macro fields}
  static const PrivateStaticalModifiable fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  static const PrivateStaticalModifiable fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  static const PrivateStaticalModifiable getters = Getters._getters;

  /// {@macro gettersSetters}
  static const PrivateStaticalModifiable gettersSetters =
      GettersSetters._gettersSetters;

  /// {@macro methods}
  static const PrivateStaticalModifiable methods = Methods._methods;

  /// {@macro setters}
  static const PrivateStaticalModifiable setters = Setters._setters;
}

/// Represents private constructors.
sealed class PrivateConstructorModifiable extends PrivateModifiable {
  const PrivateConstructorModifiable._() : super._();

  /// {@macro constructors}
  static const PrivateConstructorModifiable constructors =
      Constructors._constructors;
}

/// {@template private}
/// Represents private members.
/// {@endtemplate}
@InvalidModifiers([
  th<Public>(),
  th<Operator>(),
  th<Private>(),
  th<Factory>(),
  th<Const>(),
  th<External>(),
  th<Unnamed>(),
  th<Named>(),
  th<Late>(),
  th<Final>(),
  th<Var>(),
  th<Nullable>(),
  th<Overridden>(),
  th<Static>(),
  th<Abstract>(),
  th<Initialized>(),
  th<Redirecting>(),
])
final class Private<M extends PrivateModifiable> extends Modifier<M>
    implements
        NamedModifiable,
        RedirectingModifiable,
        FactoryModifiable,
        ExternalMembersModifiable,
        InitializableStatical,
        NullableMembersModifiable,
        FinalModifiable,
        InitializableOverridable,
        ConstantVariables,
        ExternalInstanceModifiable,
        NullableFieldModifiable,
        VariableAbstractable,
        FinalAbstractModifiable,
        NullableAbstractableFieldModifiable,
        StaticalExternal,
        NullableExternableModifiable {
  /// {@macro private}
  const Private._(super.modifiable) : super._();
}
