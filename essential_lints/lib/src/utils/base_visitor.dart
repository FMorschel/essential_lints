import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/type_provider.dart';
import 'package:analyzer/dart/element/type_system.dart';
import 'package:logging/logging.dart';

import '../rules/analysis_rule.dart';

/// A base visitor that provides access to the rule and context for all
/// visitors.
///
/// It ensures that the rule and context are available to all visitors and
/// provides easier access to the logger.
mixin Visitor<Rule extends AbstractEssentialAnalysisRule?, T> on AstVisitor<T> {
  /// The context of the rule, used to report diagnostics.
  RuleContext get context;

  /// The rule associated with this visitor, used to access the logger and other
  /// properties.
  Rule get rule;

  /// The logger for this visitor, used to log information during analysis.
  Logger get logger;

  /// The type system of the context, used for type analysis.
  TypeSystem get typeSystem => context.typeSystem;

  /// The type provider of the context, used for type analysis.
  TypeProvider get typeProvider => context.typeProvider;
}

/// {@template base_visitor}
/// Base visitor for [AbstractEssentialAnalysisRule]s.
/// {@endtemplate}
abstract class BaseVisitor<Rule extends AbstractEssentialAnalysisRule?>
    extends SimpleAstVisitor<void>
    with Visitor<Rule, void> {
  /// {@macro base_visitor}
  BaseVisitor(this.rule, this.context, {Logger? logger})
    : assert(
        (logger ?? rule) != null,
        'Either a logger or a non-nullable rule must be provided to Visitor',
      ),
      logger = logger ?? rule!.logger;

  @override
  final RuleContext context;

  @override
  final Rule rule;

  @override
  final Logger logger;
}

/// {@template generalizing_base_visitor}
/// A base generalizing visitor that provides access to the rule and context
/// for all visitors.
/// {@endtemplate}
abstract class GeneralizingBaseVisitor<
  Rule extends AbstractEssentialAnalysisRule?
>
    extends GeneralizingAstVisitor<void>
    with Visitor<Rule, void> {
  /// {@macro generalizing_base_visitor}
  GeneralizingBaseVisitor(this.rule, this.context, {Logger? logger})
    : assert(
        (logger ?? rule) != null,
        'Either a logger or a non-nullable rule must be provided to Visitor',
      ),
      logger = logger ?? rule!.logger;

  /// The context of the rule, used to report diagnostics.
  @override
  final RuleContext context;

  /// The rule associated with this visitor, used to access the logger and other
  /// properties.
  @override
  final Rule rule;

  /// The logger for this visitor, used to log information during analysis.
  @override
  final Logger logger;
}

/// {@template recursive_base_visitor}
/// A base recursive visitor that provides access to the rule and context for
/// all visitors.
/// {@endtemplate}
abstract class RecursiveBaseVisitor<Rule extends AbstractEssentialAnalysisRule?>
    extends RecursiveAstVisitor<void>
    with Visitor<Rule, void> {
  /// {@macro recursive_base_visitor}
  RecursiveBaseVisitor(this.rule, this.context, {Logger? logger})
    : assert(
        (logger ?? rule) != null,
        'Either a logger or a non-nullable rule must be provided to Visitor',
      ),
      logger = logger ?? rule!.logger;

  /// The context of the rule, used to report diagnostics.
  @override
  final RuleContext context;

  /// The rule associated with this visitor, used to access the logger and other
  /// properties.
  @override
  final Rule rule;

  /// The logger for this visitor, used to log information during analysis.
  @override
  final Logger logger;
}
