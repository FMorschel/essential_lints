import 'dart:async';

import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';

import 'rules/invalid_members.dart';
import 'rules/invalid_modifiers.dart';

class Internal extends Plugin {
  @override
  String get name => '_internal';

  @override
  FutureOr<void> register(PluginRegistry registry) {
    registry
      ..registerWarningRule(InvalidMembersRule())
      ..registerWarningRule(InvalidModifiersRule());
  }
}
