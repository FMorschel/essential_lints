import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';
import 'package:essential_lints_annotations/src/sorting_members/sort_declarations.dart'; // ignore: implementation_imports used only for exhaustiveness
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import 'warning.dart';

final _logger = Logger('sorting_members_rule');

/// {@template sorting_members_rule}
/// The rule for sorting_members warning.
/// {@endtemplate}
class SortingMembersRule extends WarningRule {
  /// {@macro sorting_members_rule}
  SortingMembersRule() : super(.sortingMembers);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _SortingMembersVisitor(this, context);
    registry
      ..addClassDeclaration(this, visitor)
      ..addMixinDeclaration(this, visitor)
      ..addExtensionDeclaration(this, visitor)
      ..addExtensionTypeDeclaration(this, visitor)
      ..addEnumDeclaration(this, visitor);
  }
}

class _MemberVisitor extends RecursiveAstVisitor<void> {
  _MemberVisitor(this.rule, this.context, this.validatorFromAnnotation);

  final _ValidatorFromAnnotation validatorFromAnnotation;
  final SortingMembersRule rule;
  final RuleContext context;
  int current = 0;
  bool _reported = false;

  void _validateMember(AstNode node, Element element) {
    if (_reported) return;
    if (current >= validatorFromAnnotation.validators.length) return;

    var validator = validatorFromAnnotation.validators[current];

    if (validator.isValid(node, element)) {
      // Member matches current validator
      // Check ALL validators for a more specific match
      for (var i = 0; i < validatorFromAnnotation.validators.length; i++) {
        if (i == current) continue; // Skip current validator
        var otherValidator = validatorFromAnnotation.validators[i];
        if (otherValidator.isValid(node, element) &&
            otherValidator.isMoreSpecificThan(validator)) {
          // There's a more specific validator elsewhere
          if (i > current) {
            // More specific validator is ahead - jump to it
            current = i;
            return;
          } else {
            // More specific validator is behind - member is out of order
            _reportAt(node, element);
            return;
          }
        }
      }
      // No more specific validator found - this is the right match
      return;
    }

    // Check if member matches any previous validators (wrong order)
    for (var i = 0; i < current; i++) {
      if (validatorFromAnnotation.validators[i].isValid(node, element)) {
        // Member matches a previous validator - report error
        _reportAt(node, element);
        return;
      }
    }

    // Try to find a new validator that matches this member
    var previousCurrent = current;
    for (
      var i = current + 1;
      i < validatorFromAnnotation.validators.length;
      i++
    ) {
      if (validatorFromAnnotation.validators[i].isValid(node, element)) {
        // Found a matching validator ahead - move to it
        current = i;
        return;
      }
    }

    // No matching validator found - revert to previous current
    current = previousCurrent;
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    if (_reported) return;
    var element = node.declaredFragment?.element;
    if (element == null) return;
    _validateMember(node, element);
  }

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    if (_reported) return;
    // Check each variable in the field declaration
    for (var variable in node.fields.variables) {
      var element = variable.declaredFragment?.element;
      if (element == null) continue;
      _validateMember(node, element);
      if (_reported) return;
    }
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    if (_reported) return;
    var element = node.declaredFragment?.element;
    if (element == null) return;
    _validateMember(node, element);
  }

  void _reportAt(AstNode node, Element element) {
    switch (node) {
      case MethodDeclaration(:var name):
        rule.reportAtToken(name);
      case FieldDeclaration(:var fields):
        for (var variable in fields.variables) {
          if (variable.declaredFragment?.element == element) {
            rule.reportAtToken(variable.name);
            break;
          }
        }
      case ConstructorDeclaration(:var name):
        if (name != null) {
          rule.reportAtToken(name);
        } else {
          rule.reportAtNode(node.returnType);
        }
    }
    _reported = true;
  }
}

class _SortingMembersVisitor extends SimpleAstVisitor<void> {
  _SortingMembersVisitor(this.rule, this.context);

  final SortingMembersRule rule;
  final RuleContext context;

  bool _isSortingMembers(ElementAnnotation annotation) {
    var object = annotation.computeConstantValue();
    return object?.type?.element?.name == 'SortingMembers' &&
        object?.type?.element?.library?.uri ==
            .parse(
              'package:essential_lints_annotations/src/sorting_members.dart',
            );
  }

  void _handleAnnotatedNode(AnnotatedNode node) {
    for (var annotation in node.metadata) {
      var element = annotation.elementAnnotation;
      if (element == null) {
        continue;
      }
      if (_isSortingMembers(element)) {
        var validatorFromAnnotation = _ValidatorFromAnnotation.fromAnnotation(
          element,
        );
        var visitor = _MemberVisitor(rule, context, validatorFromAnnotation);
        node.visitChildren(visitor);
      }
    }
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    _handleAnnotatedNode(node);
  }

  @override
  void visitMixinDeclaration(MixinDeclaration node) {
    _handleAnnotatedNode(node);
  }

  @override
  void visitExtensionDeclaration(ExtensionDeclaration node) {
    _handleAnnotatedNode(node);
  }

  @override
  void visitExtensionTypeDeclaration(ExtensionTypeDeclaration node) {
    _handleAnnotatedNode(node);
  }

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    _handleAnnotatedNode(node);
  }
}

class _ValidatorFromAnnotation {
  _ValidatorFromAnnotation._({
    required this.annotation,
    required this.validators,
  });

  factory _ValidatorFromAnnotation.fromAnnotation(
    ElementAnnotation annotation,
  ) {
    var constantValue = annotation.computeConstantValue();
    if (constantValue == null) {
      throw ArgumentError(
        'Annotation does not have a constant value: $annotation',
      );
    }
    var declarations = constantValue.getField('declarations')?.toSetValue();
    var validators = <_ListMemberTypeValidator>[];
    for (var declaration in {...?declarations}) {
      var list = <_MemberTypeValidator>[];
      DartObject? current = declaration;
      String? typeName;
      While:
      do {
        typeName = current?.type?.element?.lookupName;
        switch (typeName) {
          case '_Field':
            list.add(const _FieldMemberTypeValidator());
            list.add(
              _ExpectedNamedMemberTypeValidator(
                expectedName:
                    current
                        ?.constructorInvocation
                        ?.positionalArguments
                        .firstOrNull
                        ?.toSymbolValue() ??
                    '',
              ),
            );
            break While;
          case '_Constructor':
            list.add(const _ConstructorMemberTypeValidator());
            list.add(
              _ExpectedNamedMemberTypeValidator(
                expectedName:
                    current
                        ?.constructorInvocation
                        ?.positionalArguments
                        .firstOrNull
                        ?.toSymbolValue() ??
                    '',
              ),
            );
            break While;
          case '_Method':
            list.add(const _MethodMemberTypeValidator());
            list.add(
              _ExpectedNamedMemberTypeValidator(
                expectedName:
                    current
                        ?.constructorInvocation
                        ?.positionalArguments
                        .firstOrNull
                        ?.toSymbolValue() ??
                    '',
              ),
            );
            break While;
          case '_Getter':
            list.add(const _GetterMemberTypeValidator());
            list.add(
              _ExpectedNamedMemberTypeValidator(
                expectedName:
                    current
                        ?.constructorInvocation
                        ?.positionalArguments
                        .firstOrNull
                        ?.toSymbolValue() ??
                    '',
              ),
            );
            break While;
          case '_Setter':
            list.add(const _SetterMemberTypeValidator());
            list.add(
              _ExpectedNamedMemberTypeValidator(
                expectedName:
                    current
                        ?.constructorInvocation
                        ?.positionalArguments
                        .firstOrNull
                        ?.toSymbolValue() ??
                    '',
              ),
            );
            break While;
          case 'Fields':
            list.add(const _FieldMemberTypeValidator());
          case 'Constructors':
            list.add(const _ConstructorMemberTypeValidator());
          case 'Methods':
            list.add(const _MethodMemberTypeValidator());
          case 'Getters':
            list.add(const _GetterMemberTypeValidator());
          case 'Setters':
            list.add(const _SetterMemberTypeValidator());
          case '_Named':
            list.add(const _NamedMemberTypeValidator());
          case '_Abstract':
            list.add(const _AbstractMemberTypeValidator());
          case '_Const':
            list.add(const _ConstMemberTypeValidator());
          case '_External':
            list.add(const _ExternalMemberTypeValidator());
          case '_Factory':
            list.add(const _FactoryMemberTypeValidator());
          case '_Final':
            list.add(const _FinalMemberTypeValidator());
          case '_Initialized':
            list.add(const _InitializedMemberTypeValidator());
          case '_Late':
            list.add(const _LateMemberTypeValidator());
          case '_Nullable':
            list.add(const _NullableMemberTypeValidator());
          case '_Operator':
            list.add(const _OperatorMemberTypeValidator());
          case '_Overridden':
            list.add(const _OverriddenMemberTypeValidator());
          case '_Private':
            list.add(const _PrivateMemberTypeValidator());
          case '_Public':
            list.add(const _PublicMemberTypeValidator());
          case '_Redirecting':
            list.add(const _RedirectingMemberTypeValidator());
          case '_Static':
            list.add(const _StaticMemberTypeValidator());
          case '_Unnamed':
            list.add(const _UnnamedMemberTypeValidator());
          case '_Var':
            list.add(const _VarMemberTypeValidator());
          case '_Typed':
            list.add(const _TypedMemberTypeValidator());
          case '_Instance':
            list.add(const _InstanceMemberTypeValidator());
          case '_Dynamic':
            list.add(const _DynamicMemberTypeValidator());
          case '_New':
            list.add(const _NewMemberTypeValidator());
          default:
            _logger.severe('Unknown member type: $typeName');
            assert(false, 'Unknown member type: $typeName');
        }
        current =
            current?.constructorInvocation?.positionalArguments.firstOrNull;
      } while (current != null);
      validators.add(_ListMemberTypeValidator(validators: list));
    }
    return _ValidatorFromAnnotation._(
      annotation: annotation,
      validators: validators,
    );
  }

  final ElementAnnotation annotation;
  final List<_ListMemberTypeValidator> validators;
}

@immutable
sealed class _MemberTypeValidator {
  const _MemberTypeValidator();

  // ignore: unused_element exhaustiveness
  factory _MemberTypeValidator._(HelperEnum constant) {
    return switch (constant) {
      .abstract => const _AbstractMemberTypeValidator(),
      .const_ => const _ConstMemberTypeValidator(),
      .constructor => const _ConstructorMemberTypeValidator(),
      .dynamic => const _DynamicMemberTypeValidator(),
      .external => const _ExternalMemberTypeValidator(),
      .factory_ => const _FactoryMemberTypeValidator(),
      .field => const _FieldMemberTypeValidator(),
      .final_ => const _FinalMemberTypeValidator(),
      .getter => const _GetterMemberTypeValidator(),
      .initialized => const _InitializedMemberTypeValidator(),
      .instance => const _InstanceMemberTypeValidator(),
      .late => const _LateMemberTypeValidator(),
      .method => const _MethodMemberTypeValidator(),
      .named => const _NamedMemberTypeValidator(),
      .new_ => const _NewMemberTypeValidator(),
      .nullable => const _NullableMemberTypeValidator(),
      .operator => const _OperatorMemberTypeValidator(),
      .overridden => const _OverriddenMemberTypeValidator(),
      .private => const _PrivateMemberTypeValidator(),
      .public => const _PublicMemberTypeValidator(),
      .redirecting => const _RedirectingMemberTypeValidator(),
      .setter => const _SetterMemberTypeValidator(),
      .static => const _StaticMemberTypeValidator(),
      .typed => const _TypedMemberTypeValidator(),
      .unnamed => const _UnnamedMemberTypeValidator(),
      .var_ => const _VarMemberTypeValidator(),
    };
  }

  bool isValid(AstNode member, Element element);
}

class _ListMemberTypeValidator extends _MemberTypeValidator {
  const _ListMemberTypeValidator({
    required this.validators,
  });

  final List<_MemberTypeValidator> validators;

  @override
  bool isValid(AstNode member, Element element) {
    for (var validator in validators) {
      if (!validator.isValid(member, element)) {
        return false;
      }
    }
    return true;
  }

  /// Returns true if this validator is more specific than [other].
  /// A validator is more specific if it has all validators from [other]
  /// plus additional ones (making it more restrictive).
  bool isMoreSpecificThan(_ListMemberTypeValidator other) {
    // If this has fewer or equal validators, it can't be more specific
    if (validators.length <= other.validators.length) return false;

    // Check if all validators from other exist in this list
    for (var otherValidator in other.validators.reversed) {
      if (validators.none((v) => v == otherValidator)) return false;
    }

    return true;
  }
}

class _FieldMemberTypeValidator extends _MemberTypeValidator {
  const _FieldMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) => element is FieldElement;
}

class _ConstructorMemberTypeValidator extends _MemberTypeValidator {
  const _ConstructorMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) =>
      element is ConstructorElement;
}

class _DynamicMemberTypeValidator extends _MemberTypeValidator {
  const _DynamicMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (element is FieldElement) {
      return member.thisOrAncestorOfType<FieldDeclaration>()?.fields.type ==
          null;
    }
    if (element is MethodElement) {
      return member.thisOrAncestorOfType<MethodDeclaration>()?.returnType ==
          null;
    }
    return false;
  }
}

class _MethodMemberTypeValidator extends _MemberTypeValidator {
  const _MethodMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) => element is MethodElement;
}

class _GetterMemberTypeValidator extends _MemberTypeValidator {
  const _GetterMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) => element is GetterElement;
}

class _SetterMemberTypeValidator extends _MemberTypeValidator {
  const _SetterMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) => element is SetterElement;
}

class _ExpectedNamedMemberTypeValidator extends _MemberTypeValidator {
  const _ExpectedNamedMemberTypeValidator({
    required this.expectedName,
  });

  final String expectedName;

  @override
  bool isValid(AstNode member, Element element) => element.name == expectedName;
}

class _AbstractMemberTypeValidator extends _MemberTypeValidator {
  const _AbstractMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (element is ConstructorElement) {
      return element.isAbstract;
    }
    if (element is FieldElement) {
      return element.isAbstract;
    }
    if (element is MethodElement) {
      return element.isAbstract;
    }
    return false;
  }
}

class _ConstMemberTypeValidator extends _MemberTypeValidator {
  const _ConstMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (element is FieldElement) {
      return element.isConst;
    }
    if (element is ConstructorElement) {
      return element.isConst;
    }
    return false;
  }
}

class _ExternalMemberTypeValidator extends _MemberTypeValidator {
  const _ExternalMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (element is FieldElement) {
      return element.isExternal;
    }
    if (element is MethodElement) {
      return element.isExternal;
    }
    if (element is ConstructorElement) {
      return element.isExternal;
    }
    return false;
  }
}

class _FactoryMemberTypeValidator extends _MemberTypeValidator {
  const _FactoryMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (element is ConstructorElement) {
      return element.isFactory;
    }
    return false;
  }
}

class _FinalMemberTypeValidator extends _MemberTypeValidator {
  const _FinalMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (element is FieldElement) {
      return element.isFinal;
    }
    return false;
  }
}

class _InitializedMemberTypeValidator extends _MemberTypeValidator {
  const _InitializedMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (member is! FieldDeclaration) {
      return false;
    }
    var fieldDeclaration = member.thisOrAncestorOfType<FieldDeclaration>();
    if (fieldDeclaration == null) {
      return false;
    }
    for (var variable in fieldDeclaration.fields.variables) {
      if (variable.declaredFragment?.element == element &&
          variable.initializer != null) {
        return true;
      }
    }
    return false;
  }
}

class _InstanceMemberTypeValidator extends _MemberTypeValidator {
  const _InstanceMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (element is FieldElement) {
      return !element.isStatic;
    }
    if (element is MethodElement) {
      return !element.isStatic;
    }
    return false;
  }
}

class _LateMemberTypeValidator extends _MemberTypeValidator {
  const _LateMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (member is! FieldDeclaration) {
      return false;
    }
    var fieldDeclaration = member.thisOrAncestorOfType<FieldDeclaration>();
    if (fieldDeclaration == null) {
      return false;
    }
    return fieldDeclaration.fields.isLate;
  }
}

class _NamedMemberTypeValidator extends _MemberTypeValidator {
  const _NamedMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (member is! ConstructorDeclaration) {
      return false;
    }
    return member.name != null;
  }
}

class _NewMemberTypeValidator extends _MemberTypeValidator {
  const _NewMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    var enclosingElement = element.enclosingElement;
    if (enclosingElement is InterfaceElement) {
      for (var name in enclosingElement.inheritedMembers.keys) {
        if (name.name == element.lookupName) {
          return false;
        }
      }
      return true;
    }
    if (enclosingElement is ExtensionElement) {
      return true;
    }
    return false;
  }
}

class _NullableMemberTypeValidator extends _MemberTypeValidator {
  const _NullableMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    DartType? type;
    if (element is FieldElement) {
      type = element.type;
    } else if (element is MethodElement) {
      type = element.returnType;
    } else if (element is PropertyAccessorElement) {
      type = element.returnType;
    }
    return type?.nullabilitySuffix == NullabilitySuffix.question;
  }
}

class _OperatorMemberTypeValidator extends _MemberTypeValidator {
  const _OperatorMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (member is! MethodDeclaration) {
      return false;
    }
    return member.isOperator;
  }
}

class _OverriddenMemberTypeValidator extends _MemberTypeValidator {
  const _OverriddenMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    var enclosingElement = element.enclosingElement;
    if (enclosingElement is InterfaceElement) {
      for (var name in enclosingElement.inheritedMembers.keys) {
        if (name.name == element.lookupName) {
          return true;
        }
      }
    }
    return false;
  }
}

class _PrivateMemberTypeValidator extends _MemberTypeValidator {
  const _PrivateMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) => element.isPrivate;
}

class _PublicMemberTypeValidator extends _MemberTypeValidator {
  const _PublicMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) => element.isPublic;
}

class _RedirectingMemberTypeValidator extends _MemberTypeValidator {
  const _RedirectingMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (member is! ConstructorDeclaration) {
      return false;
    }
    return member.redirectedConstructor != null;
  }
}

class _StaticMemberTypeValidator extends _MemberTypeValidator {
  const _StaticMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (element is FieldElement) {
      return element.isStatic;
    }
    if (element is MethodElement) {
      return element.isStatic;
    }
    return false;
  }
}

class _TypedMemberTypeValidator extends _MemberTypeValidator {
  const _TypedMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (element is FieldElement) {
      return member.thisOrAncestorOfType<FieldDeclaration>()?.fields.type !=
          null;
    }
    if (element is MethodElement) {
      return member.thisOrAncestorOfType<MethodDeclaration>()?.returnType !=
          null;
    }
    return false;
  }
}

class _UnnamedMemberTypeValidator extends _MemberTypeValidator {
  const _UnnamedMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (member is! ConstructorDeclaration) {
      return false;
    }
    return member.name == null;
  }
}

class _VarMemberTypeValidator extends _MemberTypeValidator {
  const _VarMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (element is FieldElement) {
      var keyword = member
          .thisOrAncestorOfType<FieldDeclaration>()
          ?.fields
          .keyword;
      return keyword?.keyword == Keyword.VAR;
    }
    return false;
  }
}
