import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';

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
            ):
          return body.isSynchronous ? element : null;
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

/// Extension to determine if an expression can be a constant expression.
extension ExpressionExt on Expression {
  /// Returns `true` if the expression can be a constant expression, otherwise
  /// returns `false`.
  bool get canBeConstant {
    return switch (this) {
      NamedExpression(:var expression) => expression.canBeConstant,
      Literal() => true,
      Identifier(:var element) =>
        element is PropertyAccessorElement && element.variable.isConst,
      ConditionalExpression(
        :var condition,
        :var thenExpression,
        :var elseExpression,
      ) =>
        condition.canBeConstant &&
            thenExpression.canBeConstant &&
            elseExpression.canBeConstant,
      BinaryExpression(:var leftOperand, :var rightOperand) =>
        leftOperand.canBeConstant && rightOperand.canBeConstant,
      PropertyAccess(:var target, :var propertyName) =>
        target != null && target.canBeConstant && propertyName.name == 'length',
      _ => canBeConst,
    };
  }
}

/// Extension to get the type and type annotation of a normal formal parameter.
extension NormalFormalParameterExt on FormalParameter {
  /// Gets the declared type of the parameter, or `null` if it cannot be
  /// determined.
  DartType? get type => declaredFragment?.element.type;

  /// Gets the source range of the parameter's type annotation, or `null` if
  /// it cannot be determined.
  SourceRange? get typeAnnotationRange => switch (this) {
    FieldFormalParameter(:var type) => type?.sourceRange,
    FunctionTypedFormalParameter(
      :var returnType,
      :var parameters,
    ) =>
      range.startEnd(
        returnType ?? parameters.beginToken.previous!,
        parameters.parameters.last,
      ),
    SimpleFormalParameter(:var type) => type?.sourceRange,
    SuperFormalParameter(:var type) => type?.sourceRange,
    DefaultFormalParameter(:var parameter) => parameter.typeAnnotationRange,
  };
}
