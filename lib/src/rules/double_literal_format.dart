import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

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

  static final _trailingZeros = RegExp(r'\.[0-9]+0+(e(\+|-)?[0-9]+)?$');

  static final _leadingZerosInExponential = RegExp(r'e(\+|-)?0+[0-9]+$');

  @override
  void visitDoubleLiteral(DoubleLiteral node) {
    var lexeme = node.literal.lexeme;
    if (lexeme.startsWith(RegExp('^0+[0-9]+.'))) {
      // Unnecessary leading zeros
      rule.reportAtNode(node);
    } else if (lexeme.startsWith('.')) {
      // Missing explicit zero in unity
      rule.reportAtNode(node);
    } else if (_trailingZeros.hasMatch(lexeme)) {
      // Trailing zeros after dot
      rule.reportAtNode(node);
    } else if (_leadingZerosInExponential.hasMatch(lexeme)) {
      // Leading zeros in exponential
      rule.reportAtNode(node);
    }
    super.visitDoubleLiteral(node);
  }
}
