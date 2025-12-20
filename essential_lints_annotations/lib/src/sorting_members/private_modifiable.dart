part of 'sort_declarations.dart';

/// Represents private members.
@_gettersInMemberList
sealed class PrivateModifiable extends StaticalContext {
  const PrivateModifiable._() : super._();

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  static const FieldsGettersSetters fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  static const Getters getters = Getters._getters;

  /// {@macro gettersSetters}
  static const GettersSetters gettersSetters = GettersSetters._gettersSetters;

  /// {@macro methods}
  static const Methods methods = Methods._methods;

  /// {@macro setters}
  static const Setters setters = Setters._setters;

  /// {@macro constructors}
  static const Constructors constructors = Constructors._constructors;

  // ignore: unused_element member list
  static List<PrivateModifiable> get _members => [
    constructors,
    fields,
    fieldsGettersSetters,
    getters,
    gettersSetters,
    setters,
    methods,
  ];
}

/// Represents public constant members.
@_gettersInMemberList
sealed class PrivateConstantModifiable extends PrivateModifiable {
  const PrivateConstantModifiable._() : super._();

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  /// {@macro constructors}
  static const Constructors constructors = Constructors._constructors;

  // ignore: unused_element member list
  static List<PrivateConstantModifiable> get _members => [constructors, fields];
}

/// Represents private field members.
@_gettersInMemberList
sealed class PrivateFieldModifiable extends PrivateModifiable {
  const PrivateFieldModifiable._() : super._();

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<PrivateFieldModifiable> get _members => [fields];
}

/// Represents private statical members.
@_gettersInMemberList
sealed class PrivateStaticalModifiable extends PrivateModifiable
    implements Statical {
  const PrivateStaticalModifiable._() : super._();

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  static const FieldsGettersSetters fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  static const Getters getters = Getters._getters;

  /// {@macro gettersSetters}
  static const GettersSetters gettersSetters = GettersSetters._gettersSetters;

  /// {@macro methods}
  static const Methods methods = Methods._methods;

  /// {@macro setters}
  static const Setters setters = Setters._setters;

  // ignore: unused_element member list
  static List<PrivateStaticalModifiable> get _members => [
    fields,
    fieldsGettersSetters,
    getters,
    gettersSetters,
    setters,
    methods,
  ];
}

/// Represents private constructors.
@_gettersInMemberList
sealed class PrivateConstructorModifiable extends PrivateModifiable {
  const PrivateConstructorModifiable._() : super._();

  /// {@macro constructors}
  static const Constructors constructors = Constructors._constructors;

  // ignore: unused_element member list
  static List<PrivateConstructorModifiable> get _members => [constructors];
}

/// {@template private}
/// Represents private members.
/// {@endtemplate}
@InvalidModifiers({
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
})
@InvalidMembers(<TypeHolder<Group>>{})
@MutuallyExclusive(#visibility)
final class Private<M extends PrivateModifiable> extends Modifier<M>
    implements
        NamedModifiable,
        RedirectingModifiable,
        FactoryConstructorModifiable,
        ExternalMembersModifiable,
        InitializableStatical,
        NullableMembersModifiable,
        FinalModifiable,
        InitializableOverridable,
        ConstantVariables,
        NullableFieldModifiable,
        VariableAbstractable,
        FinalAbstractModifiable,
        NullableAbstractableFieldModifiable,
        StaticalExternal,
        NullableExternableModifiable,
        TypedFieldModifiable,
        TypedAbstractableFieldModifiable,
        TypedExternableModifiable,
        TypedMembersModifiable,
        DynamicFieldModifiable,
        DynamicAbstractableFieldModifiable,
        DynamicExternableModifiable,
        DynamicMembersModifiable,
        InstanciableMembers,
        OverridableMembers,
        OverridableExternal,
        InstanciableExternal,
        FactoryExternalModifiable,
        NewExternalModifiable {
  /// {@macro private}
  const Private._(super.modifiable) : super._();
}
