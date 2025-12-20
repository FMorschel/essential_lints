part of 'sort_declarations.dart';

/// Groups initializable members.
@_gettersInMemberList
sealed class Initializable extends StaticalContext {
  const Initializable._() : super._();

  // ignore: unused_element member list
  static List<Initializable> get _members => [];
}

/// Groups initializable overridable members.
@_gettersInMemberList
sealed class InitializableOverridable extends Initializable
    implements NewMemberModifiable {
  /// {@macro private}
  const factory InitializableOverridable.private(
    PrivateFieldModifiable modifiable,
  ) = Private._;

  /// {@macro public}
  const factory InitializableOverridable.public(
    PublicFieldModifiable modifiable,
  ) = Public._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<InitializableOverridable> get _members => [fields];
}

/// Groups initializable static members.
@_gettersInMemberList
sealed class InitializableStatical extends Initializable implements Statical {
  /// {@macro public}
  const factory InitializableStatical.public(PublicFieldModifiable modifiable) =
      Public._;

  /// {@macro private}
  const factory InitializableStatical.private(
    PrivateFieldModifiable modifiable,
  ) = Private._;

  /// {@macro fields}
  static const Fields fields = Fields._fields;

  // ignore: unused_element member list
  static List<InitializableStatical> get _members => [fields];
}

/// {@template initialized}
/// Represents initialized members.
/// {@endtemplate}
@InvalidMembers({
  th<Constructors>(),
  th<Getters>(),
  th<Setters>(),
  th<GettersSetters>(),
  th<FieldsGettersSetters>(),
  th<Methods>(),
})
@InvalidModifiers({
  th<Abstract>(),
  th<External>(),
  th<Initialized>(),
  th<Late>(),
  th<Overridden>(),
  th<Static>(),
})
final class Initialized<M extends Initializable> extends Modifier<M>
    implements
        Statical,
        NewMemberModifiable,
        NullableMembersModifiable,
        FinalModifiable,
        Variable,
        ConstantVariables,
        NullableFieldModifiable,
        TypedFieldModifiable,
        TypedMembersModifiable,
        DynamicFieldModifiable,
        DynamicMembersModifiable,
        InstanciableMembers,
        OverridableMembers {
  /// {@macro initialized}
  const Initialized._(super.modifiable) : super._();
}
