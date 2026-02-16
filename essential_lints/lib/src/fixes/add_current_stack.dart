import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../rules/analysis_rule.dart';
import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template add_current_stack_fix}
/// A fix that adds the current stack trace when completing a Completer with an
/// error.
/// {@endtemplate}
@staticLoggerEnforcement
class AddCurrentStackFix extends CorrectionProducerLogger with LintFix {
  /// {@macro add_current_stack_fix}
  AddCurrentStackFix({required super.context}) : super(_logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'AddCurrentStackFix',
  );

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintFixes get fix => .addCurrentStack;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    logger.info('AddCurrentStackFix.compute() started');
    if (diagnostic == null) {
      logger.finer('Diagnostic is null, returning');
      return;
    }
    logger.fine('Diagnostic found');
    var invocation = node.thisOrAncestorOfType<MethodInvocation>();
    if (invocation is! MethodInvocation) {
      logger.finer('Node is not inside a MethodInvocation, returning');
      assert(
        false,
        'How did we get a diagnostic if the node is not inside a '
        'MethodInvocation?',
      );
      return;
    }
    logger.fine('Found MethodInvocation');
    var enclosingCatchClause = node.enclosingCatchClause;
    logger.fine(
      'Enclosing catch clause: '
      '${enclosingCatchClause != null ? 'found' : 'not found'}',
    );
    await builder.addDartFileEdit(file, (builder) {
      builder.addInsertion(
        invocation.argumentList.rightParenthesis.offset,
        (builder) {
          builder.write(', ');
          if (enclosingCatchClause?.stackTraceParameter
              case CatchClauseParameter(:var name)) {
            logger.finer('Using stack trace parameter: ${name.lexeme}');
            builder.write(name.lexeme);
          } else {
            logger.finer('Using StackTrace.current');
            builder.write('StackTrace.current');
          }
        },
      );
    });
    logger.info('AddCurrentStackFix.compute() completed successfully');
  }
}

extension on AstNode {
  CatchClause? get enclosingCatchClause {
    AddCurrentStackFix._logger.fine(
      'enclosingCatchClause: Starting traversal from $runtimeType',
    );
    AstNode? current = this;
    while (current != null) {
      AddCurrentStackFix._logger.finer(
        '  Checking node type: ${current.runtimeType}',
      );
      if (current case Block(:var parent)) {
        AddCurrentStackFix._logger.finer(
          '    Found Block, parent type: ${parent.runtimeType}',
        );
        if (parent is CatchClause) {
          AddCurrentStackFix._logger.fine(
            '  Found CatchClause as parent, returning',
          );
          return parent;
        } else {
          AddCurrentStackFix._logger.finer(
            '    Parent is not CatchClause, returning null',
          );
          return null;
        }
      }
      if (current is CatchClause) {
        AddCurrentStackFix._logger.fine(
          '  Found CatchClause directly, returning',
        );
        return current;
      }
      if (current is CompilationUnitMember) {
        AddCurrentStackFix._logger.finer(
          '    Reached CompilationUnitMember, returning null',
        );
        return null;
      }
      if (current is ClassMember) {
        AddCurrentStackFix._logger.finer(
          '    Reached ClassMember, returning null',
        );
        return null;
      }
      current = current.parent;
    }
    AddCurrentStackFix._logger.finer(
      '  Traversal ended without finding CatchClause, returning null',
    );
    return null;
  }
}
