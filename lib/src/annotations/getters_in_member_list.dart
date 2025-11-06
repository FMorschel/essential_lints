// ignore_for_file: unused_field, annotation members don't need to be public

/// {@template getters_in_member_list}
/// Annotations for the `getters-in-member-list` lint rule.
/// {@endtemplate}
class GettersInMemberList {
  /// {@macro getters_in_member_list}
  const GettersInMemberList({
    required String memberListName,
    bool getters = true,
    bool fields = true,
    List<Type> types = const <Type>[],
  }) : _memberListName = memberListName,
       _types = types,
       _getters = getters,
       _fields = fields;

  final String _memberListName;
  final List<Type> _types;
  final bool _getters;
  final bool _fields;
}
