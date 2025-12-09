part of 'sort_declarations.dart';

/// Represents external modifiable members.
sealed class ExternalModifiable extends Modifiable {
  const ExternalModifiable();
}

/// {@template externalMembers}
/// Represents members that can be external and their modifiers.
/// {@endtemplate}
sealed class ExternalMembersModifiable extends ExternalModifiable {
  const ExternalMembersModifiable();

  /// {@macro operator}
  static const OperatorGenerator operator = Operator.operator;

  /// {@macro var}
  static const VariableGenerator variable = Var.variable;

  /// {@macro constructors}
  static const ExternalMembersModifiable constructors =
      Constructors.constructors;

  /// {@macro fields}
  static const ExternalMembersModifiable fields = Fields.fields;

  /// {@macro fieldsGettersSetters}
  static const ExternalMembersModifiable fieldsGettersSetters =
      FieldsGettersSetters.fieldsGettersSetters;

  /// {@macro getters}
  static const ExternalMembersModifiable getters = Getters.getters;

  /// {@macro gettersSetters}
  static const ExternalMembersModifiable gettersSetters =
      GettersSetters.gettersSetters;

  /// {@macro methods}
  static const ExternalMembersModifiable methods = Methods.methods;

  /// {@macro setters}
  static const ExternalMembersModifiable setters = Setters.setters;
}

/// {@template externalMembers}
/// Represents members that can be external and their modifiers.
/// {@endtemplate}
sealed class ExternalInstanceModifiable extends ExternalModifiable
    implements Overridable {
  const ExternalInstanceModifiable();

  /// {@macro operator}
  static const OperatorGenerator operator = Operator.operator;

  /// {@macro var}
  static const VariableGenerator variable = Var.variable;

  /// {@macro fields}
  static const ExternalInstanceModifiable fields = Fields.fields;

  /// {@macro fieldsGettersSetters}
  static const ExternalInstanceModifiable fieldsGettersSetters =
      FieldsGettersSetters.fieldsGettersSetters;

  /// {@macro getters}
  static const ExternalInstanceModifiable getters = Getters.getters;

  /// {@macro gettersSetters}
  static const ExternalInstanceModifiable gettersSetters =
      GettersSetters.gettersSetters;

  /// {@macro methods}
  static const ExternalInstanceModifiable methods = Methods.methods;

  /// {@macro setters}
  static const ExternalInstanceModifiable setters = Setters.setters;
}

/// A helper typedef for generating external modifiers.
typedef ExternalGenerator<I extends ExternalModifiable, O extends External<I>> =
    ModifierGenerator<I, O>;

/// A helper typedef for generating external member modifiers.
typedef ExternalMembersGenerator<
  I extends ExternalMembersModifiable,
  O extends External<I>
> = ExternalGenerator<I, O>;

/// A helper typedef for generating external member modifiers.
typedef ExternalInstanceGenerator<
  I extends ExternalInstanceModifiable,
  O extends External<I>
> = ExternalGenerator<I, O>;

/// {@template externalMembers}
/// Represents external members.
/// {@endtemplate}
final class External<M extends ExternalModifiable> extends Modifier<M> {
  /// {@macro externalMembers}
  const External(super.modifiable);
}
