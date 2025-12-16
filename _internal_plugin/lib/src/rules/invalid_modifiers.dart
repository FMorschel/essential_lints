import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart';

import 'consider_mixin.dart';
import 'diagnostic.dart';

class InvalidModifiersRule extends MultiAnalysisRule with ConsiderMixin {
  InvalidModifiersRule()
    : super(
        name: _diagnostic.name,
        description: 'Modifiers that are invalid for a given modifier.',
      );

  static const _diagnostic = InternalDiagnosticCode(
    name: 'invalid_modifiers',
    problemMessage: 'This modifier is invalid for {0}.',
    correctionMessage: 'Remove the invalid modifier.',
    severity: .ERROR,
  );

  final DiagnosticCode diagnosticCode = _diagnostic;

  @override
  List<DiagnosticCode> get diagnosticCodes => [
    diagnosticCode,
    multipleConsider,
  ];

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _InvalidModifiersVisitor(this, context);
    registry
      ..addDotShorthandPropertyAccess(this, visitor)
      ..addDotShorthandConstructorInvocation(this, visitor);
    final considerAnnotationVisitor = ConsiderAnnotationVisitor(this, context);
    registry
      ..addConstructorDeclaration(this, considerAnnotationVisitor)
      ..addFieldDeclaration(this, considerAnnotationVisitor);
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
    var consider = node.propertyName.element?.metadata.annotations
        .where(rule.isConsider)
        .firstOrNull;
    if (_process(rule.parseType(consider) ?? node.staticType)) {
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
      var consider = node.constructorName.element?.metadata.annotations
          .where(rule.isConsider)
          .firstOrNull;
      if (_process(rule.parseType(consider) ?? node.staticType)) {
        _node = node.constructorName;
        node.parent?.accept(this);
        _type = null;
      }
      return;
    }
    var typeElement = _typeElement(node);
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
          rule.reportAtNode(
            _node,
            diagnosticCode: rule.diagnosticCode,
            arguments: [node.constructorName.name],
          );
        }
      }
    }
  }

  Element? _typeElement(DotShorthandConstructorInvocation node) {
    var typeElement =
        rule
            .parseType(
              node.element?.metadata.annotations
                  .where(rule.isConsider)
                  .firstOrNull,
            )
            ?.element ??
        node.element?.enclosingElement;
    return typeElement;
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
