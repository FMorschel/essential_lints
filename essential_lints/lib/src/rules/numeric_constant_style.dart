// This code is based on an idea from dart_code_metrics package see
// https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/double_literal_format/double_literal_format_rule.dart.

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../utils/double_literal_parser.dart';
import 'rule.dart';

/// {@template numeric_constant_style}
/// A lint rule that enforces a consistent format for double literals
/// in the codebase.
/// {@endtemplate}
class NumericConstantStyleRule extends LintRule {
  /// {@macro numeric_constant_style}
  NumericConstantStyleRule() : super(.numericConstantStyle);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _NumericConstantStyleVisitor(this);
    registry.addDoubleLiteral(this, visitor);
  }
}

class _NumericConstantStyleVisitor extends SimpleAstVisitor<void> {
  _NumericConstantStyleVisitor(this.rule);

  final NumericConstantStyleRule rule;

  @override
  void visitDoubleLiteral(DoubleLiteral node) {
    var parsed = DoubleLiteralParser(node.literal.lexeme);
    if (!parsed.isValidDouble) {
      // Must have either decimal point or exponent
      super.visitDoubleLiteral(node);
      return;
    }
    if (parsed.hasLeadingZeros) {
      // Unnecessary leading zeros
      rule.reportAtNode(node);
    } else if (parsed.hasDecimalPoint && !parsed.hasIntegerPart) {
      // Missing explicit zero in unity
      rule.reportAtNode(node);
    } else if (parsed.hasTrailingZeros) {
      // Trailing zeros after dot
      rule.reportAtNode(node);
    } else if (parsed.hasExponentLeadingZeros) {
      // Leading zeros in exponential
      rule.reportAtNode(node);
    }
    super.visitDoubleLiteral(node);
  }
}
