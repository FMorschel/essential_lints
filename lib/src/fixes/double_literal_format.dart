import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';

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

  static final _regexp = RegExp(
    r'^(0+)?(([0-9]*)\.(([0-9]*[1-9])|0))(0+)?((e(\+|-)?)(0+)?([0-9]+))?$',
  );

  static const _leadingZeroGroup = 1;
  static const _relevantNumberGroup = 2;
  static const _integerPartGroup = 3;
  static const _trailingZeroGroup = 6;
  static const _exponentGroup = 8;
  static const _exponentLeadingZeroGroup = 10;
  static const _exponentNumberGroup = 11;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    var node = this.node;
    if (node is! DoubleLiteral) {
      return;
    }
    var lexeme = node.literal.lexeme;
    var match = _regexp.firstMatch(lexeme);
    if (match == null) {
      assert(false, 'No match found for double literal: $lexeme');
      return;
    }
    if (match
        .groups([
          _leadingZeroGroup,
          _integerPartGroup,
          _trailingZeroGroup,
          _exponentLeadingZeroGroup,
        ])
        .every((group) => group == null)) {
      // No fix needed
      return;
    }
    // Remove the unnecessary zeros:
    var buffer = StringBuffer();
    if (match.group(_integerPartGroup) case var intPart
        when intPart == null || intPart.isEmpty) {
      buffer.write('0');
    }
    buffer
      ..write(match.group(_relevantNumberGroup))
      ..write(match.group(_exponentGroup) ?? '')
      ..write(match.group(_exponentNumberGroup) ?? '');
    var fixedLexeme = buffer.toString();
    await builder.addDartFileEdit(file, (builder) {
      builder.addSimpleReplacement(range.token(node.literal), fixedLexeme);
    });
  }
}
