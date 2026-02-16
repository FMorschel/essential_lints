import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../rules/analysis_rule.dart';
import '../utils/double_literal_parser.dart';
import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template numeric_constant_style}
/// A fix that formats double literals to adhere to a consistent style.
/// {@endtemplate}
@staticLoggerEnforcement
class NumericConstantStyleFix extends CorrectionProducerLogger with LintFix {
  /// {@macro numeric_constant_style}
  NumericConstantStyleFix({required super.context}) : super(_logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'NumericConstantStyleFix',
  );

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintFixes get fix => .numericConstantStyle;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    logger.info('NumericConstantStyleFix.compute() started');
    var node = this.node;
    logger.finer('Node type: ${node.runtimeType}');
    if (node is! DoubleLiteral) {
      logger.finer('Node is not DoubleLiteral, returning');
      return;
    }
    logger.fine('Node is DoubleLiteral: ${node.literal.lexeme}');
    var parsed = DoubleLiteralParser(node.literal.lexeme);
    logger.fine(
      'Parsed literal: '
      'hasIntegerPart=${parsed.hasIntegerPart}, '
      'hasLeadingZeros=${parsed.hasLeadingZeros}, '
      'hasTrailingZeros=${parsed.hasTrailingZeros}, '
      'hasExponentLeadingZeros=${parsed.hasExponentLeadingZeros}',
    );
    if (parsed.hasIntegerPart &&
        !parsed.hasLeadingZeros &&
        !parsed.hasTrailingZeros &&
        !parsed.hasExponentLeadingZeros) {
      // No fix needed
      logger.fine('No fixes needed for this literal, returning');
      return;
    }
    logger.fine('Literal requires formatting');
    // Remove the unnecessary zeros:
    var buffer = StringBuffer();
    if (!parsed.hasIntegerPart) {
      logger.finer('Missing integer part, adding leading 0');
      buffer.write('0');
    }
    buffer
      ..write(parsed.relevantNumber)
      ..write(parsed.exponent)
      ..write(parsed.exponentNumber);
    var fixedLexeme = buffer.toString();
    logger.fine('Original: ${node.literal.lexeme}, Fixed: $fixedLexeme');
    await builder.addDartFileEdit(file, (builder) {
      logger.finer('Applying replacement');
      builder.addSimpleReplacement(range.token(node.literal), fixedLexeme);
    });
    logger.info('NumericConstantStyleFix.compute() completed successfully');
  }
}
