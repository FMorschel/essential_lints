part of 'sort_declarations.dart';

/// Represents final members.
@_gettersInMemberList
sealed class PublicModifiable extends StaticalContext {
  const PublicModifiable._() : super._();

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
  static List<PublicModifiable> get _members => [
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
sealed class PublicConstantModifiable extends PublicModifiable {
  const PublicConstantModifiable._() : super._();

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  /// {@macro constructors}
  static const Constructors constructors = Constructors._constructors;

  // ignore: unused_element member list
  static List<PublicConstantModifiable> get _members => [constructors, fields];
}

/// Represents public field members.
@_gettersInMemberList
sealed class PublicFieldModifiable extends PublicModifiable {
  const PublicFieldModifiable._() : super._();

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<PublicFieldModifiable> get _members => [fields];
}

/// Represents public statical members.
@_gettersInMemberList
sealed class PublicStaticalModifiable extends PublicModifiable
    implements Statical {
  const PublicStaticalModifiable._() : super._();

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
  static List<PublicStaticalModifiable> get _members => [
    fields,
    fieldsGettersSetters,
    getters,
    gettersSetters,
    setters,
    methods,
  ];
}

/// Represents public constructors.
@_gettersInMemberList
sealed class PublicConstructorModifiable extends PublicModifiable {
  const PublicConstructorModifiable._() : super._();

  /// {@macro constructors}
  static const Constructors constructors = Constructors._constructors;

  // ignore: unused_element member list
  static List<PublicConstructorModifiable> get _members => [constructors];
}

/// {@template public}
/// Represents public members.
/// {@endtemplate}
@InvalidModifiers({
  th<Private>(),
  th<Operator>(),
  th<Public>(),
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
final class Public<M extends PublicModifiable> extends Modifier<M>
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
        InstanciableExternal,
        OverridableExternal,
        FactoryExternalModifiable,
        NewExternalModifiable {
  /// {@macro public}
  const Public._(super.modifiable) : super._();
}
