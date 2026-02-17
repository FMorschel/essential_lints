// This code is based on an idea from dart_code_metrics package see
// https://dcm.dev/docs/rules/common/prefer-explicit-parameter-names/.

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template prefer_explicitly_named_parameters}
/// A lint rule that encourages the use of explicitly named parameters
/// in function type declarations for improved code clarity and completion.
/// {@endtemplate}
@staticLoggerEnforcement
class PreferExplicitlyNamedParameterRule extends LintRule {
  /// {@macro prefer_explicitly_named_parameters}
  PreferExplicitlyNamedParameterRule()
    : super(.preferExplicitlyNamedParameter, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'PreferExplicitlyNamedParameterRule',
  );

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _PreferExplicitlyNamedParametersVisitor(this);
    registry.addGenericFunctionType(this, visitor);
  }
}

class _PreferExplicitlyNamedParametersVisitor extends SimpleAstVisitor<void> {
  _PreferExplicitlyNamedParametersVisitor(this.rule);

  final PreferExplicitlyNamedParameterRule rule;

  @override
  void visitGenericFunctionType(GenericFunctionType node) {
    rule.logger.info(
      'visitGenericFunctionType() started for: ${node.toSource()}',
    );
    for (var parameter in node.parameters.parameters) {
      if (parameter.isNamed) {
        rule.logger.finer(
          'Skipping named parameter: ${parameter.name?.lexeme ?? "<unnamed>"}',
        );
        continue;
      }
      var name = parameter.name;
      if (name == null || name.lexeme.isEmpty) {
        rule.logger.fine(
          'Reporting unnamed positional parameter in function type: '
          '${node.toSource()}',
        );
        rule.reportAtNode(parameter);
      }
    }
    rule.logger.info(
      'visitGenericFunctionType() completed for: ${node.toSource()}',
    );
    super.visitGenericFunctionType(node);
  }
}
