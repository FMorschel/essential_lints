part of 'sort_declarations.dart';

/// {@template late_modifiable}
/// Represents late modifiable members.
/// {@endtemplate}
@AnnotateMembersWith(Consider, onlyPublic: true)
sealed class LateModifiable extends StaticalContext
    implements Statical, Overridable {
  /// {@macro var}
  @Consider<Var>()
  const factory LateModifiable.var_(Variable modifiable) = Var._;

  /// {@macro final}
  @Consider<Final>()
  const factory LateModifiable.final_(FinalModifiable modifiable) = Final._;

  /// {@macro public}
  @Consider<Public>()
  const factory LateModifiable.public(PublicFieldModifiable modifiable) =
      Public._;

  /// {@macro private}
  @Consider<Private>()
  const factory LateModifiable.private(PrivateFieldModifiable modifiable) =
      Private._;

  /// {@macro nullable}
  @Consider<Nullable>()
  const factory LateModifiable.nullable(NullableFieldModifiable modifiable) =
      Nullable._;

  /// {@macro initialized}
  @Consider<Initialized>()
  const factory LateModifiable.initialized(InitializableStatical modifiable) =
      Initialized._;

  /// {@macro fields}
  @Consider<Fields>()
  static const LateModifiable fields = Fields._fields;
}

/// {@template late}
/// Represents late members.
/// {@endtemplate}
@InvalidMembers([
  th<Constructors>(),
  th<Getters>(),
  th<Setters>(),
  th<GettersSetters>(),
  th<FieldsGettersSetters>(),
  th<Methods>(),
])
@InvalidModifiers([
  th<Abstract>(),
  th<External>(),
  th<Const>(),
  th<Late>(),
  th<Overridden>(),
  th<Static>(),
])
final class Late<M extends LateModifiable> extends Modifier<M>
    implements Statical, Overridable, StaticalExternal {
  /// {@macro late}
  const Late._(super.modifiable) : super._();
}
