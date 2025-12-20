part of 'sort_declarations.dart';

/// {@template methodModifiers}
/// Represents modifiers that can be applied to methods and methods themselves.
/// {@endtemplate}
@_gettersInMemberList
sealed class OperatorModifiable extends StaticalContext {
  /// {@macro nullable}
  const factory OperatorModifiable.nullable([
    NullableOperatorModifiable modifiable,
  ]) = Nullable._operator;

  /// {@macro typed}
  const factory OperatorModifiable.typed([TypedOperatorModifiable modifiable]) =
      Typed._operator;

  /// {@macro dynamic}
  const factory OperatorModifiable.dynamic([
    DynamicOperatorModifiable modifiable,
  ]) = Dynamic._operator;

  /// {@macro methods}
  static const Methods methods = Methods._methods;

  // ignore: unused_element member list
  static List<ExternalMembersModifiable> get _members => [methods];
}

/// {@template operator}
/// Represents operator members.
/// {@endtemplate}
@InvalidMembers({
  th<Fields>(),
  th<Getters>(),
  th<Setters>(),
  th<GettersSetters>(),
  th<FieldsGettersSetters>(),
  th<Constructors>(),
})
@InvalidModifiers({
  th<Static>(),
  th<Private>(),
  th<Public>(),
  th<Operator>(),
})
final class Operator extends Modifier<OperatorModifiable>
    implements
        NewMemberModifiable,
        ExternalMembersModifiable,
        Abstractable,
        InstanciableMembers,
        OverridableMembers,
        OverridableExternal,
        InstanciableExternal,
        NewExternalModifiable {
  /// {@macro operator}
  const Operator._([super.modifiable = OperatorModifiable.methods]) : super._();
}
