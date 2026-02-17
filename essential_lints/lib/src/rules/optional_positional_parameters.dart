import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template optional_positional_parameters}
/// Checks for functions or methods that declare optional positional parameters.
/// {@endtemplate}
@staticLoggerEnforcement
class OptionalPositionalParametersRule extends LintRule {
  /// {@macro optional_positional_parameters}
  OptionalPositionalParametersRule()
    : super(.optionalPositionalParameters, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'OptionalPositionalParametersRule',
  );

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _OptionalPositionalParametersVisitor(this, context);
    registry.addFormalParameterList(this, visitor);
  }
}

class _OptionalPositionalParametersVisitor extends SimpleAstVisitor<void> {
  _OptionalPositionalParametersVisitor(this.rule, this.context);

  final OptionalPositionalParametersRule rule;
  final RuleContext context;

  @override
  void visitFormalParameterList(FormalParameterList node) {
    rule.logger.info(
      'visitFormalParameterList() started with ${node.parameters.length} '
      'parameter(s)',
    );
    if (node.parameters.firstWhereOrNull((p) => p.isOptionalPositional)
        case var parameter?) {
      rule.logger.finer(
        'Found optional positional parameter: ${parameter.toSource()}',
      );
      if (parameter case DefaultFormalParameter(
        parameter: SuperFormalParameter(),
      )) {
        rule.logger.finer('Parameter is a super formal parameter — skipping');
        return;
      }
      if (parameter.name case var name?) {
        rule.logger.fine(
          'Reporting optional positional parameter at token: ${name.lexeme}',
        );
        rule.reportAtToken(name);
      } else {
        rule.logger.fine('Reporting optional positional parameter at node');
        rule.reportAtNode(parameter);
      }
    } else {
      rule.logger.finer('No optional positional parameters found');
    }
  }
}
