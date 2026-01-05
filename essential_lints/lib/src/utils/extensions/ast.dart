import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';

import 'object.dart';

/// Extension to get the enclosing type element of an AST node.
extension AstExtension on AstNode {
  /// Gets the enclosing executable element of the AST node.
  ExecutableElement? get enclosingExecutableElement {
    for (var ancestor in withAncestors) {
      switch (ancestor) {
        case MethodDeclaration(
              declaredFragment: ExecutableFragment(:var element),
            ) ||
            FunctionExpression(
              parent: FunctionDeclaration(
                declaredFragment: ExecutableFragment(:var element),
              ),
            ) ||
            FunctionExpression(
              declaredFragment: ExecutableFragment(:var element),
            ) ||
            ConstructorDeclaration(
              declaredFragment: ExecutableFragment(:var element),
            ):
          return element;
      }
    }
    return null;
  }

  /// Gets the enclosing executable element of the AST node if it is
  /// synchronous.
  ExecutableElement? get enclosingExecutableElementIfSync {
    for (var ancestor in withAncestors) {
      switch (ancestor) {
        case MethodDeclaration(
                  declaredFragment: ExecutableFragment(:var element),
                  :var body,
                ) ||
                FunctionExpression(
                  parent: FunctionDeclaration(
                    declaredFragment: ExecutableFragment(:var element),
                  ),
                  :var body,
                ) ||
                FunctionExpression(
                  declaredFragment: ExecutableFragment(:var element),
                  :var body,
                ) ||
                ConstructorDeclaration(
                  declaredFragment: ExecutableFragment(:var element),
                  :var body,
                )
            when body.isSynchronous:
          return element;
      }
    }
    return null;
  }

  /// Gets the enclosing type element of the AST node.
  InterfaceElement? get enclosingTypeElement {
    for (var ancestor in withAncestors) {
      switch (ancestor) {
        case ExtensionDeclaration(
          declaredFragment: ExtensionFragment(:var element),
        ):
          var extendedElement = element.extendedType.element
              .whenTypeOrNull<InterfaceElement>();
          if (extendedElement != null) {
            return extendedElement;
          }
        case ClassDeclaration(
              declaredFragment: InterfaceFragment(:var element),
            ) ||
            ExtensionTypeDeclaration(
              declaredFragment: InterfaceFragment(:var element),
            ) ||
            EnumDeclaration(
              declaredFragment: InterfaceFragment(:var element),
            ) ||
            MixinDeclaration(
              declaredFragment: InterfaceFragment(:var element),
            ):
          return element;
      }
    }
    return null;
  }

  /// An iterable of this node and all its ancestors, starting from this node.
  Iterable<AstNode> get withAncestors sync* {
    AstNode? current = this;
    while (current != null) {
      yield current;
      current = current.parent;
    }
  }
}

/// Extension to determine if a statement always exits.
extension StatementExt on Statement {
  /// Returns `true` if the statement always exits (e.g., via return, throw,
  /// or similar), otherwise returns `false`.
  bool get alwaysExits {
    return switch (this) {
      Block(:var statements) =>
        statements.isNotEmpty && statements.last.alwaysExits,
      SwitchStatement(:var members) => members.every(
        (c) => c.statements.isNotEmpty && c.statements.last.alwaysExits,
      ),
      ReturnStatement() => true,
      ExpressionStatement(:var expression) => expression is ThrowExpression,
      IfStatement(:var thenStatement, :var elseStatement) =>
        thenStatement.alwaysExits &&
            (elseStatement == null || elseStatement.alwaysExits),
      _ =>
        // Other statements are not considered to always exit.
        false,
    };
  }
}
