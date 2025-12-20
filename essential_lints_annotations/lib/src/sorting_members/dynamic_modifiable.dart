part of 'sort_declarations.dart';

/// Class representing dynamic sort declarations.
final class DynamicModifiable extends StaticalContext {
  const DynamicModifiable._() : super._();
}

/// Represents dynamic fields.
@_gettersInMemberList
sealed class DynamicFieldModifiable extends DynamicModifiable
    implements ConstantVariables {
  /// {@macro public}
  const factory DynamicFieldModifiable.public(
    PublicFieldModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory DynamicFieldModifiable.private(
    PrivateFieldModifiable modifiable,
  ) = Private._;

  /// {@macro initialized}
  const factory DynamicFieldModifiable.initialized(
    InitializableStatical modifiable,
  ) = Initialized._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<DynamicFieldModifiable> get _members => [fields];
}

/// Represents dynamic fields that are also abstractable.
@_gettersInMemberList
sealed class DynamicAbstractableFieldModifiable extends DynamicFieldModifiable
    implements Abstractable {
  /// {@macro public}
  const factory DynamicAbstractableFieldModifiable.public(
    PublicFieldModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory DynamicAbstractableFieldModifiable.private(
    PrivateFieldModifiable modifiable,
  ) = Private._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<DynamicAbstractableFieldModifiable> get _members => [fields];
}

/// Represents dynamic externable members.
@_gettersInMemberList
sealed class DynamicExternableModifiable extends DynamicModifiable {
  /// {@macro public}
  const factory DynamicExternableModifiable.public(
    PublicStaticalModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory DynamicExternableModifiable.private(
    PrivateStaticalModifiable modifiable,
  ) = Private._;

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
sealed class DynamicMembersModifiable extends DynamicModifiable
    implements Statical {
  /// {@macro public}
  const factory DynamicMembersModifiable.public(
    PublicStaticalModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory DynamicMembersModifiable.private(
    PrivateStaticalModifiable modifiable,
  ) = Private._;

  /// {@macro initialized}
  const factory DynamicMembersModifiable.initialized(
    InitializableStatical modifiable,
  ) = Initialized._;

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
sealed class DynamicOperatorModifiable extends DynamicModifiable {
  const DynamicOperatorModifiable._() : super._();

  /// {@macro methods}
  static const Methods methods = Methods._methods;

  // ignore: unused_element member list
  static List<DynamicOperatorModifiable> get _members => [methods];
}

/// {@template dynamic}
/// Represents dynamic members.
/// {@endtemplate}
@InvalidMembers({th<Constructors>()})
@InvalidModifiers({
  th<Late>(),
  th<Abstract>(),
  th<External>(),
  th<Overridden>(),
  th<Static>(),
  th<Const>(),
  th<Var>(),
  th<Final>(),
  th<Nullable>(),
  th<Dynamic>(),
})
@MutuallyExclusive(#typeAnnotation)
final class Dynamic extends Modifier<DynamicModifiable>
    implements
        FinalModifiable,
        ExternalMembersModifiable,
        ConstantVariables,
        StaticalExternal,
        InstanciableMembers,
        OverridableMembers,
        OverridableExternal,
        InstanciableExternal,
        FinalAbstractModifiable,
        NewExternalModifiable {
  /// {@macro dynamic}
  const Dynamic._(super.modifiable) : super._();
  const Dynamic._operator([
    DynamicOperatorModifiable super.modifiable =
        DynamicOperatorModifiable.methods,
  ]) : super._();
}
