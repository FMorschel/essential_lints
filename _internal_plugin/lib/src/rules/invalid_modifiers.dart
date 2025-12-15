import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart';

import 'diagnostic.dart';

class InvalidModifiersRule extends AnalysisRule {
  InvalidModifiersRule()
    : super(
        name: 'invalid_modifiers',
        description: 'Modifiers that are invalid for a given modifier.',
      );

  @override
  DiagnosticCode get diagnosticCode => InternalDiagnosticCode(
    name: name,
    problemMessage: 'This modifier is invalid for the given modifier.',
    uniqueName: name,
    severity: .ERROR,
  );

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _InvalidModifiersVisitor(this, context);
    registry
      ..addDotShorthandPropertyAccess(this, visitor)
      ..addDotShorthandConstructorInvocation(this, visitor);
  }
}

class _InvalidModifiersVisitor extends SimpleAstVisitor<void> {
  _InvalidModifiersVisitor(this.rule, this.context);

  final InvalidModifiersRule rule;
  final RuleContext context;
  DartType? _type;
  AstNode? _node;

  @override
  void visitDotShorthandPropertyAccess(DotShorthandPropertyAccess node) {
    if (_process(node.staticType)) {
      _node = node.propertyName;
      node.parent?.accept(this);
      _type = null;
    }
  }

  bool _process(DartType? type) {
    if (type?.element case InterfaceElement(
      :var allSupertypes,
    ) when allSupertypes.any(_isModifierType)) {
      _type = type;
      return true;
    }
    return false;
  }

  @override
  void visitArgumentList(ArgumentList node) {
    node.parent?.accept(this);
  }

  @override
  void visitDotShorthandConstructorInvocation(
    DotShorthandConstructorInvocation node,
  ) {
    if (_type == null) {
      if (_process(node.staticType)) {
        _node = node.constructorName;
        node.parent?.accept(this);
        _type = null;
      }
      return;
    }
    var typeElement = node.element?.enclosingElement;
    if (typeElement == null) return;
    var invalidModifiersAnnotations = typeElement.metadata.annotations
        .where(_isInvalidModifiers)
        .toList();
    for (final annotation in invalidModifiersAnnotations) {
      var constantValue = annotation.computeConstantValue();
      if (constantValue == null) continue;
      var invalidModifiers = constantValue.getField('invalidModifiers');
      if (invalidModifiers == null) continue;
      for (final member in [...?invalidModifiers.toListValue()]) {
        if (member.type case InterfaceType(:var typeArguments)
            when typeArguments.length == 1 &&
                context.typeSystem.isAssignableTo(
                  _type!,
                  typeArguments.first,
                )) {
          rule.reportAtNode(_node);
        }
      }
    }
  }

  bool _isInvalidModifiers(ElementAnnotation element) {
    if (element.computeConstantValue() case DartObject(:var type)) {
      return type?.element?.name == 'InvalidModifiers' &&
          type?.element?.library?.uri ==
              .parse(
                'package:essential_lints_annotations/src/_internal/invalid_modifiers.dart',
              );
    }
    return false;
  }

  bool _isModifierType(InterfaceType element) {
    return element.element.name == 'Modifier' &&
        element.element.library.uri ==
            .parse(
              'package:essential_lints_annotations/src/sorting_members/'
              'sort_declarations.dart',
            );
  }
}
