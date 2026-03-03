import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/src/dart/ast/ast.dart';
import 'package:collection/collection.dart';
import 'package:essential_lints/src/plugin.dart';
import 'package:essential_lints/src/rules/analysis_rule.dart';
import 'package:essential_lints/src/utils/base_visitor.dart';
import 'package:logging/logging.dart';

import 'diagnostic.dart';
import 'rule.dart';

@staticLoggerEnforcement
class StaticEnforcementRule extends LintRule<StaticEnforcementRule> {
  StaticEnforcementRule() : super(_diagnostic, _logger);

  static const _diagnostic = InternalDiagnosticCode(
    rule: .staticEnforcement,
    problemMessage: "A member named '{0}' should be declared and be static.",
    correctionMessage: "Declare '{0}' as static.",
  );

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'StaticEnforcementRule',
  );

  @override
  InternalDiagnosticCode get diagnosticCode => _diagnostic;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _StaticEnforcementVisitor(this, context);
    registry
      ..addClassDeclaration(this, visitor)
      ..addMixinDeclaration(this, visitor)
      ..addExtensionDeclaration(this, visitor)
      ..addEnumDeclaration(this, visitor)
      ..addExtensionTypeDeclaration(this, visitor);
  }
}

class _StaticEnforcementVisitor extends BaseVisitor<StaticEnforcementRule> {
  _StaticEnforcementVisitor(super.rule, super.context);

  static final Uri _staticEnforcementUri = .parse(
    'package:essential_lints_annotations/src/_internal/static_enforcement.dart',
  );

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    _handleInstanceElement(
      node.declaredFragment?.element,
      node.namePart.typeName,
    );
  }

  @override
  void visitMixinDeclaration(MixinDeclaration node) {
    _handleInstanceElement(node.declaredFragment?.element, node.name);
  }

  @override
  void visitExtensionDeclaration(ExtensionDeclaration node) {
    _handleInstanceElement(
      node.declaredFragment?.element,
      node.name ?? node.extensionKeyword,
    );
  }

  @override
  void visitExtensionTypeDeclaration(ExtensionTypeDeclaration node) {
    _handleInstanceElement(
      node.declaredFragment?.element,
      node.primaryConstructor.typeName,
    );
  }

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    _handleInstanceElement(
      node.declaredFragment?.element,
      node.namePart.typeName,
    );
  }

  void _handleInstanceElement(InstanceElement? element, Token node) {
    if (element == null) return;

    var annotations = element.metadata.annotations.where(_isStaticEnforcement);
    for (var annotation in annotations) {
      var memberName = annotation
          .computeConstantValue()
          ?.getField('memberName')
          ?.toSymbolValue();
      if (memberName == null) continue;
      var members = [
        ...element.fields,
        ...element.methods,
        ...element.getters,
        ...element.setters,
        if (element case InterfaceElement(:var constructors)) ...constructors,
      ];
      var memberWithName = members.firstWhereOrNull(
        (member) => member.name == memberName,
      );
      if (memberWithName == null) {
        rule.reportAtToken(node, arguments: [memberName]);
        continue;
      }
      if (memberWithName
          case FieldElement(:var isStatic) ||
              MethodElement(:var isStatic) ||
              GetterElement(:var isStatic) ||
              SetterElement(:var isStatic) ||
              ConstructorElement(:var isStatic) when !isStatic) {
        rule.reportAtToken(node, arguments: [memberName]);
        continue;
      }
      var type = annotation.computeConstantValue()?.getField('type')?.type;
      if (type is InterfaceType && !type.isDartCoreNull) {
        var argument = type.typeArguments.first;
        if (memberWithName
            case FieldElement(:var type) ||
                MethodElement(type: FunctionType(returnType: var type)) ||
                GetterElement(type: FunctionType(returnType: var type)) ||
                ConstructorElement(returnType: DartType type) ||
                SetterElement(
                  type: FunctionType(
                    formalParameters: List<FormalParameterElement>(
                      first: FormalParameterElement(:var type),
                    ),
                  ),
                ) when !typeSystem.isAssignableTo(type, argument)) {
          rule.reportAtToken(node, arguments: [memberName]);
        }
      }
    }
  }

  bool _isStaticEnforcement(ElementAnnotation element) {
    var value = element.computeConstantValue();
    if (value == null) return false;
    var type = value.type;
    if (type == null) return false;
    return type.element?.lookupName == 'StaticEnforcement' &&
        type.element?.library?.uri == _staticEnforcementUri;
  }
}
