part of 'sort_declarations.dart';

/// Represents constant members.
@_gettersInMemberList
/*sealed*/ abstract class Constant extends _StaticalContext {
  /// {@macro named}
  const factory Constant.named(NamedModifiable modifiable) = _Named._;

  /// {@macro unnamed}
  const factory Constant.unnamed(UnnamedModifiable modifiable) = _Unnamed._;

  /// {@macro public}
  const factory Constant.public(PublicConstantModifiable modifiable) =
      _Public._;

  /// {@macro private}
  const factory Constant.private(PrivateConstantModifiable modifiable) =
      _Private._;

  /// {@macro factory}
  const factory Constant.factory_(FactoryConstructorModifiable modifiable) =
      _Factory._;

  /// {@macro initialized}
  const factory Constant.initialized(InitializableStatical modifiable) =
      _Initialized._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  /// {@macro constructors}
  static const Constructors constructors = Constructors._constructors;

  // ignore: unused_element member list
  static List<Constant> get _members => [fields, constructors];
}

/// Represents constant fields.
@_gettersInMemberList
/*sealed*/ abstract class ConstantVariables extends Constant
    implements
        LateModifiable,
        Statical,
        Abstractable,
        _ExternalModifiable,
        NewMemberModifiable {
  /// {@macro initialized}
  const factory ConstantVariables.initialized(
    InitializableStatical modifiable,
  ) = _Initialized._;

  /// {@macro public}
  const factory ConstantVariables.public(PublicFieldModifiable modifiable) =
      _Public._;

  /// {@macro private}
  const factory ConstantVariables.private(PrivateFieldModifiable modifiable) =
      _Private._;

  /// {@macro nullable}
  const factory ConstantVariables.nullable(
    NullableFieldModifiable modifiable,
  ) = _Nullable._;

  /// {@macro typed}
  const factory ConstantVariables.typed(TypedFieldModifiable modifiable) =
      _Typed._;

  /// {@macro dynamic}
  const factory ConstantVariables.dynamic(
    DynamicFieldModifiable modifiable,
  ) = _Dynamic._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<ConstantVariables> get _members => [fields];
}

@InvalidMembers({
  th<Getters>(),
  th<Setters>(),
  th<GettersSetters>(),
  th<FieldsGettersSetters>(),
  th<Methods>(),
})
@InvalidModifiers({
  th<_Final>(),
  th<_Late>(),
  th<_Var>(),
  th<_Const>(),
  th<_Abstract>(),
  th<_External>(),
  th<_Overridden>(),
})
@MutuallyExclusive(#finality, optional: true)
/*final*/ class _Const<M extends Constant> extends Modifier<M>
    implements Statical {
  const _Const._(super.modifiable) : super._();
}
