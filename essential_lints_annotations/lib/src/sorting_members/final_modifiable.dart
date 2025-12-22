part of 'sort_declarations.dart';

/// Represents final members.
@_gettersInMemberList
sealed class FinalModifiable extends _StaticalContext
    implements
        LateModifiable,
        Statical,
        _ExternalModifiable,
        NewMemberModifiable {
  /// {@macro initialized}
  const factory FinalModifiable.initialized(
    InitializableStatical modifiable,
  ) = _Initialized._;

  /// {@macro public}
  const factory FinalModifiable.public(
    PublicFieldModifiable modifiable,
  ) = _Public._;

  /// {@macro private}
  const factory FinalModifiable.private(
    PrivateFieldModifiable modifiable,
  ) = _Private._;

  /// {@macro nullable}
  const factory FinalModifiable.nullable(
    NullableFieldModifiable modifiable,
  ) = _Nullable._;

  /// {@macro typed}
  const factory FinalModifiable.typed(TypedFieldModifiable modifiable) =
      _Typed._;

  /// {@macro dynamic}
  const factory FinalModifiable.dynamic(DynamicFieldModifiable modifiable) =
      _Dynamic._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<FinalModifiable> get _members => [fields];
}

/// Represents final members that are also abstractable.
@_gettersInMemberList
sealed class FinalAbstractModifiable extends FinalModifiable
    implements Abstractable {
  /// {@macro public}
  const factory FinalAbstractModifiable.public(
    PublicFieldModifiable modifiable,
  ) = _Public._;

  /// {@macro private}
  const factory FinalAbstractModifiable.private(
    PrivateFieldModifiable modifiable,
  ) = _Private._;

  /// {@macro nullable}
  const factory FinalAbstractModifiable.nullable(
    NullableAbstractableFieldModifiable modifiable,
  ) = _Nullable._;

  /// {@macro typed}
  const factory FinalAbstractModifiable.typed(
    TypedAbstractableFieldModifiable modifiable,
  ) = _Typed._;

  /// {@macro dynamic}
  const factory FinalAbstractModifiable.dynamic(
    DynamicAbstractableFieldModifiable modifiable,
  ) = _Dynamic._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<FinalAbstractModifiable> get _members => [fields];
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
  th<_Var>(),
  th<_Final>(),
  th<_Late>(),
  th<_Abstract>(),
  th<_External>(),
  th<_Overridden>(),
  th<_Static>(),
})
@MutuallyExclusive(#finality)
final class _Final<M extends FinalModifiable> extends Modifier<M>
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
  const _Final._(super.modifiable) : super._();
}
