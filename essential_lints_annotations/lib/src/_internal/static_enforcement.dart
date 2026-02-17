import '../../essential_lints_annotations.dart';

/// {@template staticEnforcement}
/// An annotation to enforce a specific member exists and is declared as static.
/// {@endtemplate}
class StaticEnforcement {
  /// {@macro staticEnforcement}
  const StaticEnforcement(this.memberName, [this.type]);

  /// The name of the member that should be declared as static.
  final Symbol memberName;

  /// The type of the member that should be declared as static.
  ///
  /// If the member is a field, this will be the field's type.
  /// If the member is a method, this will be the method's return type.
  /// If the member is a getter, this will be the getter's return type.
  /// If the member is a setter, this will be the setter's parameter type.
  /// If the member is a constructor, this will be the constructor's class type.
  final TypeHolder<dynamic>? type;
}
