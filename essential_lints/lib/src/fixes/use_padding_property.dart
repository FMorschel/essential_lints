import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../rules/analysis_rule.dart';
import '../utils/extensions/element.dart';
import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template use_padding_property_fix}
/// A fix that converts a Container with wrapping Padding to use the
/// padding property.
/// {@endtemplate}
@staticLoggerEnforcement
class UsePaddingPropertyFix extends CorrectionProducerLogger with LintFix {
  /// {@macro use_padding_property_fix}
  UsePaddingPropertyFix({required super.context}) : super(_logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'UsePaddingPropertyFix',
  );

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintFixes get fix => .usePaddingProperty;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    logger.info('UsePaddingPropertyFix.compute() started');
    var diagnostic = this.diagnostic;
    if (diagnostic == null) {
      logger.finer('Diagnostic is null, returning');
      return;
    }
    logger.fine('Diagnostic found');
    var node = this.node;
    logger.finer('Node type: ${node.runtimeType}');
    SourceRange originalRange;
    ArgumentList arguments;
    if (node.parent case ConstructorName(
      parent: InstanceCreationExpression(:var argumentList) && var creation,
    ) when creation.constructorName.type.element.isPadding) {
      logger.fine('Node parent is Padding InstanceCreationExpression');
      originalRange = range.node(creation);
      arguments = argumentList;
    } else {
      logger.finer('Node parent pattern did not match Padding, returning');
      return;
    }
    logger.fine('Found Padding with ${arguments.arguments.length} arguments');
    if (arguments.arguments.isEmpty) {
      logger.finer('Padding has no arguments, returning');
      return;
    }
    var paddingArgument = arguments.arguments.firstWhereOrNull(
      _namedPaddingArgument,
    );
    logger.finer('Found paddingArgument: ${paddingArgument.runtimeType}');
    if (paddingArgument is! NamedExpression) {
      logger.finer('paddingArgument is not NamedExpression, returning');
      return;
    }
    logger.fine('paddingArgument is NamedExpression: padding=...');
    var childArgument = arguments.arguments.firstWhereOrNull((argument) {
      if (argument case NamedExpression(:var name)) {
        return name.label.name == 'child';
      }
      return false;
    });
    logger.finer('Found childArgument: ${childArgument.runtimeType}');
    if (childArgument is! NamedExpression) {
      logger.finer('childArgument is not NamedExpression, returning');
      return;
    }
    logger.fine('childArgument is NamedExpression: child=...');
    if (childArgument case NamedExpression(:var expression)) {
      logger.finer('Child expression type: ${expression.runtimeType}');
      if (expression is! InstanceCreationExpression ||
          !expression.constructorName.type.element.isContainer) {
        logger.finer(
          'Child is not a Container InstanceCreationExpression, returning',
        );
        return;
      }
      logger.fine('Child is Container InstanceCreationExpression');
      arguments = expression.argumentList;
      logger.finer('Container has ${arguments.arguments.length} arguments');
      if (arguments.arguments.any(_namedPaddingArgument)) {
        logger.fine('Container already has a padding property, returning');
        // Already has a padding property.
        return;
      }
      logger.fine('Container does not have padding property');
    }
    String? source;
    var indent = utils.getNodePrefix(node);
    logger.finer('Indent: ${indent.replaceAll('\n', r'\n')}');
    if (arguments.arguments.isNotEmpty) {
      logger.fine(
        'Building source from ${arguments.arguments.length} container '
        'arguments',
      );
      var offset = arguments.arguments.first.offset;
      var end = arguments.arguments.last.end;
      source =
          '$indent${utils.oneIndent}${utils.indentSourceLeftRight(
            utils.getText(
              offset,
              end - offset,
            ),
          ).trimRight()},';
      logger.finer('Built source: ${source.replaceAll('\n', ' ')}');
    } else {
      logger.finer('Container has no arguments, source will be null');
    }
    var paddingSource = utils.getNodeText(paddingArgument);
    logger.fine('Padding source: ${paddingSource.replaceAll('\n', ' ')}');
    await builder.addDartFileEdit(file, (builder) {
      logger.finer('Applying Container transformation');
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
    logger.info('UsePaddingPropertyFix.compute() completed successfully');
  }

  bool _namedPaddingArgument(Expression argument) {
    if (argument case NamedExpression(:var name)) {
      var isPadding = name.label.name == 'padding';
      if (isPadding) {
        logger.finer('  Found padding argument');
      }
      return isPadding;
    }
    return false;
  }
}
