import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'essential_lint_rules.dart';
import 'rules.dart';

/// {@template alphabetize_arguments}
/// A lint rule that enforces alphabetical ordering of function arguments.
/// {@endtemplate}
class AlphabetizeArguments extends Rule {
  /// {@macro alphabetize_arguments}
  AlphabetizeArguments()
    : super(
        name: _rule.code.name,
        description: 'Arguments should be in alphabetical order.',
      );

  static const EssentialLintRules _rule =
      EssentialLintRules.alphabetizeArguments;

  @override
  EssentialLintRules get rule => _rule;

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

  final AlphabetizeArguments rule;

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
