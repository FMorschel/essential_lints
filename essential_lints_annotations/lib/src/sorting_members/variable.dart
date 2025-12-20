part of 'sort_declarations.dart';

/// {@template variable}
/// Represents variable members.
/// {@endtemplate}
@_gettersInMemberList
sealed class Variable extends StaticalContext
    implements
        LateModifiable,
        Statical,
        Abstractable,
        ExternalModifiable,
        NewMemberModifiable {
  /// {@macro public}
  const factory Variable.public(PublicFieldModifiable modifiable) = Public._;

  /// {@macro private}
  const factory Variable.private(PrivateFieldModifiable modifiable) = Private._;

  /// {@macro initialized}
  const factory Variable.initialized(
    InitializableStatical modifiable,
  ) = Initialized._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<Variable> get _members => [fields];
}

/// Represents variable members that are also abstractable.
@_gettersInMemberList
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
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<VariableAbstractable> get _members => [fields];
}

/// {@template var}
/// Represents variable members.
/// {@endtemplate}
@InvalidMembers({
  th<Constructors>(),
  th<Getters>(),
  th<Setters>(),
  th<GettersSetters>(),
  th<FieldsGettersSetters>(),
  th<Methods>(),
})
@InvalidModifiers({
  th<Const>(),
  th<Final>(),
  th<Late>(),
  th<Abstract>(),
  th<External>(),
  th<Overridden>(),
  th<Static>(),
  th<Var>(),
})
@MutuallyExclusive(#finality)
final class Var<M extends Variable> extends Modifier<M>
    implements
        ExternalMembersModifiable,
        Abstractable,
        LateModifiable,
        StaticalExternal,
        InstanciableMembers,
        OverridableMembers,
        OverridableExternal,
        InstanciableExternal,
        NewExternalModifiable {
  /// {@macro vari}
  const Var._(super.modifiable) : super._();
}
