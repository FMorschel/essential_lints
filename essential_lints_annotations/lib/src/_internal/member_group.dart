/// {@template member_group}
/// Represents a group of members.
/// {@endtemplate}
class MemberGroup {
  /// {@macro member_group}
  const MemberGroup(this.name, {this.participant = true});

  /// The name of the member group.
  final Symbol name;

  /// Whether this group is a participant in sorting.
  final bool participant;
}
