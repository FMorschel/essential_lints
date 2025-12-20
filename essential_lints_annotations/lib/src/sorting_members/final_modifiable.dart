part of 'sort_declarations.dart';

/// Represents final members.
@_gettersInMemberList
sealed class FinalModifiable extends StaticalContext
    implements
        LateModifiable,
        Statical,
        ExternalModifiable,
        NewMemberModifiable {
  /// {@macro initialized}
  const factory FinalModifiable.initialized(
    InitializableStatical modifiable,
  ) = Initialized._;

  /// {@macro public}
  const factory FinalModifiable.public(
    PublicFieldModifiable modifiable,
  ) = Public._;

  /// {@macro private}
  const factory FinalModifiable.private(
    PrivateFieldModifiable modifiable,
  ) = Private._;

  /// {@macro nullable}
  const factory FinalModifiable.nullable(
    NullableFieldModifiable modifiable,
  ) = Nullable._;

  /// {@macro typed}
  const factory FinalModifiable.typed(TypedFieldModifiable modifiable) =
      Typed._;

  /// {@macro dynamic}
  const factory FinalModifiable.dynamic(DynamicFieldModifiable modifiable) =
      Dynamic._;

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
  ) = Public._;

  /// {@macro private}
  const factory FinalAbstractModifiable.private(
    PrivateFieldModifiable modifiable,
  ) = Private._;

  /// {@macro nullable}
  const factory FinalAbstractModifiable.nullable(
    NullableAbstractableFieldModifiable modifiable,
  ) = Nullable._;

  /// {@macro typed}
  const factory FinalAbstractModifiable.typed(
    TypedAbstractableFieldModifiable modifiable,
  ) = Typed._;

  /// {@macro dynamic}
  const factory FinalAbstractModifiable.dynamic(
    DynamicAbstractableFieldModifiable modifiable,
  ) = Dynamic._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<FinalAbstractModifiable> get _members => [fields];
}

/// {@template final}
/// Represents final members.
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
  th<Var>(),
  th<Final>(),
  th<Late>(),
  th<Abstract>(),
  th<External>(),
  th<Overridden>(),
  th<Static>(),
})
@MutuallyExclusive(#finality)
final class Final<M extends FinalModifiable> extends Modifier<M>
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
  /// {@macro final}
  const Final._(super.modifiable) : super._();
}
