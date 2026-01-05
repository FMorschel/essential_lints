// This code is based on an idea from dart_code_metrics package see
// https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/avoid_wrapping_in_padding/avoid_wrapping_in_padding_rule.dart.

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../utils/extensions/element.dart';
import 'rule.dart';

/// {@template padding_over_container_rule}
/// A rule that prevents using Padding widget over Container widget.
/// {@endtemplate}
class PaddingOverContainerRule extends LintRule {
  /// {@macro padding_over_container_rule}
  PaddingOverContainerRule() : super(.paddingOverContainer);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _PaddingOverContainerVisitor(this, context);
    registry.addInstanceCreationExpression(this, visitor);
  }
}

class _PaddingOverContainerVisitor extends SimpleAstVisitor<void> {
  _PaddingOverContainerVisitor(this.rule, this.context);

  static const _child = 'child';

  PaddingOverContainerRule rule;
  RuleContext context;

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    if (node.constructorName.type.element.isPadding) {
      var argumentList = node.argumentList;
      for (var argument in argumentList.arguments) {
        if (argument is NamedExpression && argument.name.label.name == _child) {
          var expression = argument.expression;
          if (expression is InstanceCreationExpression &&
              expression.constructorName.type.element.isContainer) {
            rule.reportAtToken(node.constructorName.type.name);
          }
        }
      }
    }
    super.visitInstanceCreationExpression(node);
  }
}
