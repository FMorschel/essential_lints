// This code is based on an idea from dart_code_metrics package see
// https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/prefer_const_border_radius/prefer_const_border_radius_rule.dart

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'rule.dart';

/// {@template border_radius_all_rule}
/// A lint rule that checks for the use of BorderRadius.circular and suggests
/// using BorderRadius.all instead.
/// {@endtemplate}
class BorderRadiusAllRule extends LintRule {
  /// {@macro border_radius_all_rule}
  BorderRadiusAllRule() : super(.borderRadiusAll);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _BorderRadiusAllVisitor(this, context);
    registry.addInstanceCreationExpression(this, visitor);
  }
}

class _BorderRadiusAllVisitor extends SimpleAstVisitor<void> {
  _BorderRadiusAllVisitor(this.rule, this.context);

  static const _borderRadiusName = 'BorderRadius';
  static const _circularName = 'circular';

  static final Uri _borderRadiusUri = .parse(
    'package:flutter/src/painting/border_radius.dart',
  );

  final BorderRadiusAllRule rule;
  final RuleContext context;

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    var element = node.constructorName.element;
    if (element == null ||
        element.enclosingElement.name != _borderRadiusName ||
        element.name != _circularName ||
        element.library.uri != _borderRadiusUri) {
      return;
    }
    rule.reportAtNode(node.constructorName);
  }
}
