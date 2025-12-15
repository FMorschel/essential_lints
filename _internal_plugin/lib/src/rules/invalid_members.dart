import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/src/dart/ast/ast.dart';

import 'diagnostic.dart';

class InvalidMembersRule extends AnalysisRule {
  InvalidMembersRule()
    : super(
        name: 'invalid_members',
        description: 'Members that are invalid for a given modifier.',
      );

  @override
  DiagnosticCode get diagnosticCode => InternalDiagnosticCode(
    name: name,
    problemMessage: 'This member is invalid for the given modifier.',
    uniqueName: name,
    severity: .ERROR,
  );

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _InvalidMembersVisitor(this, context);
    registry.addDotShorthandPropertyAccess(this, visitor);
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
    if (_process(node.staticType)) {
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
      if (_process(node.staticType)) {
        _node = node.constructorName;
        node.parent?.accept(this);
        _type = null;
      }
      return;
    }
    var typeElement = node.element?.enclosingElement;
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
          rule.reportAtNode(_node);
        }
      }
    }
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
