import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../utils/double_literal_parser.dart';
import 'rule.dart';

/// {@template double_literal_format}
/// A lint rule that enforces a consistent format for double literals
/// in the codebase.
/// {@endtemplate}
class DoubleLiteralFormatRule extends Rule {
  /// {@macro double_literal_format}
  DoubleLiteralFormatRule() : super(.doubleLiteralFormat);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _DoubleLiteralFormatVisitor(this);
    registry.addDoubleLiteral(this, visitor);
  }
}

class _DoubleLiteralFormatVisitor extends SimpleAstVisitor<void> {
  _DoubleLiteralFormatVisitor(this.rule);

  final DoubleLiteralFormatRule rule;

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
