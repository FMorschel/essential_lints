import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';

import '../fixes/essential_lint_fixes.dart';
import '../fixes/fix.dart';
import '../utils/extensions/ast.dart';
import 'assist.dart';
import 'essential_lint_assists.dart';

/// {@template swap_cases}
/// Assist to remove useless else statements.
/// {@endtemplate}
class RemoveUselessElseAssist extends ResolvedCorrectionProducer
    with Assist, LintFix {
  /// {@macro swap_cases}
  RemoveUselessElseAssist({required super.context});

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintAssists get assist => .removeUselessElse;

  @override
  EssentialLintFixes get fix => .removeUselessElse;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    final node = this.node;
    if (node is! IfStatement) return;
    Statement elseStatement;
    if (node.elseStatement case var statement?) {
      elseStatement = statement;
    } else {
      return;
    }
    if (!node.elseKeyword!.contains(selectionOffset, selectionEnd)) {
      // The selection is not on the else keyword.
      return;
    }
    if (!node.thenStatement.alwaysExits) {
      // The then statement does not always exit.
      return;
    }
    await builder.addDartFileEdit(file, (builder) {
      var prefix = utils.getLinePrefix(elseStatement.end);
      var elseRange = range.startOffsetEndOffset(
        node.elseKeyword!.previous!.end,
        elseStatement.offset,
      );
      builder.addReplacement(elseRange, (builder) {
        builder
          ..writeln()
          ..write(prefix);
      });
      if (elseStatement is Block) {
        var offset = elseStatement.leftBracket.next!.offset;
        var end = elseStatement.rightBracket.previous!.end;
        var source = utils.getText(
          offset,
          end - offset,
        );
        source = utils.indentSourceLeftRight(source);
        builder.addSimpleReplacement(
          range.startEnd(
            elseStatement.leftBracket,
            elseStatement.rightBracket,
          ),
          source,
        );
        if (elseStatement.rightBracket.next case var next?) {
          var finalPrefix = utils.getLinePrefix(
            next.offset,
          );
          builder.addSimpleReplacement(
            range.endStart(
              elseStatement.rightBracket,
              next,
            ),
            finalPrefix,
          );
        }
      }
    });
  }
}

extension on Token {
  bool contains(int selectionOffset, int selectionEnd) {
    return offset <= selectionOffset && selectionEnd <= offset + length;
  }
}
