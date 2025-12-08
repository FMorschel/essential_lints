import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';

import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template border_radius_all_fix}
/// A fix that replaces BorderRadius.circular with BorderRadius.all.
/// {@endtemplate}
class ReplaceWithBorderRadiusAllFix extends ResolvedCorrectionProducer
    with LintFix {
  /// {@macro border_radius_all_fix}
  ReplaceWithBorderRadiusAllFix({required super.context});

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintFixes get fix => .replaceWithBorderRadiusAll;

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
          'const BorderRadius.all(Radius.circular',
        )
        ..addSimpleInsertion(
          instanceCreation.argumentList.rightParenthesis.offset,
          ')',
        );
    });
  }
}
