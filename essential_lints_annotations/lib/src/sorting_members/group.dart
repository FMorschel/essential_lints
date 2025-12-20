part of 'sort_declarations.dart';

/// Groups of members.
final class Group extends StaticalContext implements ExternalMembersModifiable {
  const Group._() : super._();
}

/// {@template constructors}
/// Represents all constructors.
/// {@endtemplate}
final class Constructors extends Group
    implements
        Constant,
        FactoryConstructorModifiable,
        FactoryExternalModifiable,
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
@MemberGroup(#gettersSetters, participant: false)
final class GettersSetters extends Group
    implements Abstractable, Getters, Setters {
  /// {@macro gettersSetters}
  const GettersSetters._() : super._();

  /// {@macro gettersSetters}
  static const GettersSetters _gettersSetters = ._();
}

/// {@template fieldsGettersSetters}
/// Represents all fields, getters, and setters.
/// {@endtemplate}
@MemberGroup(#fieldsGettersSetters, participant: false)
final class FieldsGettersSetters extends Group
    implements Fields, Getters, Setters {
  /// {@macro fieldsGettersSetters}
  const FieldsGettersSetters._() : super._();

  /// {@macro fieldsGettersSetters}
  static const FieldsGettersSetters _fieldsGettersSetters = ._();
}

/// Groups fields and methods.
final class FieldsMethods extends Group
    implements Abstractable, Fields, Methods {
  const FieldsMethods._() : super._();
}

/// Groups fields, methods, getters, and setters.
final class FieldsMethodsGettersSetters extends Group
    implements Fields, Methods, Getters, Setters {
  const FieldsMethodsGettersSetters._() : super._();
}

/// {@template fields}
/// Represents all fields
/// {@endtemplate}
@MemberGroup(#fieldsGettersSetters)
final class Fields extends Group
    implements
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
        PrivateConstantModifiable,
        TypedAbstractableFieldModifiable,
        DynamicAbstractableFieldModifiable,
        _InstanciableMembers {
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
        OperatorModifiable,
        NullableOperatorModifiable,
        _InstanciableMembers,
        TypedOperatorModifiable,
        DynamicOperatorModifiable {
  /// {@macro methods}
  const Methods._() : super._();

  /// {@macro methods}
  static const Methods _methods = ._();
}

/// {@template getters}
/// Represents all getters.
/// {@endtemplate}
@MemberGroup(#gettersSetters)
@MemberGroup(#fieldsGettersSetters)
final class Getters extends Group implements _InstanciableMembers {
  /// {@macro getters}
  const Getters._() : super._();

  /// {@macro getters}
  static const Getters _getters = ._();
}

/// {@template setters}
/// Represents all setters.
/// {@endtemplate}
@MemberGroup(#gettersSetters)
@MemberGroup(#fieldsGettersSetters)
final class Setters extends Group implements _InstanciableMembers {
  /// {@macro setters}
  const Setters._() : super._();

  /// {@macro setters}
  static const Setters _setters = ._();
}

final class _InstanciableMembers extends Group
    implements
        NullableMembersModifiable,
        PrivateModifiable,
        PublicModifiable,
        PrivateStaticalModifiable,
        PublicStaticalModifiable,
        StaticalExternal,
        NullableExternableModifiable,
        PublicConstantModifiable,
        Abstractable,
        TypedMembersModifiable,
        TypedExternableModifiable,
        DynamicMembersModifiable,
        DynamicExternableModifiable,
        InstanciableMembers,
        InstanciableExternal,
        OverridableMembers,
        OverridableExternal,
        NewExternalModifiable {
  const _InstanciableMembers._() : super._();
}
