part of 'sort_declarations.dart';

/// Represents abstractable members.
@_gettersInMemberList
sealed class Abstractable extends _StaticalContext
    implements NewMemberModifiable, OperatorModifiable {
  /// {@macro public}
  const factory Abstractable.public(PublicStaticalModifiable modifiable) =
      _Public._;

  /// {@macro private}
  const factory Abstractable.private(PrivateStaticalModifiable modifiable) =
      _Private._;

  /// {@macro nullable}
  const factory Abstractable.nullable(NullableExternableModifiable modifiable) =
      _Nullable._;

  /// {@macro typed}
  const factory Abstractable.typed(TypedExternableModifiable modifiable) =
      _Typed._;

  /// {@macro dynamic}
  const factory Abstractable.dynamic(
    DynamicExternableModifiable modifiable,
  ) = _Dynamic._;

  /// {@macro operator}
  const factory Abstractable.operator([OperatorModifiable modifiable]) =
      _Operator._;

  /// {@macro var}
  const factory Abstractable.var_(VariableAbstractable modifiable) = _Var._;

  /// {@macro final}
  const factory Abstractable.final_(FinalAbstractModifiable modifiable) =
      _Final._;

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

@InvalidMembers({th<Constructors>()})
@InvalidModifiers({
  th<_External>(),
  th<_Static>(),
  th<_Initialized>(),
  th<_Late>(),
  th<_Abstract>(),
})
final class _Abstract<M extends Abstractable> extends Modifier<M>
    implements NewMemberModifiable, InstantiableMembers, OverridableMembers {
  /// {@macro abstract}
  const _Abstract._(super.modifiable) : super._();
}
