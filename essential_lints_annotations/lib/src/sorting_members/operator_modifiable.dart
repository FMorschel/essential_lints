part of 'sort_declarations.dart';

/// {@template methodModifiers}
/// Represents modifiers that can be applied to methods and methods themselves.
/// {@endtemplate}
sealed class OperatorModifiable extends Modifiable {
  /// {@macro nullable}
  const factory OperatorModifiable.nullable(
    NullableOperatorModifiable modifiable,
  ) = Nullable._;

  /// {@macro methods}
  static const OperatorModifiable methods = Methods._methods;
}

/// {@template operator}
/// Represents operator members.
/// {@endtemplate}
@InvalidMembers([
  th<Fields>(),
  th<Getters>(),
  th<Setters>(),
  th<GettersSetters>(),
  th<FieldsGettersSetters>(),
  th<Constructors>(),
])
@InvalidModifiers([
  th<Static>(),
  th<Private>(),
  th<Public>(),
  th<Operator>(),
])
final class Operator extends Modifier<OperatorModifiable>
    implements
        Overridable,
        ExternalMembersModifiable,
        ExternalInstanceModifiable,
        Abstractable {
  /// {@macro operator}
  const Operator._([super.modifiable = OperatorModifiable.methods]) : super._();
}
