import 'package:logging/logging.dart';

/// Extensions for the [Logger] class.
extension LoggerExt on Logger {
  /// Creates a new child logger with the given [name].
  Logger newChild(String name) => Logger('$fullName.$name');
}
