import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/scope.dart';
import 'package:analyzer/src/generated/resolver.dart' // ignore: implementation_imports, not exposed api
    show ScopeResolverVisitor;

import 'rule.dart';

bool _resolveNameInPreviousScope(String id, AstNode node) {
  Scope? scope;
  var skipNext = true;
  for (AstNode? context = node; context != null; context = context.parent) {
    if (context.parent is CompilationUnit ||
        context.parent is CompilationUnitMember) {
      // Reached the top-level scope.
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
            return true;
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
      break;
    }
  }

  if (scope != null) {
    var ScopeLookupResult(:getter) = scope.lookup(id);
    if (getter != null) {
      return true;
    }
  }

  return false;
}

/// {@template variable_shadowing}
/// Checks for variable declarations that shadow other variables in the same
/// scope.
/// {@endtemplate}
class VariableShadowingRule extends LintRule {
  /// {@macro variable_shadowing}
  VariableShadowingRule() : super(.variableShadowing);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _VariableShadowingVisitor(this, context);
    registry
      ..addVariableDeclaration(this, visitor)
      ..addDeclaredVariablePattern(this, visitor);
  }
}

class _VariableShadowingVisitor extends SimpleAstVisitor<void> {
  _VariableShadowingVisitor(this.rule, this.context);

  final VariableShadowingRule rule;
  final RuleContext context;

  @override
  void visitDeclaredVariablePattern(DeclaredVariablePattern node) {
    var result = _resolveNameInPreviousScope(
      node.declaredFragment!.element.displayName,
      node,
    );
    if (result) {
      rule.reportAtToken(node.name);
    }
  }

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    var result = _resolveNameInPreviousScope(
      node.declaredFragment!.element.displayName,
      node,
    );
    if (result) {
      rule.reportAtToken(node.name);
    }
  }
}
