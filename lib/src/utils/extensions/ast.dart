import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';

import 'object.dart';

/// Extension to get the enclosing type element of an AST node.
extension AstExtension on AstNode {
  /// Gets the enclosing type element of the AST node.
  InterfaceElement get enclosingTypeElement {
    for (final ancestor in withAncestors) {
      switch (ancestor) {
        case ClassDeclaration(
          declaredFragment: InterfaceFragment(:var element),
        ):
          return element;
        case ExtensionDeclaration(
          declaredFragment: ExtensionFragment(:var element),
        ):
          var extendedElement = element.extendedType.element
              .whenTypeOrNull<InterfaceElement>();
          if (extendedElement != null) {
            return extendedElement;
          }
        case ExtensionTypeDeclaration(
          declaredFragment: InterfaceFragment(:var element),
        ):
          return element;
        case EnumDeclaration(declaredFragment: InterfaceFragment(:var element)):
          return element;
        case MixinDeclaration(
          declaredFragment: InterfaceFragment(:var element),
        ):
          return element;
      }
    }
    throw StateError('No enclosing type element found.');
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
