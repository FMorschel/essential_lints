import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../rules/analysis_rule.dart';
import '../utils/extensions/logger.dart';
import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template sort_enum_constants_fix}
/// A fix that sorts enum constants alphabetically.
/// {@endtemplate}
@staticLoggerEnforcement
class SortEnumConstantsFix extends CorrectionProducerLogger with LintFix {
  /// {@macro sort_enum_constants_fix}
  SortEnumConstantsFix({required super.context}) : super(_logger);

  static final Logger _logger = EssentialLintsPlugin.logger.newChild(
    'SortEnumConstantsFix',
  );

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintFixes get fix => .sortEnumConstants;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    if (diagnostic == null) return;
    var enumDeclaration = node.thisOrAncestorOfType<EnumDeclaration>();
    if (enumDeclaration == null) return;
    await builder.addDartFileEdit(file, (builder) {
      var sortedConstants = enumDeclaration.body.constants.toList()
        ..sort((a, b) => a.name.lexeme.compareTo(b.name.lexeme));
      builder.addReplacement(
        range.startEnd(
          enumDeclaration.body.constants.first,
          enumDeclaration.body.constants.last,
        ),
        (builder) {
          var writeIndent = false;
          for (var i = 0; i < sortedConstants.length; i++) {
            var constant = sortedConstants[i];
            if (writeIndent) {
              builder.writeIndent();
            }
            builder.write(
              utils.getNodeText(constant, withLeadingComments: true),
            );
            writeIndent = true;
            if ((sortedConstants.length - 1) != i) {
              builder.writeln(',');
            }
          }
        },
      );
    });
  }
}
