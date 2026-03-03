import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/scope.dart';
import 'package:analyzer/src/generated/resolver.dart' // ignore: implementation_imports, not exposed api
    show ScopeResolverVisitor;
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import '../utils/diagnostic_message.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template variable_shadowing}
/// Checks for variable declarations that shadow other variables in the same
/// scope.
/// {@endtemplate}
@staticLoggerEnforcement
class VariableShadowingRule extends LintRule<VariableShadowingRule> {
  /// {@macro variable_shadowing}
  VariableShadowingRule() : super(.variableShadowing, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'VariableShadowingRule',
  );

  @override
  Visitor<VariableShadowingRule, void> visitorFor(RuleContext context) =>
      _VariableShadowingVisitor(this, context);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = visitorFor(context);
    registry
      ..addVariableDeclaration(this, visitor)
      ..addDeclaredVariablePattern(this, visitor);
  }
}

class _VariableShadowingVisitor extends BaseVisitor<VariableShadowingRule> {
  _VariableShadowingVisitor(super.rule, super.context);

  @override
  void visitDeclaredVariablePattern(DeclaredVariablePattern node) {
    logger.info(
      'visitDeclaredVariablePattern() started for: ${node.toSource()}',
    );
    var element = _resolveNameInPreviousScope(
      node.declaredFragment!.element.displayName,
      node,
    );
    if (element != null) {
      logger.fine('Found previous declaration: ${element.displayName}');
      reportForTokenIfValid(node.name, element);
    } else {
      logger.finer(
        'No previous declaration found for: '
        '${node.declaredFragment!.element.displayName}',
      );
    }
  }

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    logger.info('visitVariableDeclaration() started for: ${node.toSource()}');
    if (node.thisOrAncestorOfType<FieldDeclaration>() != null) {
      logger.finer('Declaration is a field; skipping variable shadowing check');
      return;
    }
    var element = _resolveNameInPreviousScope(
      node.declaredFragment!.element.displayName,
      node,
    );
    if (element != null) {
      logger.fine('Found previous declaration: ${element.displayName}');
      reportForTokenIfValid(node.name, element);
    } else {
      logger.finer(
        'No previous declaration found for: '
        '${node.declaredFragment!.element.displayName}',
      );
    }
  }

  void reportForTokenIfValid(Token token, Element element) {
    if (element is PropertyAccessorElement &&
            element.enclosingElement is InstanceElement ||
        element.enclosingElement is LibraryElement) {
      logger.finer(
        'Previous declaration is a property accessor or top-level; skipping '
        'report for: ${element.displayName}',
      );
      return;
    }
    logger.fine(
      'Reporting shadowed variable at token: ${token.lexeme} (previous: '
      '${element.displayName})',
    );
    rule.reportAtToken(
      token,
      contextMessages: [
        DiagnosticMessageImpl(
          filePath: element.firstFragment.libraryFragment!.source.fullName,
          offset:
              element.firstFragment.nameOffset ?? element.firstFragment.offset,
          length: element.firstFragment.name?.length ?? 1,
          message: 'Previous declaration is here.',
          url: null,
        ),
      ],
    );
  }
}

Element? _resolveNameInPreviousScope(String id, AstNode node) {
  VariableShadowingRule._logger.finer(
    'Resolving previous scope for id: $id at node: ${node.runtimeType}',
  );
  Scope? scope;
  var skipNext = true;
  for (AstNode? context = node; context != null; context = context.parent) {
    if (context.parent is CompilationUnit ||
        context.parent is CompilationUnitMember) {
      // Reached the top-level scope.
      VariableShadowingRule._logger.finer(
        'Reached top-level scope while resolving $id, stopping traversal',
      );
      break;
    }
    if (context case BlockFunctionBody(:var parent)) {
      FormalParameterList? declaredParameters;
      if (parent case FunctionExpression(:var parameters)) {
        declaredParameters = parameters;
      } else if (parent case MethodDeclaration(:var parameters)) {
        declaredParameters = parameters;
      } else if (parent case ConstructorDeclaration(:var parameters)) {
        declaredParameters = parameters;
      }
      if (declaredParameters != null) {
        for (var parameter in declaredParameters.parameters) {
          if (parameter.declaredFragment?.element.displayName == id) {
            VariableShadowingRule._logger.finer(
              'Found matching parameter declaration in current scope for $id',
            );
            return parameter.declaredFragment?.element;
          }
        }
      }
    }
    var nodeScope = ScopeResolverVisitor.getNodeNameScope(context);
    if (nodeScope != null) {
      if (skipNext) {
        skipNext = false;
        continue;
      }
      scope = nodeScope;
      VariableShadowingRule._logger.finer(
        'Found candidate scope while resolving $id',
      );
      break;
    }
  }

  if (scope != null) {
    var ScopeLookupResult(:getter, :setter) = scope.lookup(id);
    var result = getter ?? setter;
    if (result != null) {
      VariableShadowingRule._logger.fine(
        'Resolved previous declaration for $id: ${result.displayName}',
      );
    } else {
      VariableShadowingRule._logger.finer(
        'No previous declaration found in scope for $id',
      );
    }
    return result;
  }

  VariableShadowingRule._logger.finer('No scope found while resolving $id');
  return null;
}
