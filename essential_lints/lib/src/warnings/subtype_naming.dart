import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../rules/analysis_rule.dart';
import '../utils/base_visitor.dart';
import 'essential_lint_warnings.dart';
import 'subtype_rule_mixin.dart';
import 'warning.dart';

/// {@template subtype_naming_rule}
/// The rule for the subtype_naming warning.
/// {@endtemplate}
@staticLoggerEnforcement
class SubtypeNamingRule
    extends MultiWarningRule<SubtypeNamingRule, SubtypeNaming>
    with SubtypeRuleMixin {
  /// {@macro subtype_naming_rule}
  SubtypeNamingRule() : super(.subtypeNaming, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'SubtypeNamingRule',
  );

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

class _SubtypeNamingAnnotation extends SubtypeAnnotation {
  const _SubtypeNamingAnnotation({
    required this.prefix,
    required this.suffix,
    required this.containing,
    required super.option,
    required super.packageOption,
  });

  static const _SubtypeNamingAnnotation empty = .new(
    prefix: null,
    suffix: null,
    containing: null,
    option: null,
    packageOption: null,
  );

  final String? prefix;
  final String? suffix;
  final String? containing;
}

class _SubtypeNamingVisitor extends BaseVisitor<SubtypeNamingRule>
    with SubtypeRuleMixin {
  _SubtypeNamingVisitor(super.rule, super.context);

  static const _annotationName = 'SubtypeNaming';

  static final Uri _annotationUri = .parse(
    'package:essential_lints_annotations/src/subtype_naming.dart',
  );

  @override
  void visitAnnotation(Annotation node) {
    logger.info('_SubtypeNamingVisitor.visitAnnotation() started');
    if (_isSubtypeNamingAnnotation(node.elementAnnotation)) {
      logger.fine('Found SubtypeNaming annotation');
      var annotation = _mapKnownArguments(node.elementAnnotation);
      logger.finer(
        'Annotation mapped: prefix=${annotation.prefix}, '
        'suffix=${annotation.suffix}, containing=${annotation.containing}',
      );
      if (annotation.prefix == null &&
          annotation.suffix == null &&
          annotation.containing == null) {
        logger.fine(
          'No naming constraints defined, reporting missing definition',
        );
        rule.reportAtNode(
          // ignore: _internal_plugin/report_shorter_lengths more meaningful
          node.constructorName ?? node.name,
          diagnosticCode: SubtypeNaming.missingNameDefinition,
        );
      } else {
        logger.fine('Naming definition present');
      }
    }
    logger.info('_SubtypeNamingVisitor.visitAnnotation() completed');
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
      abstract: abstractOrSealed,
    );
    super.visitClassDeclaration(node);
  }

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    logger.fine('visitEnumDeclaration() for: ${node.namePart.typeName.lexeme}');
    _verifySuperTypes(node.namePart.typeName, node.declaredFragment?.element);
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
    );
    super.visitExtensionTypeDeclaration(node);
  }

  @override
  void visitMixinDeclaration(MixinDeclaration node) {
    logger.fine('visitMixinDeclaration() for: ${node.name.lexeme}');
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
    logger.fine('_mapKnownArguments() started');
    if (annotation == null) {
      logger.finer('Annotation is null, returning empty');
      return .empty;
    }

    var element = annotation.element;
    logger.finer(
      'Annotation element: ${element?.displayName ?? "null"}, type: '
      '${element.runtimeType}',
    );
    if (element is! ConstructorElement) {
      logger.finer('Element is not ConstructorElement, returning empty');
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
    var prefix = type.getField('prefix')?.toStringValue();
    var suffix = type.getField('suffix')?.toStringValue();
    var containing = type.getField('containing')?.toStringValue();
    var option = type.getField('option');
    var packageOption = type.getField('packageOption');

    logger.fine(
      '_mapKnownArguments() returning annotation: prefix=$prefix, '
      'suffix=$suffix, containing=$containing',
    );
    return _SubtypeNamingAnnotation(
      prefix: prefix,
      suffix: suffix,
      containing: containing,
      option: option,
      packageOption: packageOption,
    );
  }

  void _verifySuperTypes(
    SyntacticEntity name,
    InterfaceElement? element, {
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
    var annotations = collectSuperTypeAnnotations<_SubtypeNamingAnnotation>(
      element,
      _isSubtypeNamingAnnotation,
      _mapKnownArguments,
    );

    logger.fine('Total annotations to check: ${annotations.length}');
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
        'Checking annotation: prefix=${annotation.prefix}, '
        'suffix=${annotation.suffix}, containing=${annotation.containing}',
      );
      var typeName = switch (name) {
        Token() => name.lexeme,
        Identifier() => name.name,
        _ => '',
      };
      logger.finer('  Type name to verify: "$typeName"');
      var violations = <String>[];
      if (annotation.prefix != null &&
          !typeName.startsWith(annotation.prefix!)) {
        logger.fine(
          '  Prefix violation: expected prefix "${annotation.prefix}"',
        );
        violations.add('prefix');
      }
      if (annotation.suffix != null && !typeName.endsWith(annotation.suffix!)) {
        logger.fine(
          '  Suffix violation: expected suffix "${annotation.suffix}"',
        );
        violations.add('suffix');
      }
      if (annotation.containing != null &&
          !typeName.contains(annotation.containing!)) {
        logger.fine(
          '  Containing violation: expected containing '
          '"${annotation.containing}"',
        );
        violations.add('containing');
      }
      if (violations.isNotEmpty) {
        logger.fine('Reporting naming violation for ${violations.join(", ")}');
        switch (name) {
          case Token():
            rule.reportAtToken(name, diagnosticCode: rule.rule);
          case AstNode():
            rule.reportAtNode(
              // ignore: _internal_plugin/report_shorter_lengths handled
              name,
              diagnosticCode: rule.rule,
            );
        }
      }
    }
    logger.info('_verifySuperTypes() completed');
  }
}
