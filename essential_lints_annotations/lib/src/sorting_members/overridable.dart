part of 'sort_declarations.dart';

/// {@template overridable}
/// Represents overridable members.
/// {@endtemplate}
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class Overridable extends StaticalContext {
  /// {@macro public}
  @Consider<Public>()
  const factory Overridable.public(PublicStaticalModifiable modifiable) =
      Public._;

  /// {@macro private}
  @Consider<Private>()
  const factory Overridable.private(PrivateStaticalModifiable modifiable) =
      Private._;

  /// {@macro nullable}
  @Consider<Nullable>()
  const factory Overridable.nullable(NullableMembersModifiable modifiable) =
      Nullable._;

  /// {@macro abstract}
  @Consider<Abstract>()
  const factory Overridable.abstract(Abstractable modifiable) = Abstract._;

  /// {@macro externalMembers}
  @Consider<External>()
  const factory Overridable.external(ExternalInstanceModifiable modifiable) =
      External._;

  /// {@macro operator}
  @Consider<Operator>()
  const factory Overridable.operator([OperatorModifiable modifiable]) =
      Operator._;

  /// {@macro initializable}
  @Consider<Initialized>()
  const factory Overridable.initialized(InitializableOverridable modifiable) =
      Initialized._;

  /// {@macro late_modifiable}
  @Consider<Late>()
  const factory Overridable.late(LateModifiable modifiable) = Late._;

  /// {@macro var}
  @Consider<Var>()
  const factory Overridable.var_(Variable modifiable) = Var._;

  /// {@macro final}
  @Consider<Final>()
  const factory Overridable.final_(FinalModifiable modifiable) = Final._;

  /// {@macro fields}
  @Consider<Fields>()
  static const Overridable fields = Fields._fields;

  /// {@macro fieldsGettersSetters}
  @Consider<FieldsGettersSetters>()
  static const Overridable fieldsGettersSetters =
      FieldsGettersSetters._fieldsGettersSetters;

  /// {@macro getters}
  @Consider<Getters>()
  static const Overridable getters = Getters._getters;

  /// {@macro gettersSetters}
  @Consider<GettersSetters>()
  static const Overridable gettersSetters = GettersSetters._gettersSetters;

  /// {@macro methods}
  @Consider<Methods>()
  static const Overridable methods = Methods._methods;

  /// {@macro setters}
  @Consider<Setters>()
  static const Overridable setters = Setters._setters;
}

/// {@template overridden}
/// Represents overridden members.
/// {@endtemplate}
@InvalidMembers([th<Constructors>()])
@InvalidModifiers([
  th<Static>(),
  th<Overridden>(),
])
final class Overridden<M extends Overridable> extends Modifier<M>
    implements OperatorModifiable {
  /// {@macro overridden}
  const Overridden._(super.modifiable) : super._();
}
