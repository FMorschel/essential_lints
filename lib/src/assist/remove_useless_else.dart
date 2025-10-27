import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';

import 'assist.dart';
import 'essential_lint_assists.dart';

/// {@template swap_cases}
/// Assist to remove useless else statements.
/// {@endtemplate}
class RemoveUselessElse extends Assist {
  /// {@macro swap_cases}
  RemoveUselessElse({required super.context});

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
      var prefix = utils.getPrefix(elseStatement.end);
      builder.addReplacement(range.token(node.elseKeyword!), (builder) {
        builder.writeln(prefix);
      });
      if (elseStatement is Block) {
        var source = utils.getText(
          elseStatement.leftBracket.end,
          elseStatement.rightBracket.offset,
        );
        utils.indentSourceLeftRight(source);
        builder
          ..addDeletion(range.token(elseStatement.leftBracket))
          ..addSimpleReplacement(
            range.endStart(
              elseStatement.leftBracket,
              elseStatement.rightBracket,
            ),
            source,
          )
          ..addDeletion(range.token(elseStatement.rightBracket));
      }
    });
  }
}

extension on Statement {
  bool get alwaysExits {
    return switch (this) {
      Block(:var statements) =>
        statements.isNotEmpty && statements.last.alwaysExits,
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
