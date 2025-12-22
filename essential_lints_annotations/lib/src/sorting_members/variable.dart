part of 'sort_declarations.dart';

/// {@template variable}
/// Represents variable members.
/// {@endtemplate}
@_gettersInMemberList
sealed class Variable extends _StaticalContext
    implements
        LateModifiable,
        Statical,
        Abstractable,
        _ExternalModifiable,
        NewMemberModifiable {
  /// {@macro public}
  const factory Variable.public(PublicFieldModifiable modifiable) = _Public._;

  /// {@macro private}
  const factory Variable.private(PrivateFieldModifiable modifiable) =
      _Private._;

  /// {@macro initialized}
  const factory Variable.initialized(
    InitializableStatical modifiable,
  ) = _Initialized._;

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
  ) = _Public._;

  /// {@macro private}
  const factory VariableAbstractable.private(
    PrivateFieldModifiable modifiable,
  ) = _Private._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<VariableAbstractable> get _members => [fields];
}

@InvalidMembers({
  th<Constructors>(),
  th<Getters>(),
  th<Setters>(),
  th<GettersSetters>(),
  th<FieldsGettersSetters>(),
  th<Methods>(),
})
@InvalidModifiers({
  th<_Const>(),
  th<_Final>(),
  th<_Late>(),
  th<_Abstract>(),
  th<_External>(),
  th<_Overridden>(),
  th<_Static>(),
  th<_Var>(),
})
@MutuallyExclusive(#finality)
final class _Var<M extends Variable> extends Modifier<M>
    implements
        ExternalMembersModifiable,
        Abstractable,
        LateModifiable,
        StaticalExternal,
        InstantiableMembers,
        OverridableMembers,
        OverridableExternal,
        InstantiableExternal,
        NewExternalModifiable {
  const _Var._(super.modifiable) : super._();
}
