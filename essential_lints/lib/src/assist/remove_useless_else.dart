import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';

import 'assist.dart';
import 'essential_lint_assists.dart';

/// {@template swap_cases}
/// Assist to remove useless else statements.
/// {@endtemplate}
class RemoveUselessElse extends ResolvedCorrectionProducer with Assist {
  /// {@macro swap_cases}
  RemoveUselessElse({required super.context});

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintAssists get assist => .removeUselessElse;

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

extension on Statement {
  bool get alwaysExits {
    return switch (this) {
      Block(:var statements) =>
        statements.isNotEmpty && statements.last.alwaysExits,
      SwitchStatement(:var members) => members.every(
        (c) => c.statements.isNotEmpty && c.statements.last.alwaysExits,
      ),
      ReturnStatement() => true,
      ExpressionStatement(:var expression) => expression is ThrowExpression,
      _ =>
        // Other statements are not considered to always exit.
        false,
    };
  }
}

extension on Token {
  bool contains(int selectionOffset, int selectionEnd) {
    return offset <= selectionOffset && selectionEnd <= offset + length;
  }
}
