import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';

import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template alphabetize_arguments}
/// A fix that alphabetizes arguments in function, method, or constructor calls.
/// {@endtemplate}
class AlphabetizeArgumentsFix extends ResolvedCorrectionProducer with LintFix {
  /// {@macro alphabetize_arguments}
  AlphabetizeArgumentsFix({required super.context});

  @override
  CorrectionApplicability get applicability => .singleLocation;

  @override
  EssentialLintFixes get fix => .alphabetizeArguments;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    var node = this.node;
    if (node.parent case Label parent) {
      node = parent;
    }
    if (node.parent case NamedExpression(:ArgumentList parent)) {
      node = parent;
    }
    if (node is! ArgumentList) return;
    var ranges = <SourceRange>[];
    var namedArguments = node.arguments.whereType<NamedExpression>().toList();
    for (var argument in namedArguments) {
      ranges.add(range.node(argument));
    }
    namedArguments.sort((a, b) {
      return a.name.label.name.compareTo(b.name.label.name);
    });
    await builder.addDartFileEdit(file, (builder) {
      for (var i = 0; i < ranges.length; i++) {
        builder.addReplacement(ranges[i], (builder) {
          builder.write(namedArguments[i].toSource());
        });
      }
    });
  }
}
