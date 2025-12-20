import 'dart:async';

import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';
import 'package:essential_lints/src/warnings/getters_in_member_list.dart';
import 'package:essential_lints/src/warnings/subtype_annotating.dart';
import 'package:essential_lints/src/warnings/subtype_naming.dart';

import 'rules/annotate_members_with.dart';
import 'rules/invalid_members.dart';
import 'rules/invalid_modifiers.dart';

class InternalPlugin extends Plugin {
  @override
  String get name => '_internal_plugin';

  @override
  FutureOr<void> register(PluginRegistry registry) {
    registry
      ..registerWarningRule(GettersInMemberListRule())
      ..registerWarningRule(SubtypeAnnotatingRule())
      ..registerWarningRule(SubtypeNamingRule())
      ..registerWarningRule(AnnotateMembersWithRule())
      ..registerWarningRule(InvalidMembersRule())
      ..registerWarningRule(InvalidModifiersRule());
  }
}
