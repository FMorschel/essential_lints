part of 'sort_declarations.dart';

/// {@template methodModifiers}
/// Represents modifiers that can be applied to methods and methods themselves.
/// {@endtemplate}
@_gettersInMemberList
sealed class OperatorModifiable extends _StaticalContext {
  /// {@macro nullable}
  const factory OperatorModifiable.nullable([
    NullableOperatorModifiable modifiable,
  ]) = _Nullable._operator;

  /// {@macro typed}
  const factory OperatorModifiable.typed([TypedOperatorModifiable modifiable]) =
      _Typed._operator;

  /// {@macro dynamic}
  const factory OperatorModifiable.dynamic([
    DynamicOperatorModifiable modifiable,
  ]) = _Dynamic._operator;

  /// {@macro methods}
  static const Methods methods = Methods._methods;

  // ignore: unused_element member list
  static List<ExternalMembersModifiable> get _members => [methods];
}

@InvalidMembers({
  th<Fields>(),
  th<Getters>(),
  th<Setters>(),
  th<GettersSetters>(),
  th<FieldsGettersSetters>(),
  th<Constructors>(),
})
@InvalidModifiers({
  th<_Static>(),
  th<_Private>(),
  th<_Public>(),
  th<_Operator>(),
})
final class _Operator extends Modifier<OperatorModifiable>
    implements
        NewMemberModifiable,
        ExternalMembersModifiable,
        Abstractable,
        InstantiableMembers,
        OverridableMembers,
        OverridableExternal,
        InstantiableExternal,
        NewExternalModifiable {
  const _Operator._([super.modifiable = OperatorModifiable.methods])
    : super._();
}
