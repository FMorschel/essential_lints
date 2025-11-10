import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'rule.dart';

/// {@template prefer_explicitly_named_parameters}
/// A lint rule that encourages the use of explicitly named parameters
/// in function type declarations for improved code clarity and completion.
/// {@endtemplate}
class PreferExplicitlyNamedParameterRule extends LintRule {
  /// {@macro prefer_explicitly_named_parameters}
  PreferExplicitlyNamedParameterRule() : super(.preferExplicitlyNamedParameter);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _PreferExplicitlyNamedParametersVisitor(this);
    registry.addGenericFunctionType(this, visitor);
  }
}

class _PreferExplicitlyNamedParametersVisitor extends SimpleAstVisitor<void> {
  _PreferExplicitlyNamedParametersVisitor(this.rule);

  final PreferExplicitlyNamedParameterRule rule;

  @override
  void visitGenericFunctionType(GenericFunctionType node) {
    for (final parameter in node.parameters.parameters) {
      if (parameter.isNamed) {
        continue;
      }
      var name = parameter.name;
      if (name == null || name.lexeme.isEmpty) {
        rule.reportAtNode(parameter);
      }
    }
    super.visitGenericFunctionType(node);
  }
}
