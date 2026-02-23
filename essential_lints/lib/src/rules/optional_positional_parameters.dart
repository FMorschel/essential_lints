import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template optional_positional_parameters}
/// Checks for functions or methods that declare optional positional parameters.
/// {@endtemplate}
@staticLoggerEnforcement
class OptionalPositionalParametersRule
    extends LintRule<OptionalPositionalParametersRule> {
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

class _OptionalPositionalParametersVisitor
    extends BaseVisitor<OptionalPositionalParametersRule> {
  _OptionalPositionalParametersVisitor(super.rule, super.context);

  @override
  void visitFormalParameterList(FormalParameterList node) {
    logger.info(
      'visitFormalParameterList() started with ${node.parameters.length} '
      'parameter(s)',
    );
    if (node.parameters.firstWhereOrNull((p) => p.isOptionalPositional)
        case var parameter?) {
      logger.finer(
        'Found optional positional parameter: ${parameter.toSource()}',
      );
      if (parameter case DefaultFormalParameter(
        parameter: SuperFormalParameter(),
      )) {
        logger.finer('Parameter is a super formal parameter — skipping');
        return;
      }
      if (parameter.name case var name?) {
        logger.fine(
          'Reporting optional positional parameter at token: ${name.lexeme}',
        );
        rule.reportAtToken(name);
      } else {
        logger.fine('Reporting optional positional parameter at node');
        // Should be only a type annotation at this point.
        // ignore: _internal_plugin/report_shorter_lengths
        rule.reportAtNode(parameter);
      }
    } else {
      logger.finer('No optional positional parameters found');
    }
  }
}
