import 'package:analyzer/dart/constant/value.dart';

import 'extensions/list.dart';

/// Converts a [DartObject] to its string representation.
String dartObjectToString(DartObject? dartObject) {
  if (dartObject == null || dartObject.isNull) {
    return 'null';
  } else if (dartObject.toTypeValue() case var type?) {
    return type.getDisplayString();
  } else if (dartObject.constructorInvocation case var constructor?) {
    return "'${constructor.constructor.displayName}("
        '${constructor.positionalArguments // formatting trick
        .map(dartObjectToString).join(', ')}'
        '${constructor.positionalArguments.isNotEmpty && // formatting trick
                constructor.namedArguments.isNotEmpty ? ', ' : ''}'
        '${constructor.namedArguments.entries // formatting trick
        .map((entry) => '${entry.key}: ${dartObjectToString(entry.value)}')
        // formatting trick
        .join(', ')}'
        ")'";
  } else if (dartObject.toDoubleValue() case var doubleValue?) {
    return '$doubleValue';
  } else if (dartObject.toIntValue() case var intValue?) {
    return '$intValue';
  } else if (dartObject.toStringValue() case var stringValue?) {
    return "'$stringValue'";
  } else if (dartObject.toBoolValue() case var boolValue?) {
    return '$boolValue';
  } else if (dartObject.variable case var variable?) {
    return variable.displayName;
  } else if (dartObject.toListValue() case var listValue?) {
    return '[${listValue.map(dartObjectToString).commaSeparated}]';
  } else if (dartObject.toSymbolValue() case var symbol?) {
    return symbol;
  } else if (dartObject.toMapValue() case var mapValue?) {
    var entries = mapValue.entries
        .map(
          (entry) =>
              '${dartObjectToString(entry.key)}: '
              '${dartObjectToString(entry.value)}',
        )
        .commaSeparated;
    return '{$entries}';
  } else if (dartObject.toSetValue() case var setValue?) {
    return '{${setValue.map(dartObjectToString).commaSeparated}}';
  } else if (dartObject.toRecordValue() case var recordValue?) {
    var positional = recordValue.positional
        .map(dartObjectToString)
        .commaSeparated;
    var named = recordValue.named.entries
        .map((entry) => '${entry.key}: ${dartObjectToString(entry.value)}')
        .commaSeparated;
    return '(${[
      if (positional.isNotEmpty) positional,
      if (named.isNotEmpty) named,
    ].commaSeparated})';
  }
  return dartObject.toString();
}
