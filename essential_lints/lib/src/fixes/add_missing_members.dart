import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';

import '../utils/extensions/object.dart';
import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template add_missing_members}
/// A fix that adds missing members to a class or interface.
/// {@endtemplate}
class AddMissingMembersFix extends WarningFix {
  /// {@macro add_missing_members}
  AddMissingMembersFix({required super.context});

  static final _memberPattern = RegExp(r"('(([$]|\w)+)')");

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintWarningFixes get fix => .addMissingMembers;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    var diagnostic = this.diagnostic;
    if (diagnostic == null) {
      return;
    }
    var matches = _memberPattern.allMatches(diagnostic.correctionMessage ?? '');
    if (matches.isEmpty) {
      return;
    }
    var membersNames = matches.map((e) => e.group(2)).nonNulls.toList();
    var node = this.node;
    if (node case MethodDeclaration(:var body)) {
      var expression = switch (body) {
        ExpressionFunctionBody(:var expression) => expression,
        BlockFunctionBody(:var block) =>
          block.statements.lastOrNull
              .whenTypeOrNull<ReturnStatement>()
              ?.expression,
        EmptyFunctionBody() || NativeFunctionBody() => null,
      };
      if (expression != null) {
        node = expression;
      }
    } else if (node case VariableDeclaration(:var initializer?)) {
      node = initializer;
    }
    if (node is! ListLiteral) {
      return;
    }
    var offset = node.rightBracket.offset;
    var prefix = node.elements.isEmpty ? '' : ', ';
    await builder.addDartFileEdit(file, (builder) {
      builder.addSimpleInsertion(offset, prefix + membersNames.join(', '));
    });
  }
}
