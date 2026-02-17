import 'package:essential_lints/src/utils/debug_log_mixin.dart';
import 'package:logging/logging.dart';

void enableLogging([Level level = .ALL]) {
  // Set up logging to print to console
  DebugLogMixin().setLogListener(level: level);
}
