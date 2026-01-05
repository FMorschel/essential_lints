part of 'sort_declarations.dart';

/// Class representing dynamic sort declarations.
/*final*/ class _DynamicModifiable extends _StaticalContext {
  const _DynamicModifiable._() : super._();
}

/// Represents dynamic fields.
@_gettersInMemberList
/*sealed*/ abstract class DynamicFieldModifiable extends _DynamicModifiable
    implements ConstantVariables {
  /// {@macro public}
  const factory DynamicFieldModifiable.public(
    PublicFieldModifiable modifiable,
  ) = _Public._;

  /// {@macro private}
  const factory DynamicFieldModifiable.private(
    PrivateFieldModifiable modifiable,
  ) = _Private._;

  /// {@macro initialized}
  const factory DynamicFieldModifiable.initialized(
    InitializableStatical modifiable,
  ) = _Initialized._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<DynamicFieldModifiable> get _members => [fields];
}

/// Represents dynamic fields that are also abstractable.
@_gettersInMemberList
/*sealed*/ abstract class DynamicAbstractableFieldModifiable
    extends DynamicFieldModifiable implements Abstractable {
  /// {@macro public}
  const factory DynamicAbstractableFieldModifiable.public(
    PublicFieldModifiable modifiable,
  ) = _Public._;

  /// {@macro private}
  const factory DynamicAbstractableFieldModifiable.private(
    PrivateFieldModifiable modifiable,
  ) = _Private._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<DynamicAbstractableFieldModifiable> get _members => [fields];
}

/// Represents dynamic externable members.
@_gettersInMemberList
/*sealed*/ abstract class DynamicExternableModifiable
    extends _DynamicModifiable {
  /// {@macro public}
  const factory DynamicExternableModifiable.public(
    PublicStaticalModifiable modifiable,
  ) = _Public._;

  /// {@macro private}
  const factory DynamicExternableModifiable.private(
    PrivateStaticalModifiable modifiable,
  ) = _Private._;

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
  static List<DynamicExternableModifiable> get _members => [
        fields,
        fieldsGettersSetters,
        getters,
        gettersSetters,
        setters,
        methods,
      ];
}

/// Represents all member that can be dynamic.
@_gettersInMemberList
/*sealed*/ abstract class DynamicMembersModifiable extends _DynamicModifiable
    implements Statical {
  /// {@macro public}
  const factory DynamicMembersModifiable.public(
    PublicStaticalModifiable modifiable,
  ) = _Public._;

  /// {@macro private}
  const factory DynamicMembersModifiable.private(
    PrivateStaticalModifiable modifiable,
  ) = _Private._;

  /// {@macro initialized}
  const factory DynamicMembersModifiable.initialized(
    InitializableStatical modifiable,
  ) = _Initialized._;

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
  static List<DynamicMembersModifiable> get _members => [
        fields,
        fieldsGettersSetters,
        getters,
        gettersSetters,
        setters,
        methods,
      ];
}

/// Represents dynamic operator members.
@_gettersInMemberList
/*sealed*/ abstract class DynamicOperatorModifiable extends _DynamicModifiable {
  const DynamicOperatorModifiable._() : super._();

  /// {@macro methods}
  static const Methods methods = Methods._methods;

  // ignore: unused_element member list
  static List<DynamicOperatorModifiable> get _members => [methods];
}

@InvalidMembers({th<Constructors>()})
@InvalidModifiers({
  th<_Late>(),
  th<_Abstract>(),
  th<_External>(),
  th<_Overridden>(),
  th<_Static>(),
  th<_Const>(),
  th<_Var>(),
  th<_Final>(),
  th<_Nullable>(),
  th<_Dynamic>(),
})
@MutuallyExclusive(#typeAnnotation)
/*final*/ class _Dynamic extends Modifier<_DynamicModifiable>
    implements
        FinalModifiable,
        ExternalMembersModifiable,
        ConstantVariables,
        StaticalExternal,
        InstantiableMembers,
        OverridableMembers,
        OverridableExternal,
        InstantiableExternal,
        FinalAbstractModifiable,
        NewExternalModifiable {
  const _Dynamic._(super.modifiable) : super._();
  const _Dynamic._operator([
    DynamicOperatorModifiable super.modifiable =
        DynamicOperatorModifiable.methods,
  ]) : super._();
}
