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
part 'instanciable.dart';
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

/// Represents a sort declaration.
@immutable
sealed class SortDeclaration {
  const SortDeclaration._();

  /// {@macro abstract}
  const factory SortDeclaration.abstract(Abstractable modifiable) = Abstract._;

  /// {@macro overridden}
  const factory SortDeclaration.overridden(OverridableMembers modifiable) =
      Overridden._;

  /// {@macro new}
  const factory SortDeclaration.new_(NewMemberModifiable modifiable) = New._;

  /// {@macro instance}
  const factory SortDeclaration.instance(InstanciableMembers modifiable) =
      Instance._;

  /// {@macro externalMembers}
  const factory SortDeclaration.external(ExternalMembersModifiable modifiable) =
      External._;

  /// {@macro static}
  const factory SortDeclaration.static(Statical modifiable) = Static._;

  /// {@macro late_modifiable}
  const factory SortDeclaration.late(LateModifiable modifiable) = Late._;

  /// {@macro operator}
  const factory SortDeclaration.operator([OperatorModifiable modifiable]) =
      Operator._;

  /// {@macro nullable}
  const factory SortDeclaration.nullable(NullableMembersModifiable modifiable) =
      Nullable._;

  /// {@macro typed}
  const factory SortDeclaration.typed(TypedMembersModifiable modifiable) =
      Typed._;

  /// {@macro dynamic}
  const factory SortDeclaration.dynamic(DynamicMembersModifiable modifiable) =
      Dynamic._;

  /// {@macro private}
  const factory SortDeclaration.private(PrivateModifiable modifiable) =
      Private._;

  /// {@macro public}
  const factory SortDeclaration.public(PublicModifiable modifiable) = Public._;

  /// {@macro initialized}
  const factory SortDeclaration.initialized(InitializableStatical modifiable) =
      Initialized._;

  /// {@macro variable}
  const factory SortDeclaration.var_(Variable modifiable) = Var._;

  /// {@macro final}
  const factory SortDeclaration.final_(FinalModifiable modifiable) = Final._;

  /// {@macro const}
  const factory SortDeclaration.const_(Constant modifiable) = Const._;

  /// {@macro factory}
  const factory SortDeclaration.factory_(
    FactoryConstructorModifiable modifiable,
  ) = Factory._;

  /// {@macro named}
  const factory SortDeclaration.named(NamedModifiable modifiable) = Named._;

  /// {@macro unnamed}
  const factory SortDeclaration.unnamed(UnnamedModifiable modifiable) =
      Unnamed._;

  /// {@macro redirecting}
  const factory SortDeclaration.redirecting(RedirectingModifiable modifiable) =
      Redirecting._;

  /// The constructor generator.
  const factory SortDeclaration.constructor([Symbol? name]) = Constructor._;

  /// The field generator.
  const factory SortDeclaration.field(Symbol name) = Field._;

  /// The getter generator.
  const factory SortDeclaration.getter(Symbol name) = Getter._;

  /// The method generator.
  const factory SortDeclaration.method(Symbol name) = Method._;

  /// The setter generator.
  const factory SortDeclaration.setter(Symbol name) = Setter._;

  /// {@macro test}
  @Deprecated(
    'This is not intended for general use. Only for testing purposes.',
  )
  @visibleForTesting
  const factory SortDeclaration.test(Testable modifiable) = Test._;

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
