import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:collection/collection.dart';

import '../utils/extensions/element.dart';
import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template use_padding_property_fix}
/// A fix that converts a Container with wrapping Padding to use the
/// padding property.
/// {@endtemplate}
class UsePaddingPropertyFix extends ResolvedCorrectionProducer with LintFix {
  /// {@macro use_padding_property_fix}
  UsePaddingPropertyFix({required super.context});

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintFixes get fix => .usePaddingProperty;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    var diagnostic = this.diagnostic;
    if (diagnostic == null) {
      return;
    }
    var node = this.node;
    SourceRange originalRange;
    ArgumentList arguments;
    if (node.parent case ConstructorName(
      parent: InstanceCreationExpression(:var argumentList) && var creation,
    ) when creation.constructorName.type.element.isPadding) {
      originalRange = range.node(creation);
      arguments = argumentList;
    } else {
      return;
    }
    if (arguments.arguments.isEmpty) {
      return;
    }
    var paddingArgument = arguments.arguments.firstWhereOrNull(
      _namedPaddingArgument,
    );
    if (paddingArgument is! NamedExpression) {
      return;
    }
    var childArgument = arguments.arguments.firstWhereOrNull((argument) {
      if (argument case NamedExpression(:var name)) {
        return name.label.name == 'child';
      }
      return false;
    });
    if (childArgument is! NamedExpression) {
      return;
    }
    if (childArgument case NamedExpression(:var expression)) {
      if (expression is! InstanceCreationExpression ||
          !expression.constructorName.type.element.isContainer) {
        return;
      }
      arguments = expression.argumentList;
      if (arguments.arguments.any(_namedPaddingArgument)) {
        // Already has a padding property.
        return;
      }
    }
    String? source;
    var indent = utils.getNodePrefix(node);
    if (arguments.arguments.isNotEmpty) {
      var offset = arguments.arguments.first.offset;
      var end = arguments.arguments.last.end;
      source =
          '$indent${utils.oneIndent}${utils.indentSourceLeftRight(
            utils.getText(
              offset,
              end - offset,
            ),
          ).trimRight()},';
    }
    var paddingSource = utils.getNodeText(paddingArgument);
    await builder.addDartFileEdit(file, (builder) {
      builder.addReplacement(originalRange, (builder) {
        builder
          ..writeln('Container(')
          ..writeln('$indent${utils.oneIndent}$paddingSource,');
        if (source != null) {
          builder.writeln(source);
        }
        builder.write('$indent)');
      });
    });
  }

  bool _namedPaddingArgument(Expression argument) {
    if (argument case NamedExpression(:var name)) {
      return name.label.name == 'padding';
    }
    return false;
  }
}
