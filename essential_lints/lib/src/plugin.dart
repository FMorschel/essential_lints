import 'dart:developer';

import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';
import 'package:logging/logging.dart';

import 'plugin_integration.dart';
import 'utils/extensions/logger.dart';
import 'utils/mode.dart';

/// {@template essential_lints_plugin}
/// The analysis server plugin for Essential Lints.
/// {@endtemplate}
class EssentialLintsPlugin extends Plugin
    with
        RulesPluginIntegration,
        FixesPluginIntegration,
        AssistsPluginIntegration,
        WarningsPluginIntegration {
  /// {@macro essential_lints_plugin}
  EssentialLintsPlugin({this.level = .OFF});

  /// The logging level for the plugin.
  final Level level;

  /// Activates logging for the Essential Lints plugin.
  ///
  /// If [level] is not provided, defaults to [Level.ALL]. If [level] is
  /// provided, sets the logger to that level.
  // ignore: use_setters_to_change_properties
  static void activateLogging([Level level = .ALL]) {
    logger.level = level;
  }

  /// Deactivates logging for the Essential Lints plugin.
  static void deactivateLogging() {
    logger.level = Level.OFF;
  }

  /// The logger for the Essential Lints plugin.
  static final Logger logger = Logger('EssentialLintsPlugin');

  /// Creates a new logger with the given [name] as a child of the plugin's
  /// logger.
  static Logger newLogger(String name) => logger.newChild(name);

  @override
  String get name => 'essential_lints';

  @override
  void start() {
    hierarchicalLoggingEnabled = true;
    logger
      ..level = level
      ..onRecord.listen(_printLogRecord)
      ..info('Starting Essential Lints plugin');
  }

  @override
  void shutDown() {
    logger.info('Shutting down Essential Lints plugin');
  }

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

  static void _printLogRecord(LogRecord event) {
    if (Mode.current.isDebug) {
      log(
        event.message,
        time: event.time,
        sequenceNumber: event.sequenceNumber,
        level: event.level.value,
        name: event.loggerName,
        zone: event.zone,
        error: event.error,
        stackTrace: event.stackTrace,
      );
    }
  }
}

/// Extension on [EssentialLintsPlugin] to provide easy access to the logger.
extension LoggerExtension on EssentialLintsPlugin {
  /// The logger for the Essential Lints plugin.
  Logger get logger => EssentialLintsPlugin.logger;

  /// Activates logging for the Essential Lints plugin.
  ///
  /// If [level] is not provided, defaults to [Level.ALL]. If [level] is
  /// provided, sets the logger to that level.
  // ignore: use_setters_to_change_properties
  void activateLogging([Level level = Level.ALL]) {
    logger.level = level;
  }

  /// Deactivates logging for the Essential Lints plugin.
  void deactivateLogging() {
    logger.level = Level.OFF;
  }

  /// Creates a new logger with the given [name] as a child of the plugin's
  /// logger.
  Logger newLogger(String name) => logger.newChild(name);
}
