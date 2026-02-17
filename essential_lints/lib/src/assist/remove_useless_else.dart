import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:logging/logging.dart';

import '../fixes/essential_lint_fixes.dart';
import '../fixes/fix.dart';
import '../plugin.dart';
import '../rules/analysis_rule.dart';
import '../utils/extensions/ast.dart';
import 'assist.dart';
import 'essential_lint_assists.dart';

/// {@template swap_cases}
/// Assist to remove useless else statements.
/// {@endtemplate}
@staticLoggerEnforcement
class RemoveUselessElseAssistFix extends CorrectionProducerLogger
    with Assist, LintFix {
  /// {@macro swap_cases}
  RemoveUselessElseAssistFix({required super.context}) : super(_logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'RemoveUselessElseAssistFix',
  );

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintAssists get assist => .removeUselessElse;

  @override
  EssentialLintFixes get fix => .removeUselessElse;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    logger.info('RemoveUselessElseAssistFix.compute() started');
    var node = this.node;
    if (node is! IfStatement) {
      logger.finer('Node is not an IfStatement, returning');
      return;
    }
    logger.fine('Node is an IfStatement');
    Statement elseStatement;
    if (node.elseStatement case var statement?) {
      elseStatement = statement;
      logger.fine('Found else statement: ${statement.runtimeType}');
    } else {
      logger.finer('No else statement found, returning');
      return;
    }
    if (!node.elseKeyword!.contains(selectionOffset, selectionEnd)) {
      // The selection is not on the else keyword.
      logger.finer('Selection is not on else keyword, returning');
      return;
    }
    logger.fine('Selection is on else keyword');
    if (!node.thenStatement.alwaysExits) {
      // The then statement does not always exit.
      logger.finer('Then statement does not always exit, returning');
      return;
    }
    logger.fine('Then statement always exits, proceeding with edit');
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
        logger.fine('Else statement is a block, adjusting indentation');
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
          logger.fine('Adjusting indentation for code after else block');
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
    logger.info('RemoveUselessElseAssistFix.compute() completed successfully');
  }
}

extension on Token {
  bool contains(int selectionOffset, int selectionEnd) {
    return offset <= selectionOffset && selectionEnd <= offset + length;
  }
}
