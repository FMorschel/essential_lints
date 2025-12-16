// ignore: prefer_relative_imports test
import 'package:essential_lints_annotations/src/getters_in_member_list.dart';
// ignore: prefer_relative_imports test
import 'package:essential_lints_annotations/src/subtype_annotating.dart';
import 'package:meta/meta.dart';

import '../_internal/annotate_members_with.dart';
import '../_internal/consider.dart';
import '../_internal/invalid_members.dart';
import '../_internal/invalid_modifiers.dart';

part 'abstractable.dart';
part 'constant.dart';
part 'external_modifiable.dart';
part 'factory_modifiable.dart';
part 'final_modifiable.dart';
part 'group.dart';
part 'initializable.dart';
part 'late_modifiable.dart';
part 'member.dart';
part 'modifiable.dart';
part 'named_modifiable.dart';
part 'nullable_modifiable.dart';
part 'operator_modifiable.dart';
part 'overridable.dart';
part 'private_modifiable.dart';
part 'public_modifiable.dart';
part 'redirecting_modifiable.dart';
part 'statical.dart';
part 'test.dart';
part 'unnamed_modifiable.dart';
part 'variable.dart';

/// Represents a sort declaration.
@immutable
sealed class SortDeclaration {
  const SortDeclaration._();

  /// {@macro abstract}
  @Consider<Abstract>()
  const factory SortDeclaration.abstract(Abstractable modifiable) = Abstract._;

  /// {@macro overridden}
  @Consider<Overridden>()
  const factory SortDeclaration.overridden(Overridable modifiable) =
      Overridden._;

  /// {@macro externalMembers}
  @Consider<External>()
  const factory SortDeclaration.external(ExternalMembersModifiable modifiable) =
      External._;

  /// {@macro static}
  @Consider<Static>()
  const factory SortDeclaration.static(Statical modifiable) = Static._;

  /// {@macro late_modifiable}
  @Consider<Late>()
  const factory SortDeclaration.late(LateModifiable modifiable) = Late._;

  /// {@macro operator}
  @Consider<Operator>()
  const factory SortDeclaration.operator([OperatorModifiable modifiable]) =
      Operator._;

  /// {@macro nullable}
  @Consider<Nullable>()
  const factory SortDeclaration.nullable(NullableMembersModifiable modifiable) =
      Nullable._;

  /// {@macro private}
  @Consider<Private>()
  const factory SortDeclaration.private(PrivateModifiable modifiable) =
      Private._;

  /// {@macro public}
  @Consider<Public>()
  const factory SortDeclaration.public(PublicModifiable modifiable) = Public._;

  /// {@macro initialized}
  @Consider<Initialized>()
  const factory SortDeclaration.initialized(InitializableStatical modifiable) =
      Initialized._;

  /// {@macro variable}
  @Consider<Var>()
  const factory SortDeclaration.var_(Variable modifiable) = Var._;

  /// {@macro final}
  @Consider<Final>()
  const factory SortDeclaration.final_(FinalModifiable modifiable) = Final._;

  /// {@macro const}
  @Consider<Const>()
  const factory SortDeclaration.const_(Constant modifiable) = Const._;

  /// {@macro factory}
  @Consider<Factory>()
  const factory SortDeclaration.factory_(FactoryModifiable modifiable) =
      Factory._;

  /// {@macro named}
  @Consider<Named>()
  const factory SortDeclaration.named(NamedModifiable modifiable) = Named._;

  /// {@macro unnamed}
  @Consider<Unnamed>()
  const factory SortDeclaration.unnamed(UnnamedModifiable modifiable) =
      Unnamed._;

  /// {@macro redirecting}
  @Consider<Redirecting>()
  const factory SortDeclaration.redirecting(RedirectingModifiable modifiable) =
      Redirecting._;

  /// The constructor generator.
  @Consider<Constructor>()
  const factory SortDeclaration.constructor([Symbol? name]) = Constructor._;

  /// The field generator.
  @Consider<Field>()
  const factory SortDeclaration.field(Symbol name) = Field._;

  /// The getter generator.
  @Consider<Getter>()
  const factory SortDeclaration.getter(Symbol name) = Getter._;

  /// The method generator.
  @Consider<Method>()
  const factory SortDeclaration.method(Symbol name) = Method._;

  /// The setter generator.
  @Consider<Setter>()
  const factory SortDeclaration.setter(Symbol name) = Setter._;

  /// {@macro test}
  @Consider<Test>()
  @Deprecated('This is not intended for general use.')
  const factory SortDeclaration.test(Testable modifiable) = Test._;

  /// {@macro constructors}
  @Consider<Constructors>()
  static const SortDeclaration constructors = Constructors._constructors;

  /// {@macro fields}
  @Consider<Fields>()
  static const SortDeclaration fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  @Consider<FieldsGettersSetters>()
  static const SortDeclaration fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  @Consider<Getters>()
  static const SortDeclaration getters = Getters._getters;

  /// {@macro gettersSetters}
  @Consider<GettersSetters>()
  static const SortDeclaration gettersSetters = GettersSetters._gettersSetters;

  /// {@macro methods}
  @Consider<Methods>()
  static const SortDeclaration methods = Methods._methods;

  /// {@macro setters}
  @Consider<Setters>()
  static const SortDeclaration setters = Setters._setters;
}
