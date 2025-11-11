import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';

import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template create_getter_fix}
/// A fix that creates a getter for a missing getter reference.
/// {@endtemplate}
class CreateGetterFix extends WarningFix {
  /// {@macro create_getter_fix}
  CreateGetterFix({required super.context});

  static final _memberPattern = RegExp(r"('(([$]|\w)+)')");

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintWarningFixes get fix => .createGetter;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    var diagnostic = this.diagnostic;
    if (diagnostic == null) {
      return;
    }
    var getterName = _memberPattern.firstMatch(
      diagnostic.correctionMessage ?? '',
    );
    if (getterName == null) {
      return;
    }
    var name = getterName.group(2);
    if (name == null) {
      return;
    }
    var node = this.node;
    if (node is! ClassDeclaration) {
      return;
    }
    if (node.declaredFragment!.element case ClassElement(:var getters)) {
      if (getters.any((g) => g.name == name)) {
        return;
      }
    }
    await builder.addDartFileEdit(file, (builder) {
      var offset = node.members.lastOrNull?.end ?? node.rightBracket.offset;
      var needsNewLine =
          offset == node.leftBracket.end || node.members.isNotEmpty;
      builder.addInsertion(offset, (builder) {
        if (needsNewLine) {
          builder.writeln();
        }
        builder
          ..write(utils.oneIndent)
          ..writeGetterDeclaration(
            name,
            returnType: typeProvider.listType(typeProvider.objectQuestionType),
            bodyWriter: () => builder.write('=> [];'),
          );
        if (offset == node.rightBracket.offset) {
          builder.writeln();
        }
      });
    });
  }
}
