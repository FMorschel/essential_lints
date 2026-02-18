import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template alphabetize_enum_constants_rule}
/// A rule that enforces alphabetizing enum constants.
/// {@endtemplate}
@staticLoggerEnforcement
class AlphabetizeEnumConstantsRule
    extends LintRule<AlphabetizeEnumConstantsRule> {
  /// {@macro alphabetize_enum_constants_rule}
  AlphabetizeEnumConstantsRule() : super(.alphabetizeEnumConstants, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'AlphabetizeEnumConstantsRule',
  );

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _AlphabetizeEnumConstantsVisitor(this, context);
    registry.addEnumDeclaration(this, visitor);
  }
}

class _AlphabetizeEnumConstantsVisitor
    extends BaseVisitor<AlphabetizeEnumConstantsRule> {
  _AlphabetizeEnumConstantsVisitor(super.rule, super.context);

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    logger.info(
      'AlphabetizeEnumConstantsRule.visitEnumDeclaration() started for '
      '${node.namePart.typeName.lexeme} at offset ${node.offset}',
    );

    if (node.body.constants.length < 2) {
      logger
        ..finer(
          'Less than two enum constants for ${node.namePart.typeName.lexeme}, '
          'nothing to check',
        )
        ..info(
          'AlphabetizeEnumConstantsRule.visitEnumDeclaration() completed for '
          '${node.namePart.typeName.lexeme}',
        );
      return;
    }

    logger.fine(
      'Found ${node.body.constants.length} enum constants for '
      '${node.namePart.typeName.lexeme}',
    );
    for (var i = 1; i < node.body.constants.length; i++) {
      var previous = node.body.constants[i - 1];
      var current = node.body.constants[i];
      logger.finer(
        'Comparing previous=${previous.name.lexeme} with '
        'current=${current.name.lexeme} at index ${i - 1} -> $i',
      );
      if (previous.name.lexeme.compareTo(current.name.lexeme) > 0) {
        logger.fine(
          'Alphabetical order violation in enum '
          '${node.namePart.typeName.lexeme}: "${previous.name.lexeme}" > '
          '"${current.name.lexeme}" — reporting at token',
        );
        rule.reportAtToken(current.name);
        logger.info(
          'AlphabetizeEnumConstantsRule.visitEnumDeclaration() completed for '
          '${node.namePart.typeName.lexeme} (violation reported)',
        );
        return;
      }
    }

    logger.info(
      'AlphabetizeEnumConstantsRule.visitEnumDeclaration() completed for '
      '${node.namePart.typeName.lexeme}',
    );
  }
}
