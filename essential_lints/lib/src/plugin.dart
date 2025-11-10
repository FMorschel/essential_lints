import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';

import 'plugin_integration.dart';

/// The analysis server plugin for Essential Lints.
class EssentialLintsPlugin extends Plugin
    with
        RulesPluginIntegration,
        FixesPluginIntegration,
        AssistsPluginIntegration,
        WarningsPluginIntegration {
  @override
  String get name => 'essential_lints';

  @override
  void register(PluginRegistry registry) {
    registerRules(registry);
    registerWarnings(registry);
    registerFixes(registry);
    registerAssists(registry);
  }
}
