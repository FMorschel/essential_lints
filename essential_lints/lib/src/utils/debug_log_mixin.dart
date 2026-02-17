import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:logging/logging.dart';

import '../plugin.dart';
import 'mode.dart';

/// Mixin to provide logging capabilities to the plugin, which can be used in
/// future releases to log various information during lint analysis, fixes and
/// assists.
mixin class DebugLogMixin {
  /// The path to the log file. If null, logs will be printed to the console.
  String? get logFilePath => null;

  IOSink? _sink;

  /// Sets up the logging listener for the plugin. If [root] is true, it sets
  /// the listener on the root logger, otherwise it sets it on the plugin's
  /// logger.
  StreamSubscription<LogRecord> setLogListener({
    Level level = .OFF,
    bool root = false,
  }) {
    _sink = logFilePath != null
        ? File(logFilePath!).openWrite(mode: FileMode.append)
        : null;
    hierarchicalLoggingEnabled = !root;
    var logger = root ? Logger.root : EssentialLintsPlugin.logger
      // Set the logging level.
      ..level = level;
    return logger.onRecord.listen(_listener);
  }

  Future<void> _listener(LogRecord record) async {
    if (logFilePath case var _? when !Mode.current.isDebug) {
      var buffer = StringBuffer()
        ..write('[${record.level.name}]')
        ..write(' ${record.loggerName}')
        ..write(' (${record.time}):')
        ..write(' ${record.message}');
      if (record.error != null) {
        buffer.write(' ${record.error}');
      }
      if (record.stackTrace != null) {
        buffer.write(' ${record.stackTrace}');
      }
      if (record.zone != null) {
        buffer.write(' ${record.zone}');
      }
      await _writeToFile(buffer.toString());
    } else {
      // If no log file path is provided, print to console.
      log(
        record.message,
        time: record.time,
        zone: record.zone,
        error: record.error,
        name: record.loggerName,
        level: record.level.value,
        stackTrace: record.stackTrace,
        sequenceNumber: record.sequenceNumber,
      );
    }
  }

  Future<void> _writeToFile(String event) async {
    _sink?.writeln(event);
  }
}
