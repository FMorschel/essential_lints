import 'package:meta/meta.dart';

import '../../essential_lints_annotations.dart';
import '../_internal/invalid_members.dart';
import '../_internal/invalid_modifiers.dart';
import '../_internal/member_group.dart';
import '../_internal/mutually_exclusive.dart';

part 'abstractable.dart';
part 'constant.dart';
part 'dynamic_modifiable.dart';
part 'external_modifiable.dart';
part 'factory_modifiable.dart';
part 'final_modifiable.dart';
part 'group.dart';
part 'initializable.dart';
part 'instantiable.dart';
part 'late_modifiable.dart';
part 'member.dart';
part 'modifiable.dart';
part 'named_modifiable.dart';
part 'new_modifiable.dart';
part 'nullable_modifiable.dart';
part 'operator_modifiable.dart';
part 'overridable.dart';
part 'private_modifiable.dart';
part 'public_modifiable.dart';
part 'redirecting_modifiable.dart';
part 'statical.dart';
part 'test.dart';
part 'typed_modifiable.dart';
part 'unnamed_modifiable.dart';
part 'variable.dart';

/// {@template sortDeclaration}
/// Represents a sort declaration for member ordering in the `@SortingMembers`
/// annotation.
///
/// Sort declarations define patterns that class members should match, allowing
/// fine-grained control over member ordering based on modifiers, types, and
/// names. Declarations use Dart's enhanced enum-style syntax with leading dots.
///
/// ## Usage Examples
///
/// ### Member Groups
///
/// Match all members of a specific type:
///
/// ```dart
/// @SortingMembers({
///   .fields,          // All fields
///   .constructors,    // All constructors
///   .methods,         // All methods
///   .getters,         // All getters
///   .setters,         // All setters
/// })
/// class Example {}
/// ```
///
/// ### Modifiers
///
/// Apply modifiers to create specific patterns:
///
/// ```dart
/// @SortingMembers({
///   .public(.fields),    // Public fields
///   .private(.fields),   // Private fields
///   .static(.methods),   // Static methods
///   .final_(.fields),    // Final fields
/// })
/// class Example {}
/// ```
///
/// ### Specific Members
///
/// Target individual members by name:
///
/// ```dart
/// @SortingMembers({
///   .field(#id),           // Specific field named 'id'
///   .constructor(),        // Unnamed constructor
///   .constructor(#named),  // Named constructor
///   .method(#toString),    // Specific method
/// })
/// class Example {}
/// ```
///
/// ### Combining Modifiers
///
/// Chain modifiers for more specific patterns:
///
/// ```dart
/// @SortingMembers({
///   .public(.static(.const_(.fields))),  // Public static const fields
///   .private(.late(.var_(.fields))),     // Private late var fields
///   .abstract(.methods),                  // Abstract methods
/// })
/// class Example {}
/// ```
/// {@endtemplate}
@immutable
/*sealed*/ abstract class SortDeclaration {
  const SortDeclaration._();

  /// {@template abstract}
  /// Represents abstract members.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.abstract(Abstractable modifiable) = _Abstract._;

  /// {@template overridden}
  /// Represents overridden members.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.overridden(OverridableMembers modifiable) =
      _Overridden._;

  /// {@template new}
  /// Represents new members (non-overridden).
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.new_(NewMemberModifiable modifiable) = _New._;

  /// {@template instance}
  /// Represents instance members.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.instance(InstantiableMembers modifiable) =
      _Instance._;

  /// {@template external}
  /// Represents external members.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.external(ExternalMembersModifiable modifiable) =
      _External._;

  /// {@template static}
  /// Represents static members.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.static(Statical modifiable) = _Static._;

  /// {@template late}
  /// Represents late members.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.late(LateModifiable modifiable) = _Late._;

  /// {@template operator}
  /// Represents operator members.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.operator([OperatorModifiable modifiable]) =
      _Operator._;

  /// {@template nullable}
  /// Represents nullable members.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.nullable(NullableMembersModifiable modifiable) =
      _Nullable._;

  /// {@template typed}
  /// Represents typed members.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.typed(TypedMembersModifiable modifiable) =
      _Typed._;

  /// {@template dynamic}
  /// Represents dynamic members.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.dynamic(DynamicMembersModifiable modifiable) =
      _Dynamic._;

  /// {@template private}
  /// Represents private members.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.private(PrivateModifiable modifiable) =
      _Private._;

  /// {@template public}
  /// Represents public members.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.public(PublicModifiable modifiable) = _Public._;

  /// {@template initialized}
  /// Represents initialized members.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.initialized(InitializableStatical modifiable) =
      _Initialized._;

  /// {@template var}
  /// Represents variable members.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.var_(Variable modifiable) = _Var._;

  /// {@template final}
  /// Represents final members.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.final_(FinalModifiable modifiable) = _Final._;

  /// {@template const}
  /// Represents constant members.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.const_(Constant modifiable) = _Const._;

  /// {@template factory}
  /// Represents factory constructors.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.factory_(
    FactoryConstructorModifiable modifiable,
  ) = _Factory._;

  /// {@template named}
  /// Represents named constructors.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.named(NamedModifiable modifiable) = _Named._;

  /// {@template unnamed}
  /// Represents unnamed members.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.unnamed(UnnamedModifiable modifiable) =
      _Unnamed._;

  /// {@template redirecting}
  /// Represents redirecting constructors.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.redirecting(RedirectingModifiable modifiable) =
      _Redirecting._;

  /// {@template constructor}
  /// Represents a constructor
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.constructor([Symbol? name]) = _Constructor._;

  /// {@template field}
  /// Represents a field.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.field(Symbol name) = _Field._;

  /// {@template getter}
  /// Represents a getter.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.getter(Symbol name) = _Getter._;

  /// {@template method}
  /// Represents a method.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.method(Symbol name) = _Method._;

  /// {@template setter}
  /// Represents a setter.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  const factory SortDeclaration.setter(Symbol name) = _Setter._;

  /// {@template test}
  /// Represents a test modifier.
  ///
  /// {@macro sortDeclaration}
  /// {@endtemplate}
  @Deprecated(
    'This is not intended for general use. Only for testing purposes.',
  )
  @visibleForTesting
  const factory SortDeclaration.test(Testable modifiable) = _Test._;

  /// {@macro constructors}
  static const Constructors constructors = Constructors._constructors;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  static const FieldsGettersSetters fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  static const Getters getters = Getters._getters;

  /// {@macro gettersSetters}
  static const GettersSetters gettersSetters = GettersSetters._gettersSetters;

  /// {@macro methods}
  static const Methods methods = Methods._methods;

  /// {@macro setters}
  static const Setters setters = Setters._setters;
}
