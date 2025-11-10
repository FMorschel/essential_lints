import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';

import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template remove_expression_fix}
/// A fix that removes an expression from the code.
/// {@endtemplate}
class RemoveExpressionFix extends WarningFix {
  /// {@macro remove_expression_fix}
  RemoveExpressionFix({required super.context});

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintWarningFixes get fix => .removeExpression;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    var node = this.node;
    if (node is! Expression && node is! NullAwareElement) {
      return;
    }
    if (node.parent case NullAwareElement nullAware) {
      node = nullAware;
    }
    SourceRange deletionRange;
    if (node.parent case ExpressionStatement statement) {
      deletionRange = range.node(statement);
    } else if (node.parent case ListLiteral(:var elements)) {
      deletionRange = range.nodeInList(elements, node);
    } else {
      deletionRange = range.node(node);
    }
    await builder.addDartFileEdit(file, (builder) {
      builder.addDeletion(deletionRange);
    });
  }
}
