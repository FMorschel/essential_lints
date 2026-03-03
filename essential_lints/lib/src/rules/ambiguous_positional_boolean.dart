import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import '../utils/extensions/ast.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template ambiguous_positional_boolean}
/// A lint rule that detects ambiguous positional boolean parameters in
/// functions and methods, which can lead to confusion and errors in code.
/// {@endtemplate}
@staticLoggerEnforcement
class AmbiguousPositionalBooleanRule
    extends LintRule<AmbiguousPositionalBooleanRule> {
  /// {@macro ambiguous_positional_boolean}
  AmbiguousPositionalBooleanRule()
    : super(.ambiguousPositionalBoolean, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'AmbiguousPositionalBooleanRule',
  );

  @override
  Visitor<AmbiguousPositionalBooleanRule, void> visitorFor(
    RuleContext context,
  ) => _AmbiguousPositionalBooleanVisitor(this, context);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    logger.fine(
      'Registering node processors for AmbiguousPositionalBooleanRule',
    );
    var visitor = visitorFor(context);
    registry
      ..addFunctionExpression(this, visitor)
      ..addMethodDeclaration(this, visitor)
      ..addConstructorDeclaration(this, visitor)
      ..addGenericFunctionType(this, visitor);
    logger.fine(
      'Registered node processors for AmbiguousPositionalBooleanRule',
    );
  }
}

class _AmbiguousPositionalBooleanVisitor
    extends BaseVisitor<AmbiguousPositionalBooleanRule> {
  _AmbiguousPositionalBooleanVisitor(super.rule, super.context);

  @override
  void visitFunctionExpression(FunctionExpression node) {
    if (node.parameters case var parameters?) {
      _checkForAmbiguousBooleans(parameters);
    }
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    if (node.parameters case var parameters?) {
      if (node.declaredFragment?.element case MethodElement(
        isOperator: false,
      )) {
        _checkForAmbiguousBooleans(parameters);
      }
    }
  }

  @override
  void visitGenericFunctionType(GenericFunctionType node) {
    _checkForAmbiguousBooleans(node.parameters);
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    _checkForAmbiguousBooleans(node.parameters);
  }

  void _checkForAmbiguousBooleans(FormalParameterList parameters) {
    for (var parameter in parameters.parameters.skip(1)) {
      if (parameter.typeAnnotationRange
          case SourceRange(:var offset, :var length)
          when parameter.isPositional &&
              (parameter.type?.isDartCoreBool ?? false)) {
        rule.reportAtOffset(offset, length);
      } else if (parameter case FieldFormalParameter(
        :var thisKeyword,
        isPositional: true,
        declaredFragment: FieldFormalParameterFragment(
          element: FieldFormalParameterElement(
            type: DartType(isDartCoreBool: true),
          ),
        ),
      )) {
        rule.reportAtToken(thisKeyword);
      } else if (parameter case SuperFormalParameter(
        :var superKeyword,
        isPositional: true,
        declaredFragment: SuperFormalParameterFragment(
          element: SuperFormalParameterElement(
            type: DartType(isDartCoreBool: true),
          ),
        ),
      )) {
        rule.reportAtToken(superKeyword);
      } else if (parameter.declaredFragment?.element
          case FormalParameterElement(
            isPositional: true,
            type: DartType(isDartCoreBool: true),
          )) {
        if (parameter.name case var name?) {
          rule.reportAtToken(name);
        } else {
          logger.finer(
            'How did we get here? A positional parameter without a name that '
            'has a specific type?',
          );
        }
      }
    }
  }
}
