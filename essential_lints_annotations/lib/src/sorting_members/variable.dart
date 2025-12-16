part of 'sort_declarations.dart';

/// {@template variable}
/// Represents variable members.
/// {@endtemplate}
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class Variable extends StaticalContext
    implements
        LateModifiable,
        Statical,
        Abstractable,
        ExternalModifiable,
        Overridable {
  /// {@macro public}
  @Consider<Public>()
  const factory Variable.public(PublicFieldModifiable modifiable) = Public._;

  /// {@macro private}
  @Consider<Private>()
  const factory Variable.private(PrivateFieldModifiable modifiable) = Private._;

  /// {@macro initialized}
  @Consider<Initialized>()
  const factory Variable.initialized(
    InitializableStatical modifiable,
  ) = Initialized._;

  /// {@macro fields}
  @Consider<Fields>()
  static const Variable fields = Fields._fields;
}

/// Represents variable members that are also abstractable.
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class VariableAbstractable extends Variable implements Abstractable {
  /// {@macro public}
  @Consider<Public>()
  const factory VariableAbstractable.public(
    PublicFieldModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  @Consider<Private>()
  const factory VariableAbstractable.private(
    PrivateFieldModifiable modifiable,
  ) = Private._;

  /// {@macro fields}
  @Consider<Fields>()
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
