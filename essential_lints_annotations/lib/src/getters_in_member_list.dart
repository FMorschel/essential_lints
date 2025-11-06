// ignore_for_file: annotation members don't need to be public

/// {@template getters_in_member_list}
/// Annotations for the `getters-in-member-list` lint rule.
/// {@endtemplate}
class GettersInMemberList {
  /// {@macro getters_in_member_list}
  const GettersInMemberList({
    required this.memberListName,
    this.getters = true,
    this.fields = true,
    this.types = const <Type>[],
  });

  /// The name of the member list to check.
  final String memberListName;

  /// The types of members to check.
  ///
  /// If empty, all types are checked.
  final List<Type> types;

  /// Whether to check for getters.
  final bool getters;

  /// Whether to check for fields.
  final bool fields;
}
