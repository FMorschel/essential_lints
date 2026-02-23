// This code is based on an idea from dart_code_metrics package see
// https://dcm.dev/docs/rules/common/prefer-explicit-parameter-names/.

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template prefer_explicitly_named_parameters}
/// A lint rule that encourages the use of explicitly named parameters
/// in function type declarations for improved code clarity and completion.
/// {@endtemplate}
@staticLoggerEnforcement
class PreferExplicitlyNamedParameterRule
    extends LintRule<PreferExplicitlyNamedParameterRule> {
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
    var visitor = _PreferExplicitlyNamedParametersVisitor(this, context);
    registry.addGenericFunctionType(this, visitor);
  }
}

class _PreferExplicitlyNamedParametersVisitor
    extends BaseVisitor<PreferExplicitlyNamedParameterRule> {
  _PreferExplicitlyNamedParametersVisitor(super.rule, super.context);

  @override
  void visitGenericFunctionType(GenericFunctionType node) {
    logger.info(
      'visitGenericFunctionType() started for: ${node.toSource()}',
    );
    for (var parameter in node.parameters.parameters) {
      if (parameter.isNamed) {
        logger.finer(
          'Skipping named parameter: ${parameter.name?.lexeme ?? "<unnamed>"}',
        );
        continue;
      }
      var name = parameter.name;
      if (name == null || name.lexeme.isEmpty) {
        logger.fine(
          'Reporting unnamed positional parameter in function type: '
          '${node.toSource()}',
        );
        // This should be only a type annotation.
        // ignore: _internal_plugin/report_shorter_lengths
        rule.reportAtNode(parameter);
      }
    }
    logger.info(
      'visitGenericFunctionType() completed for: ${node.toSource()}',
    );
    super.visitGenericFunctionType(node);
  }
}
