part of 'sort_declarations.dart';

/// {@template late_modifiable}
/// Represents late modifiable members.
/// {@endtemplate}
@_gettersInMemberList
sealed class LateModifiable extends StaticalContext
    implements Statical, NewMemberModifiable {
  /// {@macro var}
  const factory LateModifiable.var_(Variable modifiable) = Var._;

  /// {@macro final}
  const factory LateModifiable.final_(FinalModifiable modifiable) = Final._;

  /// {@macro public}
  const factory LateModifiable.public(PublicFieldModifiable modifiable) =
      Public._;

  /// {@macro private}
  const factory LateModifiable.private(PrivateFieldModifiable modifiable) =
      Private._;

  /// {@macro nullable}
  const factory LateModifiable.nullable(NullableFieldModifiable modifiable) =
      Nullable._;

  /// {@macro typed}
  const factory LateModifiable.typed(TypedFieldModifiable modifiable) = Typed._;

  /// {@macro dynamic}
  const factory LateModifiable.dynamic(DynamicFieldModifiable modifiable) =
      Dynamic._;

  /// {@macro initialized}
  const factory LateModifiable.initialized(InitializableStatical modifiable) =
      Initialized._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<LateModifiable> get _members => [fields];
}

/// {@template late}
/// Represents late members.
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
  th<Abstract>(),
  th<External>(),
  th<Const>(),
  th<Late>(),
  th<Overridden>(),
  th<Static>(),
})
final class Late<M extends LateModifiable> extends Modifier<M>
    implements
        Statical,
        NewMemberModifiable,
        InstanciableMembers,
        OverridableMembers {
  /// {@macro late}
  const Late._(super.modifiable) : super._();
}
