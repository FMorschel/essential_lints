import 'package:essential_lints/src/plugin.dart';
import 'package:logging/logging.dart';

void enableLogging([Level level = .ALL]) {
  // Set up logging to print to console
  hierarchicalLoggingEnabled = true;
  EssentialLintsPlugin.logger.level = level;
  EssentialLintsPlugin.logger.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}
