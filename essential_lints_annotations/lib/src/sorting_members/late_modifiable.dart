part of 'sort_declarations.dart';

/// {@template late_modifiable}
/// Represents late modifiable members.
/// {@endtemplate}
@_gettersInMemberList
/*sealed*/ abstract class LateModifiable extends _StaticalContext
    implements Statical, NewMemberModifiable {
  /// {@macro var}
  const factory LateModifiable.var_(Variable modifiable) = _Var._;

  /// {@macro final}
  const factory LateModifiable.final_(FinalModifiable modifiable) = _Final._;

  /// {@macro public}
  const factory LateModifiable.public(PublicFieldModifiable modifiable) =
      _Public._;

  /// {@macro private}
  const factory LateModifiable.private(PrivateFieldModifiable modifiable) =
      _Private._;

  /// {@macro nullable}
  const factory LateModifiable.nullable(NullableFieldModifiable modifiable) =
      _Nullable._;

  /// {@macro typed}
  const factory LateModifiable.typed(TypedFieldModifiable modifiable) =
      _Typed._;

  /// {@macro dynamic}
  const factory LateModifiable.dynamic(DynamicFieldModifiable modifiable) =
      _Dynamic._;

  /// {@macro initialized}
  const factory LateModifiable.initialized(InitializableStatical modifiable) =
      _Initialized._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<LateModifiable> get _members => [fields];
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
  th<_Const>(),
  th<_Late>(),
  th<_Overridden>(),
  th<_Static>(),
})
/*final*/ class _Late<M extends LateModifiable> extends Modifier<M>
    implements
        Statical,
        NewMemberModifiable,
        InstantiableMembers,
        OverridableMembers {
  const _Late._(super.modifiable) : super._();
}
