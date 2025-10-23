import 'dart:async';

import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';

import 'rules/alphabetize_arguments.dart';

/// The analysis server plugin for Essential Lints.
class EssentialLintsPlugin extends Plugin {
  @override
  String get name => 'essential_lints';

  @override
  FutureOr<void> register(PluginRegistry registry) {
    registry.registerLintRule(AlphabetizeArguments());
  }
}
