import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../rules/analysis_rule.dart';
import '../utils/extensions/object.dart';
import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template add_missing_members}
/// A fix that adds missing members to a class or interface.
/// {@endtemplate}
@staticLoggerEnforcement
class AddMissingMembersFix extends CorrectionProducerLogger with WarningFix {
  /// {@macro add_missing_members}
  AddMissingMembersFix({required super.context}) : super(_logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'AddMissingMembersFix',
  );

  static final _memberPattern = RegExp(r"('(([$]|\w)+)')");

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintWarningFixes get fix => .addMissingMembers;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    var diagnostic = this.diagnostic;
    if (diagnostic == null) {
      logger.info('No diagnostic found for AddMissingMembersFix.');
      return;
    }
    var matches = _memberPattern.allMatches(diagnostic.correctionMessage ?? '');
    if (matches.isEmpty) {
      logger.info(
        'No member names could be parsed in correction message for '
        'AddMissingMembersFix.',
      );
      return;
    }
    var membersNames = matches.map((e) => e.group(2)).nonNulls.toList();
    var node = this.node;
    logger.info(
      'Applying AddMissingMembersFix for members: $membersNames at node: '
      '${node.runtimeType}.',
    );
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
      logger.info(
        'The resolved node for AddMissingMembersFix is not a ListLiteral: '
        '${node.runtimeType}.',
      );
      return;
    }
    var offset = node.elements.isEmpty
        ? node.rightBracket.offset
        : node.elements.last.end;
    var prefix = node.elements.isEmpty ? '' : ', ';
    await builder.addDartFileEdit(file, (builder) {
      builder.addSimpleInsertion(offset, prefix + membersNames.join(', '));
    });
  }
}
