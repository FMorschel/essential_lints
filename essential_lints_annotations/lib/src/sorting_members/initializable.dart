part of 'sort_declarations.dart';

/// {@template initializable}
/// Represents members that can be initialized with a value.
/// {@endtemplate}
///
/// Groups initializable members.
@_gettersInMemberList
sealed class _Initializable extends _StaticalContext {
  const _Initializable._() : super._();

  // ignore: unused_element member list
  static List<_Initializable> get _members => [];
}

/// Groups initializable overridable members.
@_gettersInMemberList
sealed class InitializableOverridable extends _Initializable
    implements NewMemberModifiable {
  /// {@macro private}
  const factory InitializableOverridable.private(
    PrivateFieldModifiable modifiable,
  ) = _Private._;

  /// {@macro public}
  const factory InitializableOverridable.public(
    PublicFieldModifiable modifiable,
  ) = _Public._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<InitializableOverridable> get _members => [fields];
}

/// Groups initializable static members.
@_gettersInMemberList
sealed class InitializableStatical extends _Initializable implements Statical {
  /// {@macro public}
  const factory InitializableStatical.public(PublicFieldModifiable modifiable) =
      _Public._;

  /// {@macro private}
  const factory InitializableStatical.private(
    PrivateFieldModifiable modifiable,
  ) = _Private._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<InitializableStatical> get _members => [fields];
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
  th<_Abstract>(),
  th<_External>(),
  th<_Initialized>(),
  th<_Late>(),
  th<_Overridden>(),
  th<_Static>(),
})
final class _Initialized<M extends _Initializable> extends Modifier<M>
    implements
        Statical,
        NewMemberModifiable,
        NullableMembersModifiable,
        FinalModifiable,
        Variable,
        ConstantVariables,
        NullableFieldModifiable,
        TypedFieldModifiable,
        TypedMembersModifiable,
        DynamicFieldModifiable,
        DynamicMembersModifiable,
        InstantiableMembers,
        OverridableMembers {
  const _Initialized._(super.modifiable) : super._();
}
