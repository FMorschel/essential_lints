part of 'sort_declarations.dart';

/// Represents final members.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class PublicModifiable extends StaticalContext {
  const PublicModifiable._() : super._();

  /// {@macro fields}
  @Consider<Fields>()
  static const PublicModifiable fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  @Consider<FieldsGettersSetters>()
  static const PublicModifiable fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  @Consider<Getters>()
  static const PublicModifiable getters = Getters._getters;

  /// {@macro gettersSetters}
  @Consider<GettersSetters>()
  static const PublicModifiable gettersSetters = GettersSetters._gettersSetters;

  /// {@macro methods}
  @Consider<Methods>()
  static const PublicModifiable methods = Methods._methods;

  /// {@macro setters}
  @Consider<Setters>()
  static const PublicModifiable setters = Setters._setters;

  /// {@macro constructors}
  @Consider<Constructors>()
  static const PublicConstructorModifiable constructors =
      Constructors._constructors;
}

/// Represents public constant members.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class PublicConstantModifiable extends PublicModifiable {
  const PublicConstantModifiable._() : super._();

  /// {@macro fields}
  @Consider<Fields>()
  static const PublicConstantModifiable fields = Fields._fields;

  /// {@macro constructors}
  @Consider<Constructors>()
  static const PublicConstantModifiable constructors =
      Constructors._constructors;
}

/// Represents public field members.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class PublicFieldModifiable extends PublicModifiable {
  const PublicFieldModifiable._() : super._();

  /// {@macro fields}
  @Consider<Fields>()
  static const PublicFieldModifiable fields = Fields._fields;
}

/// Represents public statical members.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class PublicStaticalModifiable extends PublicModifiable
    implements Statical {
  const PublicStaticalModifiable._() : super._();

  /// {@macro fields}
  @Consider<Fields>()
  static const PublicStaticalModifiable fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  @Consider<FieldsGettersSetters>()
  static const PublicStaticalModifiable fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  @Consider<Getters>()
  static const PublicStaticalModifiable getters = Getters._getters;

  /// {@macro gettersSetters}
  @Consider<GettersSetters>()
  static const PublicStaticalModifiable gettersSetters =
      GettersSetters._gettersSetters;

  /// {@macro methods}
  @Consider<Methods>()
  static const PublicStaticalModifiable methods = Methods._methods;

  /// {@macro setters}
  @Consider<Setters>()
  static const PublicStaticalModifiable setters = Setters._setters;
}

/// Represents public constructors.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class PublicConstructorModifiable extends PublicModifiable {
  const PublicConstructorModifiable._() : super._();

  /// {@macro constructors}
  @Consider<Constructors>()
  static const PublicConstructorModifiable constructors =
      Constructors._constructors;
}

/// {@template public}
/// Represents public members.
/// {@endtemplate}
@InvalidModifiers([
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
])
@InvalidMembers(<TypeHolder<Group>>[])
final class Public<M extends PublicModifiable> extends Modifier<M>
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
  /// {@macro public}
  const Public._(super.modifiable) : super._();
}
