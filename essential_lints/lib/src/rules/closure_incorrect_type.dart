import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/src/dart/ast/ast.dart'; // ignore: implementation_imports, not exported
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import '../utils/extensions/ast.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template closure_incorrect_type}
/// Checks for closures that have an incorrect type annotation.
/// {@endtemplate}
@staticLoggerEnforcement
class ClosureIncorrectTypeRule extends LintRule<ClosureIncorrectTypeRule> {
  /// {@macro closure_incorrect_type}
  ClosureIncorrectTypeRule() : super(.closureIncorrectType, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'ClosureIncorrectTypeRule',
  );

  @override
  Visitor<ClosureIncorrectTypeRule, void> visitorFor(RuleContext context) =>
      _ClosureIncorrectTypeVisitor(this, context);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    logger.fine('Registering node processors for ClosureIncorrectTypeRule');
    var visitor = visitorFor(context);
    registry.addFunctionExpression(this, visitor);
    logger.fine('Registered node processors for ClosureIncorrectTypeRule');
  }
}

class _ClosureIncorrectTypeVisitor
    extends BaseVisitor<ClosureIncorrectTypeRule> {
  _ClosureIncorrectTypeVisitor(super.rule, super.context);

  @override
  void visitFunctionExpression(FunctionExpression node) {
    logger.info(
      'ClosureIncorrectTypeRule.visitFunctionExpression() started at offset '
      '${node.offset}',
    );

    var parameters = node.parameters;
    if (parameters == null) {
      logger
        ..finer('FunctionExpression has no parameters, skipping')
        ..info('ClosureIncorrectTypeRule.visitFunctionExpression() completed');
      return;
    }

    var correspondingParameterType = node.correspondingParameter?.type;
    if (correspondingParameterType is! FunctionType) {
      // Skip if the closure is not overriding a parameter with a specific type.
      logger
        ..finer('correspondingParameter is not a FunctionType, skipping')
        ..info('ClosureIncorrectTypeRule.visitFunctionExpression() completed');
      return;
    }

    var index = 0;
    logger.fine(
      'Checking ${parameters.parameters.length} parameters against expected '
      'function type',
    );
    for (var parameter in parameters.parameters) {
      FormalParameter actualParameter;
      if (parameter is DefaultFormalParameter) {
        actualParameter = parameter.parameter;
      } else {
        actualParameter = parameter;
      }
      if (actualParameter is! NormalFormalParameter) {
        logger.finer('Skipping non-NormalFormalParameter');
        continue;
      }
      var actualParameterType = actualParameter.type;
      if (actualParameterType == null) {
        logger.finer('Parameter has no declared type, skipping');
        continue;
      }
      DartType expectedType;
      if (!parameter.isNamed) {
        expectedType = correspondingParameterType.formalParameters[index].type;
        logger.finer(
          'Positional parameter: expected type at index $index is '
          '${expectedType.getDisplayString()}',
        );
        index++;
      } else {
        expectedType = correspondingParameterType.formalParameters
            .firstWhere((e) => e.name == parameter.name?.lexeme && e.isNamed)
            .type;
        logger.finer(
          'Named parameter: expected type for ${parameter.name?.lexeme} is '
          '${expectedType.getDisplayString()}',
        );
      }
      if (expectedType.isDartCoreNull && actualParameterType.isDartCoreObject) {
        // Special case: `Null` can be represented as `Object?` in the closure.
        // See
        // https://github.com/dart-lang/language/blob/master/resources/type-system/inference.md#function-literal-return-type-inference.
        logger.finer('Special-case Null vs Object? mapping — skipping');
        continue;
      }
      if (actualParameterType != expectedType) {
        logger.fine(
          'Type mismatch for parameter: '
          'actual=${actualParameterType.getDisplayString()} '
          'expected=${expectedType.getDisplayString()} — reporting at node',
        );
        var range = actualParameter.typeAnnotationRange;
        if (range == null) {
          logger.warning(
            'No type annotation found for parameter, skipping reporting. How '
            'did we get here?',
          );
          continue;
        }
        rule.reportAtOffset(range.offset, range.length);
      }
    }

    logger.info('ClosureIncorrectTypeRule.visitFunctionExpression() completed');
  }
}
