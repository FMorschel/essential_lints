import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/src/dart/ast/ast.dart'; // ignore: implementation_imports, not exported

import 'rule.dart';

/// {@template closure_incorrect_type}
/// Checks for closures that have an incorrect type annotation.
/// {@endtemplate}
class ClosureIncorrectTypeRule extends LintRule {
  /// {@macro closure_incorrect_type}
  ClosureIncorrectTypeRule() : super(.closureIncorrectType);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _ClosureIncorrectTypeVisitor(this, context);
    registry.addFunctionExpression(this, visitor);
  }
}

class _ClosureIncorrectTypeVisitor extends SimpleAstVisitor<void> {
  _ClosureIncorrectTypeVisitor(this.rule, this.context);

  final ClosureIncorrectTypeRule rule;
  final RuleContext context;

  @override
  void visitFunctionExpression(FunctionExpression node) {
    var parameters = node.parameters;
    if (parameters == null) {
      return;
    }
    var correspondingParameterType = node.correspondingParameter?.type;
    if (correspondingParameterType is! FunctionType) {
      // Skip if the closure is not overriding a parameter with a specific type.
      return;
    }
    var index = 0;
    for (var parameter in parameters.parameters) {
      FormalParameter actualParameter;
      if (parameter is DefaultFormalParameter) {
        actualParameter = parameter.parameter;
      } else {
        actualParameter = parameter;
      }
      if (actualParameter is! NormalFormalParameter) {
        continue;
      }
      var actualParameterType =
          actualParameter.type ?? context.typeProvider.objectQuestionType;
      DartType expectedType;
      if (!parameter.isNamed) {
        expectedType = correspondingParameterType.formalParameters[index].type;
        index++;
      } else {
        expectedType = correspondingParameterType.formalParameters
            .firstWhere((e) => e.name == parameter.name?.lexeme && e.isNamed)
            .type;
      }
      if (actualParameterType != expectedType) {
        rule.reportAtNode(actualParameter);
      }
    }
  }
}

extension on NormalFormalParameter {
  DartType? get type => declaredFragment?.element.type;
}
