import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template alphabetize_arguments}
/// A lint rule that enforces alphabetical ordering of function arguments.
/// {@endtemplate}
@staticLoggerEnforcement
class AlphabetizeArgumentsRule extends LintRule<AlphabetizeArgumentsRule> {
  /// {@macro alphabetize_arguments}
  AlphabetizeArgumentsRule() : super(.alphabetizeArguments, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'AlphabetizeArgumentsRule',
  );

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    logger.fine('Registering node processors for AlphabetizeArgumentsRule');
    var visitor = _AlphabetizeArgumentsVisitor(this, context);
    registry.addArgumentList(this, visitor);
    logger.fine('Registered node processors for AlphabetizeArgumentsRule');
  }
}

class _AlphabetizeArgumentsVisitor
    extends BaseVisitor<AlphabetizeArgumentsRule> {
  _AlphabetizeArgumentsVisitor(super.rule, super.context);

  @override
  void visitArgumentList(ArgumentList node) {
    logger.info(
      'AlphabetizeArgumentsRule.visitArgumentList() started at offset '
      '${node.offset}',
    );

    var arguments = node.arguments;
    var argumentNames = arguments.whereType<NamedExpression>().toList();
    logger.fine('Found ${argumentNames.length} named arguments');

    if (argumentNames.length < 2) {
      logger
        ..finer('Less than two named arguments, nothing to check')
        ..info('AlphabetizeArgumentsRule.visitArgumentList() completed');
      return;
    }

    for (var i = 1; i < argumentNames.length; i++) {
      var previousName = argumentNames[i - 1].name.label.name;
      var currentName = argumentNames[i].name.label.name;
      logger.finer(
        'Comparing previous="$previousName" with '
        'current="$currentName" at index ${i - 1} -> $i',
      );
      if (previousName.compareTo(currentName) > 0) {
        logger.fine(
          'Alphabetical order violation: "$previousName" > "$currentName" — '
          'reporting at node',
        );
        rule.reportAtNode(argumentNames[i].name.label);
        // Stop after the first violation to avoid multiple reports for the same
        // argument list.
        break;
      }
    }

    logger.info('AlphabetizeArgumentsRule.visitArgumentList() completed');
  }
}
