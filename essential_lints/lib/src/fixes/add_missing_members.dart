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
    logger.info('AddMissingMembersFix.compute() started');
    var diagnostic = this.diagnostic;
    if (diagnostic == null) {
      logger.finer('No diagnostic found for AddMissingMembersFix.');
      return;
    }
    logger.fine('Diagnostic found');
    var matches = _memberPattern.allMatches(diagnostic.correctionMessage ?? '');
    if (matches.isEmpty) {
      logger.finer(
        'No member names could be parsed in correction message for '
        'AddMissingMembersFix.',
      );
      return;
    }
    logger.fine('Found member matches in correction message');
    var membersNames = matches.map((e) => e.group(2)).nonNulls.toList();
    var node = this.node;
    logger.fine(
      'Parsed members: $membersNames at node type: ${node.runtimeType}',
    );
    if (node case MethodDeclaration(:var body)) {
      logger.finer(
        'Node is MethodDeclaration, extracting expression from body',
      );
      var expression = switch (body) {
        ExpressionFunctionBody(:var expression) => expression,
        BlockFunctionBody(:var block) =>
          block.statements.lastOrNull
              .whenTypeOrNull<ReturnStatement>()
              ?.expression,
        EmptyFunctionBody() || NativeFunctionBody() => null,
      };
      if (expression != null) {
        logger.finer('  Found expression, updating node');
        node = expression;
      } else {
        logger.finer('  No expression found in method body');
      }
    } else if (node case VariableDeclaration(:var initializer?)) {
      logger.finer(
        'Node is VariableDeclaration with initializer, updating node',
      );
      node = initializer;
    } else {
      logger.finer(
        'Node does not match MethodDeclaration or VariableDeclaration patterns',
      );
    }
    if (node is! ListLiteral) {
      logger.finer(
        'The resolved node for AddMissingMembersFix is not a ListLiteral: '
        '${node.runtimeType}',
      );
      return;
    }
    logger.fine('Node is ListLiteral, proceeding with insertion');
    var offset = node.elements.isEmpty
        ? node.rightBracket.offset
        : node.elements.last.end;
    var prefix = node.elements.isEmpty ? '' : ', ';
    logger.finer(
      'List has ${node.elements.length} elements, inserting at offset: $offset',
    );
    await builder.addDartFileEdit(file, (builder) {
      builder.addSimpleInsertion(offset, prefix + membersNames.join(', '));
    });
    logger.info('AddMissingMembersFix.compute() completed successfully');
  }
}
