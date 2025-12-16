import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/src/dart/ast/ast.dart';

import 'consider_mixin.dart';
import 'diagnostic.dart';

class InvalidMembersRule extends MultiAnalysisRule with ConsiderMixin {
  InvalidMembersRule()
    : super(
        name: _diagnostic.name,
        description: 'Members that are invalid for a given modifier.',
      );

  static const _diagnostic = InternalDiagnosticCode(
    name: 'invalid_members',
    problemMessage: 'This member is invalid {0}.',
    correctionMessage: 'Remove the invalid member.',
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
    final visitor = _InvalidMembersVisitor(this, context);
    registry
      ..addDotShorthandPropertyAccess(this, visitor)
      ..addDotShorthandConstructorInvocation(this, visitor);
    final considerAnnotationVisitor = ConsiderAnnotationVisitor(this, context);
    registry
      ..addConstructorDeclaration(this, considerAnnotationVisitor)
      ..addFieldDeclaration(this, considerAnnotationVisitor);
  }
}

class _InvalidMembersVisitor extends SimpleAstVisitor<void> {
  _InvalidMembersVisitor(this.rule, this.context);

  final InvalidMembersRule rule;
  final RuleContext context;
  DartType? _type;
  AstNode? _node;

  @override
  void visitDotShorthandPropertyAccess(DotShorthandPropertyAccess node) {
    var element = node.propertyName.element;
    element = element is PropertyAccessorElement ? element.variable : element;
    var consider = element?.metadata.annotations
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
    ) when allSupertypes.any(_isGroupType)) {
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
    var invalidMembersAnnotations = typeElement.metadata.annotations
        .where(_isInvalidMembers)
        .toList();
    for (final annotation in invalidMembersAnnotations) {
      var constantValue = annotation.computeConstantValue();
      if (constantValue == null) continue;
      var invalidMembers = constantValue.getField('invalidMembers');
      if (invalidMembers == null) continue;
      for (final member in [...?invalidMembers.toListValue()]) {
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

  bool _isInvalidMembers(ElementAnnotation element) {
    if (element.computeConstantValue() case DartObject(:var type)) {
      return type?.element?.name == 'InvalidMembers' &&
          type?.element?.library?.uri ==
              .parse(
                'package:essential_lints_annotations/src/_internal/invalid_members.dart',
              );
    }
    return false;
  }

  bool _isGroupType(InterfaceType element) {
    return element.element.name == 'Group' &&
        element.element.library.uri ==
            .parse(
              'package:essential_lints_annotations/src/sorting_members/'
              'sort_declarations.dart',
            );
  }
}
