// This code is based on an idea from dart_code_metrics package see
// https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/avoid_border_all/avoid_border_all_rule.dart.

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'rule.dart';

/// {@template border_all_rule}
/// A lint rule that checks for the use of `Border.all` in Flutter widgets.
/// {@endtemplate}
class BorderAllRule extends LintRule {
  /// {@macro border_all_rule}
  BorderAllRule() : super(.borderAll);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _BorderAllVisitor(this, context);
    registry.addInstanceCreationExpression(this, visitor);
  }
}

class _BorderAllVisitor extends SimpleAstVisitor<void> {
  _BorderAllVisitor(this.rule, this.context);

  static const _borderName = 'Border';
  static const _allName = 'all';

  static final Uri _boxBorderUri = .parse(
    'package:flutter/src/painting/box_border.dart',
  );

  final BorderAllRule rule;
  final RuleContext context;

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    var element = node.constructorName.element;
    if (element == null ||
        element.enclosingElement.name != _borderName ||
        element.name != _allName ||
        element.library.uri != _boxBorderUri) {
      return;
    }
    rule.reportAtNode(node.constructorName);
  }
}
