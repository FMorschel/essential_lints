part 'abstractable.dart';
part 'constant.dart';
part 'external_modifiable.dart';
part 'final_modifiable.dart';
part 'group.dart';
part 'initializable.dart';
part 'late_modifiable.dart';
part 'member.dart';
part 'modifiable.dart';
part 'nullable_modifiable.dart';
part 'operator_modifiable.dart';
part 'overridable.dart';
part 'private_modifiable.dart';
part 'public_modifiable.dart';
part 'statical.dart';
part 'variable.dart';

/// A helper typedef for generating sort declarations.
typedef SortDeclarationGenerator<I, O extends SortDeclaration> = O Function(I);

/// Represents a sort declaration.
sealed class SortDeclaration {
  const SortDeclaration();

  /// {@macro overriden}
  static const OverriddenGenerator overridden = Overridden.overriden;

  /// {@macro externalMembers}
  static const ExternalMembersGenerator external = External.new;

  /// {@macro operator}
  static const OperatorGenerator operator = Operator.operator;

  /// {@macro initialized}
  static const InitializableGenerator initialized =
      InitializedModifier.initialized;

  /// The constructor generator.
  static const MemberGenerator constructor = Constructor.constructor;

  /// The field generator.
  static const MemberGenerator field = Field.field;

  /// The getter generator.
  static const MemberGenerator getter = Getter.getter;

  /// The method generator.
  static const MemberGenerator method = Method.method;

  /// The setter generator.
  static const MemberGenerator setter = Setter.setter;

  /// {@macro constructors}
  static const SortDeclaration constructors = Constructors.constructors;

  /// {@macro fields}
  static const SortDeclaration fields = Fields.fields;

  /// {@macro fieldsGettersSetters}
  static const SortDeclaration fieldsGettersSetters =
      FieldsGettersSetters.fieldsGettersSetters;

  /// {@macro getters}
  static const SortDeclaration getters = Getters.getters;

  /// {@macro gettersSetters}
  static const SortDeclaration gettersSetters = GettersSetters.gettersSetters;

  /// {@macro methods}
  static const SortDeclaration methods = Methods.methods;

  /// {@macro setters}
  static const SortDeclaration setters = Setters.setters;
}
