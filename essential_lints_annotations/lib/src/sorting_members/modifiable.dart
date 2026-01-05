part of 'sort_declarations.dart';

/// Class representing modifiable sort declarations.
/*sealed*/ abstract class _Modifiable extends SortDeclaration {
  const _Modifiable._() : super._();
}

const _gettersInMemberList = GettersInMemberList(
  memberListName: #_members,
  membersOption: MembersOption.static,
);

/// Class representing statical context for [Modifier]s.
@SubtypeAnnotating(
  annotations: [_gettersInMemberList],
  option: SubtypeOption.onlyAbstract,
)
/*sealed*/ abstract class _StaticalContext extends _Modifiable {
  const _StaticalContext._() : super._();
}

/// Class representing modifiers for sort declarations.
@SubtypeAnnotating(annotations: [InvalidMembers, InvalidModifiers])
// ignore: library_private_types_in_public_api this class is hidden
/*final*/ class Modifier<M extends _StaticalContext> extends _StaticalContext {
  const Modifier._(this.modifiable) : super._();

  /// The modifiable that this modifier wraps.
  final M modifiable;
}
