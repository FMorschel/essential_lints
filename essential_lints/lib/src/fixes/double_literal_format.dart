import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';

import '../utils/double_literal_parser.dart';
import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template double_literal_format}
/// A fix that formats double literals to adhere to a consistent style.
/// {@endtemplate}
class DoubleLiteralFormatFix extends Fix {
  /// {@macro double_literal_format}
  DoubleLiteralFormatFix({required super.context});

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintFixes get fix => .doubleLiteralFormat;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    var node = this.node;
    if (node is! DoubleLiteral) {
      return;
    }
    var parsed = DoubleLiteralParser(node.literal.lexeme);
    if (parsed.hasIntegerPart &&
        !parsed.hasLeadingZeros &&
        !parsed.hasTrailingZeros &&
        !parsed.hasExponentLeadingZeros) {
      // No fix needed
      return;
    }
    // Remove the unnecessary zeros:
    var buffer = StringBuffer();
    if (!parsed.hasIntegerPart) {
      buffer.write('0');
    }
    buffer
      ..write(parsed.relevantNumber)
      ..write(parsed.exponent)
      ..write(parsed.exponentNumber);
    var fixedLexeme = buffer.toString();
    await builder.addDartFileEdit(file, (builder) {
      builder.addSimpleReplacement(range.token(node.literal), fixedLexeme);
    });
  }
}
