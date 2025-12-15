part of 'sort_declarations.dart';

/// {@template variable}
/// Represents variable members.
/// {@endtemplate}
sealed class Variable extends Modifiable
    implements
        LateModifiable,
        Statical,
        Abstractable,
        ExternalModifiable,
        Overridable {
  /// {@macro public}
  const factory Variable.public(PublicFieldModifiable modifiable) = Public._;

  /// {@macro private}
  const factory Variable.private(PrivateFieldModifiable modifiable) = Private._;

  /// {@macro initialized}
  const factory Variable.initialized(
    InitializableStatical modifiable,
  ) = Initialized._;

  /// {@macro fields}
  static const Variable fields = Fields._fields;
}

/// Represents variable members that are also abstractable.
sealed class VariableAbstractable extends Variable implements Abstractable {
  /// {@macro public}
  const factory VariableAbstractable.public(
    PublicFieldModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory VariableAbstractable.private(
    PrivateFieldModifiable modifiable,
  ) = Private._;

  /// {@macro fields}
  static const VariableAbstractable fields = Fields._fields;
}

/// {@template var}
/// Represents variable members.
/// {@endtemplate}
@InvalidMembers([
  th<Constructors>(),
  th<Getters>(),
  th<Setters>(),
  th<GettersSetters>(),
  th<FieldsGettersSetters>(),
  th<Methods>(),
])
@InvalidModifiers([
  th<Const>(),
  th<Final>(),
  th<Late>(),
  th<Abstract>(),
  th<External>(),
  th<Overridden>(),
  th<Static>(),
  th<Var>(),
])
final class Var<M extends Variable> extends Modifier<M>
    implements
        ExternalInstanceModifiable,
        ExternalMembersModifiable,
        Abstractable,
        InitializableOverridable,
        InitializableStatical,
        LateModifiable,
        StaticalExternal {
  /// {@macro var}
  const Var._(super.modifiable) : super._();
}
