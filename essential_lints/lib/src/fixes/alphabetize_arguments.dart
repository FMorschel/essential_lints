import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../rules/analysis_rule.dart';
import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template alphabetize_arguments}
/// A fix that alphabetizes arguments in function, method, or constructor calls.
/// {@endtemplate}
@staticLoggerEnforcement
class AlphabetizeArgumentsFix extends CorrectionProducerLogger with LintFix {
  /// {@macro alphabetize_arguments}
  AlphabetizeArgumentsFix({required super.context}) : super(_logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'AlphabetizeArgumentsFix',
  );

  @override
  CorrectionApplicability get applicability => .singleLocation;

  @override
  EssentialLintFixes get fix => .alphabetizeArguments;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    logger.info('AlphabetizeArgumentsFix.compute() started');
    var node = this.node;
    logger.finer('Initial node type: ${node.runtimeType}');
    if (node.parent case Label parent) {
      logger.finer('Node parent is Label, updating node');
      node = parent;
    }
    if (node.parent case NamedExpression(:ArgumentList parent)) {
      logger.finer(
        'Node parent is NamedExpression with ArgumentList parent, updating '
        'node',
      );
      node = parent;
    }
    if (node is! ArgumentList) {
      logger.finer(
        'Final node is not ArgumentList (${node.runtimeType}), returning',
      );
      return;
    }
    logger.fine('Node is ArgumentList');
    var ranges = <SourceRange>[];
    var namedArguments = node.arguments.whereType<NamedExpression>().toList();
    logger.fine('Found ${namedArguments.length} named arguments');
    for (var argument in namedArguments) {
      ranges.add(range.node(argument));
    }
    namedArguments.sort((a, b) {
      return a.name.label.name.compareTo(b.name.label.name);
    });
    logger.fine('Named arguments sorted alphabetically');
    await builder.addDartFileEdit(file, (builder) {
      logger.finer('Applying ${ranges.length} replacements');
      for (var i = 0; i < ranges.length; i++) {
        builder.addReplacement(ranges[i], (builder) {
          builder.write(namedArguments[i].toSource());
        });
      }
    });
    logger.info('AlphabetizeArgumentsFix.compute() completed successfully');
  }
}
