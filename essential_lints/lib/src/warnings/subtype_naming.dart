import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';

import 'essential_lint_warnings.dart';
import 'warning.dart';

/// {@template subtype_naming}
/// The list of sub-warnings for the SubtypeNaming warning.
/// {@endtemplate}
class SubtypeNamingRule extends MultiWarningRule<SubtypeNaming> {
  /// {@macro subtype_naming}
  SubtypeNamingRule() : super(.subtypeNaming);

  @override
  List<SubtypeNaming> get subWarnings => SubtypeNaming.values;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _SubtypeNamingVisitor(this, context);
    registry
      ..addAnnotation(this, visitor)
      ..addClassDeclaration(this, visitor)
      ..addEnumDeclaration(this, visitor)
      ..addExtensionTypeDeclaration(this, visitor)
      ..addMixinDeclaration(this, visitor);
  }
}

class _SubtypeNamingAnnotation {
  const _SubtypeNamingAnnotation({
    required this.prefixName,
    required this.suffixName,
    required this.containingName,
  });

  static _SubtypeNamingAnnotation empty = const .new(
    prefixName: null,
    suffixName: null,
    containingName: null,
  );

  final String? prefixName;
  final String? suffixName;
  final String? containingName;
}

class _SubtypeNamingVisitor extends SimpleAstVisitor<void> {
  _SubtypeNamingVisitor(this.rule, this.context);

  static const _annotationName = 'SubtypeNaming';

  static final Uri _annotationUri = .parse(
    'package:essential_lints_annotations/src/subtype_naming.dart',
  );

  final SubtypeNamingRule rule;
  final RuleContext context;

  @override
  void visitAnnotation(Annotation node) {
    if (_isSubtypeNamingAnnotation(node.elementAnnotation)) {
      var annotation = _mapKnownArguments(node.elementAnnotation);
      if (annotation.prefixName == null &&
          annotation.suffixName == null &&
          annotation.containingName == null) {
        rule.reportAtNode(
          node,
          diagnosticCode: SubtypeNaming.missingNameDefinition,
        );
      }
    }
    super.visitAnnotation(node);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    _verifySuperTypes(node.name, node.declaredFragment?.element);
    super.visitClassDeclaration(node);
  }

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    _verifySuperTypes(node.name, node.declaredFragment?.element);
    super.visitEnumDeclaration(node);
  }

  @override
  void visitExtensionTypeDeclaration(ExtensionTypeDeclaration node) {
    _verifySuperTypes(node.name, node.declaredFragment?.element);
    super.visitExtensionTypeDeclaration(node);
  }

  @override
  void visitMixinDeclaration(MixinDeclaration node) {
    _verifySuperTypes(node.name, node.declaredFragment?.element);
    super.visitMixinDeclaration(node);
  }

  bool _isSubtypeNamingAnnotation(ElementAnnotation? annotation) {
    if (annotation == null) {
      return false;
    }
    if (annotation.element?.displayName != _annotationName) {
      return false;
    }
    return annotation.element?.library?.uri == _annotationUri;
  }

  _SubtypeNamingAnnotation _mapKnownArguments(ElementAnnotation? annotation) {
    if (annotation == null) return .empty;

    var element = annotation.element;
    if (element is! ConstructorElement) return .empty;

    var type = annotation.computeConstantValue();
    if (type == null) return .empty;
    var prefixName = type.getField('prefixName')?.toStringValue();
    var suffixName = type.getField('suffixName')?.toStringValue();
    var containingName = type.getField('containingName')?.toStringValue();

    return _SubtypeNamingAnnotation(
      prefixName: prefixName,
      suffixName: suffixName,
      containingName: containingName,
    );
  }

  void _verifySuperTypes(Token name, InterfaceElement? element) {
    if (element == null) {
      return;
    }
    var annotations = <_SubtypeNamingAnnotation>[];
    var visitedElements = <InterfaceElement>{element};
    for (final interface in element.allSupertypes) {
      var current = interface.element;
      if (!visitedElements.add(current)) {
        continue;
      }
      annotations.addAll(
        current.metadata.annotations
            .where(_isSubtypeNamingAnnotation)
            .map(_mapKnownArguments),
      );
    }
    for (final annotation in annotations) {
      var typeName = name.lexeme;
      if (annotation.prefixName != null &&
          !typeName.startsWith(annotation.prefixName!)) {
        rule.reportAtToken(
          name,
          diagnosticCode: rule.rule,
        );
      } else if (annotation.suffixName != null &&
          !typeName.endsWith(annotation.suffixName!)) {
        rule.reportAtToken(
          name,
          diagnosticCode: rule.rule,
        );
      } else if (annotation.containingName != null &&
          !typeName.contains(annotation.containingName!)) {
        rule.reportAtToken(
          name,
          diagnosticCode: rule.rule,
        );
      }
    }
  }
}
