// This code is based on an idea from dart_code_metrics package see
// https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/avoid_wrapping_in_padding/avoid_wrapping_in_padding_rule.dart.

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/extensions/element.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template padding_over_container_rule}
/// A rule that prevents using Padding widget over Container widget.
/// {@endtemplate}
@staticLoggerEnforcement
class PaddingOverContainerRule extends LintRule {
  /// {@macro padding_over_container_rule}
  PaddingOverContainerRule() : super(.paddingOverContainer, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'PaddingOverContainerRule',
  );

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
    rule.logger.info(
      'visitInstanceCreationExpression() started: '
      '${node.constructorName.toSource()}',
    );
    if (node.constructorName.type.element.isPadding) {
      rule.logger.finer('Found Padding constructor, checking arguments');
      var argumentList = node.argumentList;
      for (var argument in argumentList.arguments) {
        if (argument is NamedExpression && argument.name.label.name == _child) {
          var expression = argument.expression;
          rule.logger.finer('Found child argument: ${expression.runtimeType}');
          if (expression is InstanceCreationExpression &&
              expression.constructorName.type.element.isContainer) {
            rule.logger.fine(
              'Reporting Padding over Container at token: '
              '${node.constructorName.type.name}',
            );
            rule.reportAtToken(node.constructorName.type.name);
          } else {
            rule.logger.finer(
              'Child expression is not a Container instance — no report',
            );
          }
        }
      }
    } else {
      rule.logger.finer('Instance creation is not Padding — skipping');
    }
    super.visitInstanceCreationExpression(node);
  }
}
