part of 'sort_declarations.dart';

/// Represents private members.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class PrivateModifiable extends StaticalContext {
  const PrivateModifiable._() : super._();

  /// {@macro fields}
  @Consider<Fields>()
  static const PrivateModifiable fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  @Consider<FieldsGettersSetters>()
  static const PrivateModifiable fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  @Consider<Getters>()
  static const PrivateModifiable getters = Getters._getters;

  /// {@macro gettersSetters}
  @Consider<GettersSetters>()
  static const PrivateModifiable gettersSetters =
      GettersSetters._gettersSetters;

  /// {@macro methods}
  @Consider<Methods>()
  static const PrivateModifiable methods = Methods._methods;

  /// {@macro setters}
  @Consider<Setters>()
  static const PrivateModifiable setters = Setters._setters;

  /// {@macro constructors}
  @Consider<Constructors>()
  static const PrivateConstructorModifiable constructors =
      Constructors._constructors;
}

/// Represents public constant members.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class PrivateConstantModifiable extends PrivateModifiable {
  const PrivateConstantModifiable._() : super._();

  /// {@macro fields}
  @Consider<Fields>()
  static const PrivateConstantModifiable fields = Fields._fields;

  /// {@macro constructors}
  @Consider<Constructors>()
  static const PrivateConstantModifiable constructors =
      Constructors._constructors;
}

/// Represents private field members.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class PrivateFieldModifiable extends PrivateModifiable {
  const PrivateFieldModifiable._() : super._();

  /// {@macro fields}
  @Consider<Fields>()
  static const PrivateFieldModifiable fields = Fields._fields;
}

/// Represents private statical members.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class PrivateStaticalModifiable extends PrivateModifiable
    implements Statical {
  const PrivateStaticalModifiable._() : super._();

  /// {@macro fields}
  @Consider<Fields>()
  static const PrivateStaticalModifiable fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  @Consider<FieldsGettersSetters>()
  static const PrivateStaticalModifiable fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  @Consider<Getters>()
  static const PrivateStaticalModifiable getters = Getters._getters;

  /// {@macro gettersSetters}
  @Consider<GettersSetters>()
  static const PrivateStaticalModifiable gettersSetters =
      GettersSetters._gettersSetters;

  /// {@macro methods}
  @Consider<Methods>()
  static const PrivateStaticalModifiable methods = Methods._methods;

  /// {@macro setters}
  @Consider<Setters>()
  static const PrivateStaticalModifiable setters = Setters._setters;
}

/// Represents private constructors.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class PrivateConstructorModifiable extends PrivateModifiable {
  const PrivateConstructorModifiable._() : super._();

  /// {@macro constructors}
  @Consider<Constructors>()
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
@InvalidMembers(<TypeHolder<Group>>[])
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
