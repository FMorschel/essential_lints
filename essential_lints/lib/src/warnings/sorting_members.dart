import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:meta/meta.dart';

import 'warning.dart';

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
    final visitor = _SortingMembersVisitor(this, context);
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
      // Member matches current validator - stay on same validator
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
    final previousCurrent = current;
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
    final element = node.declaredFragment?.element;
    if (element == null) return;
    _validateMember(node, element);
  }

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    if (_reported) return;
    // Check each variable in the field declaration
    for (final variable in node.fields.variables) {
      final element = variable.declaredFragment?.element;
      if (element == null) continue;
      _validateMember(node, element);
      if (_reported) return;
    }
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    if (_reported) return;
    final element = node.declaredFragment?.element;
    if (element == null) return;
    _validateMember(node, element);
  }

  void _reportAt(AstNode node, Element element) {
    switch (node) {
      case MethodDeclaration(:var name):
        rule.reportAtToken(name);
      case FieldDeclaration(:var fields):
        for (final variable in fields.variables) {
          if (variable.declaredFragment?.element == element) {
            rule.reportAtToken(variable.name);
            return;
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
    for (final annotation in node.metadata) {
      var element = annotation.elementAnnotation;
      if (element == null) {
        continue;
      }
      if (_isSortingMembers(element)) {
        final validatorFromAnnotation = _ValidatorFromAnnotation.fromAnnotation(
          element,
        );
        final visitor = _MemberVisitor(rule, context, validatorFromAnnotation);
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
    var validators = <_MemberTypeValidator>[];
    for (final declaration in {...?declarations}) {
      var list = <_MemberTypeValidator>[];
      var typeName = declaration.type?.element?.lookupName;
      do {
        switch (typeName) {
          case 'Field':
            list.add(const _FieldMemberTypeValidator());
            list.add(
              _ExpectedNamedMemberTypeValidator(
                expectedName:
                    declaration.getField('name')?.toSymbolValue() ?? '',
              ),
            );
          case 'Constructor':
            list.add(const _ConstructorMemberTypeValidator());
            list.add(
              _ExpectedNamedMemberTypeValidator(
                expectedName:
                    declaration.getField('name')?.toSymbolValue() ?? '',
              ),
            );
          case 'Method':
            list.add(const _MethodMemberTypeValidator());
            list.add(
              _ExpectedNamedMemberTypeValidator(
                expectedName:
                    declaration.getField('name')?.toSymbolValue() ?? '',
              ),
            );
          case 'Getter':
            list.add(const _GetterMemberTypeValidator());
            list.add(
              _ExpectedNamedMemberTypeValidator(
                expectedName:
                    declaration.getField('name')?.toSymbolValue() ?? '',
              ),
            );
          case 'Setter':
            list.add(const _SetterMemberTypeValidator());
            list.add(
              _ExpectedNamedMemberTypeValidator(
                expectedName:
                    declaration.getField('name')?.toSymbolValue() ?? '',
              ),
            );
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
          case 'Named':
            list.add(const _NamedMemberTypeValidator());
          case 'Abstract':
            list.add(const _AbstractMemberTypeValidator());
          case 'Const':
            list.add(const _ConstMemberTypeValidator());
          case 'External':
            list.add(const _ExternalMemberTypeValidator());
          case 'Factory':
            list.add(const _FactoryMemberTypeValidator());
          case 'Final':
            list.add(const _FinalMemberTypeValidator());
          case 'Initialized':
            list.add(const _InitializedMemberTypeValidator());
          case 'Late':
            list.add(const _LateMemberTypeValidator());
          case 'Nullable':
            list.add(const _NullableMemberTypeValidator());
          case 'Operator':
            list.add(const _OperatorMemberTypeValidator());
          case 'Overriden':
            list.add(const _OverridenMemberTypeValidator());
          case 'Private':
            list.add(const _PrivateMemberTypeValidator());
          case 'Public':
            list.add(const _PublicMemberTypeValidator());
          case 'Redirecting':
            list.add(const _RedirectingMemberTypeValidator());
          case 'Static':
            list.add(const _StaticMemberTypeValidator());
          case 'Unnamed':
            list.add(const _UnnamedMemberTypeValidator());
          case 'Var':
            list.add(const _VarMemberTypeValidator());
          default:
            assert(false, 'Unknown member type: $declaration');
        }
        var member = declaration.getField('modifiable');
        typeName = member?.type?.element?.lookupName;
      } while (typeName != null);
      validators.add(_ListMemberTypeValidator(validators: list));
    }
    return _ValidatorFromAnnotation._(
      annotation: annotation,
      validators: validators,
    );
  }

  final ElementAnnotation annotation;
  final List<_MemberTypeValidator> validators;
}

@immutable
sealed class _MemberTypeValidator {
  const _MemberTypeValidator();

  bool isValid(AstNode member, Element element);
}

class _ListMemberTypeValidator extends _MemberTypeValidator {
  const _ListMemberTypeValidator({
    required this.validators,
  });

  final List<_MemberTypeValidator> validators;

  @override
  bool isValid(AstNode member, Element element) {
    for (final validator in validators) {
      if (!validator.isValid(member, element)) {
        return false;
      }
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
    for (final variable in fieldDeclaration.fields.variables) {
      if (variable.declaredFragment?.element == element &&
          variable.initializer != null) {
        return true;
      }
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

class _OverridenMemberTypeValidator extends _MemberTypeValidator {
  const _OverridenMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (element is MethodElement) {
      return element.baseElement != element;
    }
    if (element is PropertyAccessorElement) {
      return element.baseElement != element;
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
      return !element.isFinal && !element.isConst;
    }
    return false;
  }
}
