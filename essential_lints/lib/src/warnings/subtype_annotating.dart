import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../rules/analysis_rule.dart';
import '../utils/base_visitor.dart';
import '../utils/dart_object_to_string.dart';
import '../utils/extensions/list.dart';
import 'essential_lint_warnings.dart';
import 'subtype_rule_mixin.dart';
import 'warning.dart';

/// {@template subtype_annotating_rule}
/// The rule for subtype_annotating warning.
/// {@endtemplate}
@staticLoggerEnforcement
class SubtypeAnnotatingRule
    extends MultiWarningRule<SubtypeAnnotatingRule, SubtypeAnnotating>
    with SubtypeRuleMixin {
  /// {@macro subtype_annotating_rule}
  SubtypeAnnotatingRule() : super(.subtypeAnnotating, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'SubtypeAnnotatingRule',
  );

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

class _SubtypeAnnotatingVisitor extends BaseVisitor<SubtypeAnnotatingRule>
    with SubtypeRuleMixin {
  _SubtypeAnnotatingVisitor(super.rule, super.context);

  static const _annotationName = 'SubtypeAnnotating';

  static final Uri _annotationUri = .parse(
    'package:essential_lints_annotations/src/subtype_annotating.dart',
  );

  @override
  void visitAnnotation(Annotation node) {
    logger.info('_SubtypeAnnotatingVisitor.visitAnnotation() started');
    if (_isSubtypeAnnotation(node.elementAnnotation)) {
      logger.fine('Found SubtypeAnnotating annotation');
      var annotation = _mapKnownArguments(node.elementAnnotation);
      logger.finer(
        'Annotation mapped with ${annotation.annotations.length} annotations',
      );
      for (var parameter in [...?node.arguments?.arguments]) {
        if (parameter case NamedExpression(
          :var name,
        ) when name.label.token.lexeme != 'annotations') {
          logger.finer(
            'Skipping non-annotations parameter: ${name.label.token.lexeme}',
          );
          continue;
        }
        if (parameter is! NamedExpression) {
          logger.finer('Parameter is not NamedExpression, skipping');
          continue;
        }
        var list = parameter.expression;
        logger.finer('Parameter expression type: ${list.runtimeType}');
        if (list is! ListLiteral) {
          logger.finer('Expression is not ListLiteral, skipping');
          continue;
        }
        logger.fine(
          'Found annotations list with ${list.elements.length} elements',
        );
        for (var element in list.elements) {
          if (element is ConstructorReference) {
            logger.fine(
              'Found ConstructorReference instead of type, reporting error',
            );
            rule.reportAtNode(
              // ignore: _internal_plugin/report_shorter_lengths more meaningful
              element,
              diagnosticCode: SubtypeAnnotating.constructorNotType,
            );
          }
        }
      }
      if (annotation.annotations.isEmpty) {
        logger.fine('Missing annotation list, reporting error');
        rule.reportAtNode(
          // ignore: _internal_plugin/report_shorter_lengths more meaningful
          node.name,
          diagnosticCode: SubtypeAnnotating.missingAnnotation,
        );
      }
    }
    logger.info('_SubtypeAnnotatingVisitor.visitAnnotation() completed');
    super.visitAnnotation(node);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    logger.fine(
      'visitClassDeclaration() for: ${node.namePart.typeName.lexeme}',
    );
    var abstractOrSealed =
        node.abstractKeyword != null || node.sealedKeyword != null;
    logger.finer(
      'Class is ${abstractOrSealed ? "abstract/sealed" : "concrete"}',
    );
    _verifySuperTypes(
      node.namePart.typeName,
      node.declaredFragment?.element,
      node.metadata,
      abstract: abstractOrSealed,
    );
    super.visitClassDeclaration(node);
  }

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    logger.fine('visitEnumDeclaration() for: ${node.namePart.typeName.lexeme}');
    _verifySuperTypes(
      node.namePart.typeName,
      node.declaredFragment?.element,
      node.metadata,
    );
    super.visitEnumDeclaration(node);
  }

  @override
  void visitExtensionTypeDeclaration(ExtensionTypeDeclaration node) {
    logger.fine(
      'visitExtensionTypeDeclaration() for: '
      '${node.primaryConstructor.typeName.lexeme}',
    );
    _verifySuperTypes(
      node.primaryConstructor.typeName,
      node.declaredFragment?.element,
      node.metadata,
    );
    super.visitExtensionTypeDeclaration(node);
  }

  @override
  void visitMixinDeclaration(MixinDeclaration node) {
    logger.fine('visitMixinDeclaration() for: ${node.name.lexeme}');
    _verifySuperTypes(node.name, node.declaredFragment?.element, node.metadata);
    super.visitMixinDeclaration(node);
  }

  bool _isSubtypeAnnotation(ElementAnnotation? annotation) {
    if (annotation == null) {
      return false;
    }
    if (annotation.element?.displayName != _annotationName) {
      return false;
    }
    return annotation.element?.library?.uri == _annotationUri;
  }

  _SubtypeAnnotatingAnnotation _mapKnownArguments(
    ElementAnnotation? annotation,
  ) {
    logger.fine('_mapKnownArguments() started');
    if (annotation == null) {
      logger.finer('Annotation is null, returning empty');
      return .empty;
    }

    var type = annotation.computeConstantValue();
    logger.finer(
      'Computed constant value: ${type != null ? "success" : "null"}',
    );
    if (type == null) {
      logger.finer('Type is null, returning empty');
      return .empty;
    }
    var annotations = [...?type.getField('annotations')?.toListValue()];
    var onlyConcrete = type.getField('option');
    var packageOption = type.getField('packageOption');

    logger.fine(
      '_mapKnownArguments() returning ${annotations.length} annotations',
    );
    return _SubtypeAnnotatingAnnotation(
      annotations: annotations,
      option: onlyConcrete,
      packageOption: packageOption,
    );
  }

  void _verifySuperTypes(
    SyntacticEntity name,
    InterfaceElement? element,
    NodeList<Annotation> metadata, {
    bool abstract = false,
  }) {
    logger.info('_verifySuperTypes() started');
    if (element == null) {
      logger.finer('Element is null, returning');
      return;
    }
    logger.fine(
      'Verifying supertypes for: ${element.name}, abstract=$abstract',
    );
    var annotations = collectSuperTypeAnnotations<_SubtypeAnnotatingAnnotation>(
      element,
      _isSubtypeAnnotation,
      _mapKnownArguments,
    );

    logger.fine('Total annotations to check: ${annotations.length}');
    bool existing(DartObject annotation) {
      for (var meta in metadata) {
        var value = meta.elementAnnotation?.computeConstantValue();
        if (value == null) continue;
        if (value == annotation || annotation.toTypeValue() == value.type) {
          return true;
        }
      }
      return false;
    }

    var missingCount = 0;
    for (var MapEntry(key: annotation, value: origin) in annotations) {
      if (shouldSkipAnnotation(
        annotation,
        element,
        origin,
        abstract: abstract,
        isMixin: element is MixinElement,
      )) {
        logger.finer('  Skipping due to subtype annotation options');
        continue;
      }
      logger.finer(
        'Checking annotation with ${annotation.annotations.length} required '
        'annotations',
      );
      var missingAnnotations = annotation.annotations.whereNot(existing);
      logger.finer('  Missing ${missingAnnotations.length} annotations');
      if (missingAnnotations.isNotEmpty) {
        missingCount += missingAnnotations.length;
        var annotationNames = missingAnnotations
            .map(dartObjectToString)
            .commaSeparatedWithAnd;
        logger.fine('Reporting missing annotations: $annotationNames');
        switch (name) {
          case Token():
            rule.reportAtToken(
              name,
              diagnosticCode: rule.rule,
              arguments: [annotationNames],
            );
          case AstNode():
            rule.reportAtNode(
              // ignore: _internal_plugin/report_shorter_lengths handled
              name,
              diagnosticCode: rule.rule,
              arguments: [annotationNames],
            );
        }
      }
    }
    logger.info(
      '_verifySuperTypes() completed, reported $missingCount missing '
      'annotations',
    );
  }
}

class _SubtypeAnnotatingAnnotation extends SubtypeAnnotation {
  const _SubtypeAnnotatingAnnotation({
    required this.annotations,
    required super.option,
    required super.packageOption,
  });

  static const _SubtypeAnnotatingAnnotation empty = .new(
    annotations: [],
    option: null,
    packageOption: null,
  );

  final List<DartObject> annotations;
}
