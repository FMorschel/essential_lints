import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'rule.dart';

/// {@template alphabetize_arguments}
/// A lint rule that enforces alphabetical ordering of function arguments.
/// {@endtemplate}
class AlphabetizeArgumentsRule extends Rule {
  /// {@macro alphabetize_arguments}
  AlphabetizeArgumentsRule() : super(.alphabetizeArguments);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _AlphabetizeArgumentsVisitor(this);
    registry.addArgumentList(this, visitor);
  }
}

class _AlphabetizeArgumentsVisitor extends SimpleAstVisitor<void> {
  _AlphabetizeArgumentsVisitor(this.rule);

  final AlphabetizeArgumentsRule rule;

  @override
  void visitArgumentList(ArgumentList node) {
    final arguments = node.arguments;
    final argumentNames = arguments.whereType<NamedExpression>().toList();
    for (var i = 1; i < argumentNames.length; i++) {
      final previousName = argumentNames[i - 1].name.label.name;
      final currentName = argumentNames[i].name.label.name;
      if (previousName.compareTo(currentName) > 0) {
        rule.reportAtNode(
          argumentNames[i].name.label,
        );
        // Stop after the first violation to avoid multiple reports for the same
        // argument list.
        break;
      }
    }
  }
}
