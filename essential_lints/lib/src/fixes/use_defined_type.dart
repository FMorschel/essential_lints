import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../rules/analysis_rule.dart';
import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template use_defined_type_fix}
/// A fix that changes the type annotation of a closure parameter
/// to use the defined type.
/// {@endtemplate}
@staticLoggerEnforcement
class UseDefinedTypeFix extends CorrectionProducerLogger with LintFix {
  /// {@macro use_defined_type_fix}
  UseDefinedTypeFix({required super.context}) : super(_logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'UseDefinedTypeFix',
  );

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintFixes get fix => .useDefinedType;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    logger.info('UseDefinedTypeFix.compute() started');
    if (diagnostic == null) {
      logger.finer('Diagnostic is null, returning');
      return;
    }
    logger.fine('Diagnostic found');
    var functionExpression = node.thisOrAncestorOfType<FunctionExpression>();
    if (functionExpression == null) {
      logger.finer('No FunctionExpression ancestor found, returning');
      assert(
        false,
        'How did we get a diagnostic if the node is not inside a '
        'FunctionExpression?',
      );
      return;
    }
    logger.fine('Found FunctionExpression');
    var correspondingParameterType =
        functionExpression.correspondingParameter?.type;
    logger.finer(
      'correspondingParameter type: ${correspondingParameterType.runtimeType}',
    );
    if (correspondingParameterType is! FunctionType) {
      logger.finer('correspondingParameterType is not FunctionType, returning');
      assert(
        false,
        'How did we get a diagnostic if the type is not a FunctionType?',
      );
      return;
    }
    logger.fine('correspondingParameterType is FunctionType');
    var parameter = node;
    logger.finer('Node type: ${parameter.runtimeType}');
    if (parameter is! NormalFormalParameter) {
      logger.finer('Node is not NormalFormalParameter, returning');
      assert(
        false,
        'How did we get a diagnostic if the node is not a '
        'NormalFormalParameter?',
      );
      return;
    }
    logger.fine(
      'Node is NormalFormalParameter: ${parameter.name?.lexeme ?? "?"}',
    );
    if (!parameter.isNamed) {
      logger.fine('Parameter is positional');
      var index = functionExpression.parameters?.parameters.indexOf(parameter);
      logger.finer('Parameter index in function: $index');
      if (index == null || index < 0) {
        logger.finer('Parameter index is invalid, returning');
        assert(
          false,
          'Where are we looking at? How did the parameter go missing?',
        );
        return;
      }
      var expectedType =
          correspondingParameterType.formalParameters[index].type;
      logger.fine(
        'Expected type for positional parameter $index: $expectedType',
      );
      await builder.addDartFileEdit(file, (builder) {
        logger.finer('Applying type replacement for positional parameter');
        builder.addReplacement(
          range.startOffsetEndOffset(
            parameter.offset,
            parameter.name!.offset - 1,
          ),
          (builder) => builder.writeType(expectedType),
        );
      });
    } else {
      logger.fine('Parameter is named: ${parameter.name?.lexeme}');
      var expectedType = correspondingParameterType
          .namedParameterTypes[parameter.name?.lexeme];
      logger.finer('Expected type for named parameter: $expectedType');
      if (expectedType == null) {
        logger.finer('Expected type is null for named parameter, returning');
        assert(
          false,
          'How did we get a diagnostic if the named parameter type is null?',
        );
        return;
      }
      await builder.addDartFileEdit(file, (builder) {
        logger.finer('Applying type replacement for named parameter');
        builder.addReplacement(
          range.startOffsetEndOffset(
            parameter.offset,
            parameter.name!.offset - 1,
          ),
          (builder) => builder.writeType(expectedType),
        );
      });
    }
    logger.info('UseDefinedTypeFix.compute() completed successfully');
  }
}
