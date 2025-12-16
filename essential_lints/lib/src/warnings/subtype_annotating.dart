import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';

import '../utils/dart_object_to_string.dart';
import '../utils/extensions/list.dart';
import 'essential_lint_warnings.dart';
import 'warning.dart';

/// {@template subtype_annotating_rule}
/// The rule for subtype_annotating warning.
/// {@endtemplate}
class SubtypeAnnotatingRule extends MultiWarningRule<SubtypeAnnotating> {
  /// {@macro subtype_annotating_rule}
  SubtypeAnnotatingRule() : super(.subtypeAnnotating);

  @override
  List<SubtypeAnnotating> get subWarnings => SubtypeAnnotating.values;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _SubtypeAnnotatingVisitor(this, context);
    registry
      ..addAnnotation(this, visitor)
      ..addClassDeclaration(this, visitor)
      ..addEnumDeclaration(this, visitor)
      ..addExtensionTypeDeclaration(this, visitor)
      ..addMixinDeclaration(this, visitor);
  }
}

class _SubtypeAnnotatingVisitor extends SimpleAstVisitor<void> {
  _SubtypeAnnotatingVisitor(this.rule, this.context);

  static const _annotationName = 'SubtypeAnnotating';

  static final Uri _annotationUri = .parse(
    'package:essential_lints_annotations/src/subtype_annotating.dart',
  );

  final SubtypeAnnotatingRule rule;
  final RuleContext context;

  @override
  void visitAnnotation(Annotation node) {
    if (_isSubtypeNamingAnnotation(node.elementAnnotation)) {
      var annotation = _mapKnownArguments(node.elementAnnotation);
      for (final parameter in [...?node.arguments?.arguments]) {
        if (parameter case NamedExpression(
          :var name,
        ) when name.label.token.lexeme != 'annotations') {
          continue;
        }
        if (parameter is! NamedExpression) {
          continue;
        }
        var list = parameter.expression;
        if (list is! ListLiteral) {
          continue;
        }
        for (final element in list.elements) {
          if (element is ConstructorReference) {
            rule.reportAtNode(
              element,
              diagnosticCode: SubtypeAnnotating.constructorNotType,
            );
          }
        }
      }
      if (annotation.annotations.isEmpty) {
        rule.reportAtNode(
          node.name,
          diagnosticCode: SubtypeAnnotating.missingAnnotation,
        );
      }
    }
    super.visitAnnotation(node);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    _verifySuperTypes(
      node.name,
      node.declaredFragment?.element,
      node.metadata,
      abstract: node.abstractKeyword != null || node.sealedKeyword != null,
    );
    super.visitClassDeclaration(node);
  }

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    _verifySuperTypes(node.name, node.declaredFragment?.element, node.metadata);
    super.visitEnumDeclaration(node);
  }

  @override
  void visitExtensionTypeDeclaration(ExtensionTypeDeclaration node) {
    _verifySuperTypes(node.name, node.declaredFragment?.element, node.metadata);
    super.visitExtensionTypeDeclaration(node);
  }

  @override
  void visitMixinDeclaration(MixinDeclaration node) {
    _verifySuperTypes(node.name, node.declaredFragment?.element, node.metadata);
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
    var annotations = [...?type.getField('annotations')?.toListValue()];
    var onlyConcrete = type.getField('option');

    return _SubtypeNamingAnnotation(
      annotations: annotations,
      option: onlyConcrete,
    );
  }

  void _verifySuperTypes(
    Token name,
    InterfaceElement? element,
    NodeList<Annotation> metadata, {
    bool abstract = false,
  }) {
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

    bool existing(DartObject annotation) {
      for (final meta in metadata) {
        var value = meta.elementAnnotation?.computeConstantValue();
        if (value == null) continue;
        if (value == annotation || annotation.toTypeValue() == value.type) {
          return true;
        }
      }
      return false;
    }

    for (final annotation in annotations) {
      if (annotation.option?.variable?.name == 'onlyConcrete' && abstract) {
        continue;
      } else if (annotation.option?.variable?.name == 'onlyAbstract' &&
          !abstract) {
        continue;
      }
      var missingAnnotations = annotation.annotations.whereNot(existing);
      if (missingAnnotations.isNotEmpty) {
        rule.reportAtToken(
          name,
          diagnosticCode: rule.rule,
          arguments: [
            missingAnnotations.map(dartObjectToString).commaSeparatedWithAnd,
          ],
        );
      }
    }
  }
}

class _SubtypeNamingAnnotation {
  const _SubtypeNamingAnnotation({
    required this.annotations,
    required this.option,
  });

  static _SubtypeNamingAnnotation empty = const .new(
    annotations: [],
    option: null,
  );

  final List<DartObject> annotations;
  final DartObject? option;
}
