import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';

import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template add_current_stack_fix}
/// A fix that adds the current stack trace when completing a Completer with an
/// error.
/// {@endtemplate}
class AddCurrentStackFix extends ResolvedCorrectionProducer with LintFix {
  /// {@macro add_current_stack_fix}
  AddCurrentStackFix({required super.context});

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintFixes get fix => .addCurrentStack;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    if (diagnostic == null) {
      return;
    }
    var invocation = node.thisOrAncestorOfType<MethodInvocation>();
    if (invocation is! MethodInvocation) {
      assert(
        false,
        'How did we get a diagnostic if the node is not inside a '
        'MethodInvocation?',
      );
      return;
    }
    var enclosingCatchClause = node.enclosingCatchClause;
    await builder.addDartFileEdit(file, (builder) {
      builder.addInsertion(
        invocation.argumentList.rightParenthesis.offset,
        (builder) {
          builder.write(', ');
          if (enclosingCatchClause?.stackTraceParameter
              case CatchClauseParameter(:var name)) {
            builder.write(name.lexeme);
          } else {
            builder.write('StackTrace.current');
          }
        },
      );
    });
  }
}

extension on AstNode {
  CatchClause? get enclosingCatchClause {
    AstNode? current = this;
    while (current != null) {
      if (current case Block(:var parent)) {
        if (parent is CatchClause) {
          return parent;
        } else {
          return null;
        }
      }
      if (current is CatchClause) {
        return current;
      }
      if (current is CompilationUnitMember) {
        return null;
      }
      if (current is ClassMember) {
        return null;
      }
      current = current.parent;
    }
    return null;
  }
}
