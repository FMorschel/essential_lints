import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';
import 'package:logging/logging.dart';

import 'plugin_integration.dart';

/// The analysis server plugin for Essential Lints.
class EssentialLintsPlugin extends Plugin
    with
        RulesPluginIntegration,
        FixesPluginIntegration,
        AssistsPluginIntegration,
        WarningsPluginIntegration {
  /// The logger for the Essential Lints plugin.
  static final logger = Logger('EssentialLintsPlugin');

  @override
  String get name => 'essential_lints';

  @override
  void register(PluginRegistry registry) {
    logger.info('Registering Essential Lints plugin');
    registerRules(registry);
    logger
      ..info('Registered rules')
      ..info('Registering warnings');
    registerWarnings(registry);
    logger
      ..info('Registered warnings')
      ..info('Registering fixes');
    registerFixes(registry);
    logger
      ..info('Registered fixes')
      ..info('Registering assists');
    registerAssists(registry);
    logger.info('Registered assists');
  }
}
