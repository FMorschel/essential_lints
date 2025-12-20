part of 'sort_declarations.dart';

/// Represents constant members.
@_gettersInMemberList
sealed class Constant extends StaticalContext {
  /// {@macro named}
  const factory Constant.named(NamedModifiable modifiable) = Named._;

  /// {@macro unnamed}
  const factory Constant.unnamed(UnnamedModifiable modifiable) = Unnamed._;

  /// {@macro public}
  const factory Constant.public(PublicConstantModifiable modifiable) = Public._;

  /// {@macro private}
  const factory Constant.private(PrivateConstantModifiable modifiable) =
      Private._;

  /// {@macro factory}
  const factory Constant.factory_(FactoryConstructorModifiable modifiable) =
      Factory._;

  /// {@macro initialized}
  const factory Constant.initialized(InitializableStatical modifiable) =
      Initialized._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  /// {@macro constructors}
  static const Constructors constructors = Constructors._constructors;

  // ignore: unused_element member list
  static List<Constant> get _members => [fields, constructors];
}

/// Represents constant fields.
@_gettersInMemberList
sealed class ConstantVariables extends Constant
    implements
        LateModifiable,
        Statical,
        Abstractable,
        ExternalModifiable,
        NewMemberModifiable {
  /// {@macro initialized}
  const factory ConstantVariables.initialized(
    InitializableStatical modifiable,
  ) = Initialized._;

  /// {@macro public}
  const factory ConstantVariables.public(PublicFieldModifiable modifiable) =
      Public._;

  /// {@macro private}
  const factory ConstantVariables.private(PrivateFieldModifiable modifiable) =
      Private._;

  /// {@macro nullable}
  const factory ConstantVariables.nullable(
    NullableFieldModifiable modifiable,
  ) = Nullable._;

  /// {@macro typed}
  const factory ConstantVariables.typed(TypedFieldModifiable modifiable) =
      Typed._;

  /// {@macro dynamic}
  const factory ConstantVariables.dynamic(
    DynamicFieldModifiable modifiable,
  ) = Dynamic._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<ConstantVariables> get _members => [fields];
}

/// {@template const}
/// Represents constant members.
/// {@endtemplate}
@InvalidMembers({
  th<Getters>(),
  th<Setters>(),
  th<GettersSetters>(),
  th<FieldsGettersSetters>(),
  th<Methods>(),
})
@InvalidModifiers({
  th<Final>(),
  th<Late>(),
  th<Var>(),
  th<Const>(),
  th<Abstract>(),
  th<External>(),
  th<Overridden>(),
})
@MutuallyExclusive(#finality, optional: true)
final class Const<M extends Constant> extends Modifier<M> implements Statical {
  /// {@macro const}
  const Const._(super.modifiable) : super._();
}
