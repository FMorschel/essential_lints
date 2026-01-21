import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/extensions/logger.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template alphabetize_enum_constants_rule}
/// A rule that enforces alphabetizing enum constants.
/// {@endtemplate}
@staticLoggerEnforcement
class AlphabetizeEnumConstantsRule extends LintRule {
  /// {@macro alphabetize_enum_constants_rule}
  AlphabetizeEnumConstantsRule() : super(.alphabetizeEnumConstants, _logger);

  static final Logger _logger = EssentialLintsPlugin.logger.newChild(
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

class _AlphabetizeEnumConstantsVisitor extends SimpleAstVisitor<void> {
  _AlphabetizeEnumConstantsVisitor(this.rule, this.context);

  final AlphabetizeEnumConstantsRule rule;
  final RuleContext context;

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    if (node.body.constants.length < 2) {
      return;
    }
    for (var i = 1; i < node.body.constants.length; i++) {
      var previous = node.body.constants[i - 1];
      var current = node.body.constants[i];
      if (previous.name.lexeme.compareTo(current.name.lexeme) > 0) {
        rule.reportAtToken(current.name);
        return;
      }
    }
  }
}
