import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';

import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template use_defined_type_fix}
/// A fix that changes the type annotation of a closure parameter
/// to use the defined type.
/// {@endtemplate}
class UseDefinedTypeFix extends ResolvedCorrectionProducer with LintFix {
  /// {@macro use_defined_type_fix}
  UseDefinedTypeFix({required super.context});

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintFixes get fix => .useDefinedType;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    if (diagnostic == null) {
      return;
    }
    var functionExpression = node.thisOrAncestorOfType<FunctionExpression>();
    if (functionExpression == null) {
      assert(
        false,
        'How did we get a diagnostic if the node is not inside a '
        'FunctionExpression?',
      );
      return;
    }
    var correspondingParameterType =
        functionExpression.correspondingParameter?.type;
    if (correspondingParameterType is! FunctionType) {
      assert(
        false,
        'How did we get a diagnostic if the type is not a FunctionType?',
      );
      return;
    }
    var parameter = node;
    if (parameter is! NormalFormalParameter) {
      assert(
        false,
        'How did we get a diagnostic if the node is not a '
        'NormalFormalParameter?',
      );
      return;
    }
    if (!parameter.isNamed) {
      var index = functionExpression.parameters?.parameters.indexOf(parameter);
      if (index == null || index < 0) {
        assert(
          false,
          'Where are we looking at? How did the parameter go missing?',
        );
        return;
      }
      var expectedType =
          correspondingParameterType.formalParameters[index].type;
      await builder.addDartFileEdit(file, (builder) {
        builder.addReplacement(
          range.startOffsetEndOffset(
            parameter.offset,
            parameter.name!.offset - 1,
          ),
          (builder) => builder.writeType(expectedType),
        );
      });
    } else {
      var expectedType = correspondingParameterType
          .namedParameterTypes[parameter.name?.lexeme];
      if (expectedType == null) {
        assert(
          false,
          'How did we get a diagnostic if the named parameter type is null?',
        );
        return;
      }
      await builder.addDartFileEdit(file, (builder) {
        builder.addReplacement(
          range.startOffsetEndOffset(
            parameter.offset,
            parameter.name!.offset - 1,
          ),
          (builder) => builder.writeType(expectedType),
        );
      });
    }
  }
}
