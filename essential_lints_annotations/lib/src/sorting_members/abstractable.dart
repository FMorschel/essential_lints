part of 'sort_declarations.dart';

/// Represents abstractable members.
@_gettersInMemberList
sealed class Abstractable extends StaticalContext
    implements NewMemberModifiable, OperatorModifiable {
  /// {@macro public}
  const factory Abstractable.public(PublicStaticalModifiable modifiable) =
      Public._;

  /// {@macro private}
  const factory Abstractable.private(PrivateStaticalModifiable modifiable) =
      Private._;

  /// {@macro nullable}
  const factory Abstractable.nullable(NullableExternableModifiable modifiable) =
      Nullable._;

  /// {@macro typed}
  const factory Abstractable.typed(TypedExternableModifiable modifiable) =
      Typed._;

  /// {@macro dynamic}
  const factory Abstractable.dynamic(
    DynamicExternableModifiable modifiable,
  ) = Dynamic._;

  /// {@macro operator}
  const factory Abstractable.operator([OperatorModifiable modifiable]) =
      Operator._;

  /// {@macro var}
  const factory Abstractable.var_(VariableAbstractable modifiable) = Var._;

  /// {@macro final}
  const factory Abstractable.final_(FinalAbstractModifiable modifiable) =
      Final._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  static const FieldsGettersSetters fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  static const Getters getters = Getters._getters;

  /// {@macro setters}
  static const Setters setters = Setters._setters;

  /// {@macro gettersSetters}
  static const GettersSetters gettersSetters = GettersSetters._gettersSetters;

  /// {@macro methods}
  static const Methods methods = Methods._methods;

  // ignore: unused_element member list
  static List<Abstractable> get _members => [
    fields,
    getters,
    setters,
    methods,
    fieldsGettersSetters,
    gettersSetters,
  ];
}

/// {@template abstract}
/// Represents abstract members.
/// {@endtemplate}
@InvalidMembers({th<Constructors>()})
@InvalidModifiers({
  th<External>(),
  th<Static>(),
  th<Initialized>(),
  th<Late>(),
  th<Abstract>(),
})
final class Abstract<M extends Abstractable> extends Modifier<M>
    implements
        NewMemberModifiable,
        InstanciableMembers,
        OverridableMembers {
  /// {@macro abstract}
  const Abstract._(super.modifiable) : super._();
}
