// This code is based on an idea from dart_code_metrics package see
// https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/double_literal_format/double_literal_format_rule.dart.

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import '../utils/double_literal_parser.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template numeric_constant_style}
/// A lint rule that enforces a consistent format for double literals
/// in the codebase.
/// {@endtemplate}
@staticLoggerEnforcement
class NumericConstantStyleRule extends LintRule<NumericConstantStyleRule> {
  /// {@macro numeric_constant_style}
  NumericConstantStyleRule() : super(.numericConstantStyle, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'NumericConstantStyleRule',
  );

  @override
  Visitor<NumericConstantStyleRule, void> visitorFor(RuleContext context) =>
      _NumericConstantStyleVisitor(this, context);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = visitorFor(context);
    registry.addDoubleLiteral(this, visitor);
  }
}

class _NumericConstantStyleVisitor
    extends BaseVisitor<NumericConstantStyleRule> {
  _NumericConstantStyleVisitor(super.rule, super.context);

  @override
  void visitDoubleLiteral(DoubleLiteral node) {
    logger.info('visitDoubleLiteral() started: ${node.literal.lexeme}');
    var parsed = DoubleLiteralParser(node.literal.lexeme);
    logger.finer(
      'Parsed double: isValid=${parsed.isValidDouble}, '
      'hasLeadingZeros=${parsed.hasLeadingZeros}, '
      'hasDecimalPoint=${parsed.hasDecimalPoint}, '
      'hasIntegerPart=${parsed.hasIntegerPart}, '
      'hasTrailingZeros=${parsed.hasTrailingZeros}, '
      'hasExponentLeadingZeros=${parsed.hasExponentLeadingZeros}',
    );

    if (!parsed.isValidDouble) {
      logger.finer('Invalid double literal format — skipping');
      super.visitDoubleLiteral(node);
      return;
    }
    if (parsed.hasLeadingZeros) {
      logger.fine('Reporting: unnecessary leading zeros');
      rule.reportAtNode(node);
    } else if (parsed.hasDecimalPoint && !parsed.hasIntegerPart) {
      logger.fine('Reporting: missing explicit zero before decimal point');
      rule.reportAtNode(node);
    } else if (parsed.hasTrailingZeros) {
      logger.fine('Reporting: trailing zeros after decimal point');
      rule.reportAtNode(node);
    } else if (parsed.hasExponentLeadingZeros) {
      logger.fine('Reporting: leading zeros in exponent');
      rule.reportAtNode(node);
    }
    super.visitDoubleLiteral(node);
  }
}
