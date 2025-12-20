part of 'sort_declarations.dart';

/// Class representing typed sort declarations.
final class TypedModifiable extends StaticalContext {
  const TypedModifiable._() : super._();
}

/// Represents typed fields.
@_gettersInMemberList
sealed class TypedFieldModifiable extends TypedModifiable
    implements ConstantVariables {
  /// {@macro public}
  const factory TypedFieldModifiable.public(
    PublicFieldModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory TypedFieldModifiable.private(
    PrivateFieldModifiable modifiable,
  ) = Private._;

  /// {@macro initialized}
  const factory TypedFieldModifiable.initialized(
    InitializableStatical modifiable,
  ) = Initialized._;

  /// {@macro nullable}
  const factory TypedFieldModifiable.nullable(
    NullableFieldModifiable modifiable,
  ) = Nullable._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<TypedFieldModifiable> get _members => [fields];
}

/// Represents typed fields that are also abstractable.
@_gettersInMemberList
sealed class TypedAbstractableFieldModifiable extends TypedFieldModifiable
    implements Abstractable {
  /// {@macro public}
  const factory TypedAbstractableFieldModifiable.public(
    PublicFieldModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory TypedAbstractableFieldModifiable.private(
    PrivateFieldModifiable modifiable,
  ) = Private._;

  /// {@macro nullable}
  const factory TypedAbstractableFieldModifiable.nullable(
    NullableAbstractableFieldModifiable modifiable,
  ) = Nullable._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<TypedAbstractableFieldModifiable> get _members => [fields];
}

/// Represents typed externable members.
@_gettersInMemberList
sealed class TypedExternableModifiable extends TypedModifiable {
  /// {@macro public}
  const factory TypedExternableModifiable.public(
    PublicStaticalModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory TypedExternableModifiable.private(
    PrivateStaticalModifiable modifiable,
  ) = Private._;

  /// {@macro nullable}
  const factory TypedExternableModifiable.nullable(
    NullableExternableModifiable modifiable,
  ) = Nullable._;

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
  static List<TypedExternableModifiable> get _members => [
    fields,
    fieldsGettersSetters,
    getters,
    gettersSetters,
    setters,
    methods,
  ];
}

/// Represents all member that can be typed.
@_gettersInMemberList
sealed class TypedMembersModifiable extends TypedModifiable
    implements Statical {
  /// {@macro public}
  const factory TypedMembersModifiable.public(
    PublicStaticalModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory TypedMembersModifiable.private(
    PrivateStaticalModifiable modifiable,
  ) = Private._;

  /// {@macro initialized}
  const factory TypedMembersModifiable.initialized(
    InitializableStatical modifiable,
  ) = Initialized._;

  /// {@macro nullable}
  const factory TypedMembersModifiable.nullable(
    NullableMembersModifiable modifiable,
  ) = Nullable._;

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
  static List<TypedMembersModifiable> get _members => [
    fields,
    fieldsGettersSetters,
    getters,
    gettersSetters,
    setters,
    methods,
  ];
}

/// Represents typed operator members.
@_gettersInMemberList
sealed class TypedOperatorModifiable extends TypedModifiable {
  /// {@macro nullable}
  const factory TypedOperatorModifiable.nullable([
    NullableOperatorModifiable modifiable,
  ]) = Nullable._operator;

  /// {@macro methods}
  static const Methods methods = Methods._methods;

  // ignore: unused_element member list
  static List<TypedOperatorModifiable> get _members => [methods];
}

/// {@template typed}
/// Represents typed members.
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
  th<Typed>(),
})
@MutuallyExclusive(#typeAnnotation)
final class Typed extends Modifier<TypedModifiable>
    implements
        FinalModifiable,
        ExternalMembersModifiable,
        ConstantVariables,
        FinalAbstractModifiable,
        StaticalExternal,
        InstanciableMembers,
        OverridableMembers,
        OverridableExternal,
        InstanciableExternal,
        NewExternalModifiable {
  /// {@macro typed}
  const Typed._(super.modifiable) : super._();
  const Typed._operator([
    TypedOperatorModifiable super.modifiable = TypedOperatorModifiable.methods,
  ]) : super._();
}
