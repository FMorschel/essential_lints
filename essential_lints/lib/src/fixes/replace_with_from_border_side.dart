import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';

import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template replace_with_from_border_side_fix}
/// A fix that replaces `Border.all` with `Border.fromBorderSide`.
/// {@endtemplate}
class ReplaceWithFromBorderSideFix extends LintFix {
  /// {@macro replace_with_from_border_side_fix}
  ReplaceWithFromBorderSideFix({required super.context});

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintFixes get fix => .replaceWithFromBorderSide;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    if (diagnostic == null) return;
    var node = this.node;
    if (node is! ConstructorName) return;
    var instanceCreation = node.parent;
    if (instanceCreation is! InstanceCreationExpression) return;
    await builder.addDartFileEdit(file, (builder) {
      builder
        ..addSimpleReplacement(
          range.node(node),
          'const Border.fromBorderSide(BorderSide',
        )
        ..addSimpleInsertion(
          instanceCreation.argumentList.rightParenthesis.offset,
          ')',
        );
    });
  }
}
