import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../rules/analysis_rule.dart';
import 'essential_lint_warnings.dart';
import 'warning.dart';

/// {@template subtype_naming_rule}
/// The rule for the subtype_naming warning.
/// {@endtemplate}
@staticLoggerEnforcement
class SubtypeNamingRule extends MultiWarningRule<SubtypeNaming> {
  /// {@macro subtype_naming_rule}
  SubtypeNamingRule() : super(.subtypeNaming, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'SubtypeNamingRule',
  );

  @override
  List<SubtypeNaming> get subDiagnostics => SubtypeNaming.values;

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
    required this.prefix,
    required this.suffix,
    required this.containing,
    required this.option,
  });

  static _SubtypeNamingAnnotation empty = const .new(
    prefix: null,
    suffix: null,
    containing: null,
    option: null,
  );

  final String? prefix;
  final String? suffix;
  final String? containing;
  final DartObject? option;
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
    rule.logger.info('_SubtypeNamingVisitor.visitAnnotation() started');
    if (_isSubtypeNamingAnnotation(node.elementAnnotation)) {
      rule.logger.fine('Found SubtypeNaming annotation');
      var annotation = _mapKnownArguments(node.elementAnnotation);
      rule.logger.finer(
        'Annotation mapped: prefix=${annotation.prefix}, '
        'suffix=${annotation.suffix}, containing=${annotation.containing}',
      );
      if (annotation.prefix == null &&
          annotation.suffix == null &&
          annotation.containing == null) {
        rule.logger.fine(
          'No naming constraints defined, reporting missing definition',
        );
        rule.reportAtNode(
          node,
          diagnosticCode: SubtypeNaming.missingNameDefinition,
        );
      } else {
        rule.logger.fine('Naming definition present');
      }
    }
    rule.logger.info('_SubtypeNamingVisitor.visitAnnotation() completed');
    super.visitAnnotation(node);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    rule.logger.fine(
      'visitClassDeclaration() for: ${node.namePart.typeName.lexeme}',
    );
    var abstractOrSealed =
        node.abstractKeyword != null || node.sealedKeyword != null;
    rule.logger.finer(
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
    rule.logger.fine(
      'visitEnumDeclaration() for: ${node.namePart.typeName.lexeme}',
    );
    _verifySuperTypes(node.namePart.typeName, node.declaredFragment?.element);
    super.visitEnumDeclaration(node);
  }

  @override
  void visitExtensionTypeDeclaration(ExtensionTypeDeclaration node) {
    rule.logger.fine(
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
    rule.logger.fine('visitMixinDeclaration() for: ${node.name.lexeme}');
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
    rule.logger.fine('_mapKnownArguments() started');
    if (annotation == null) {
      rule.logger.finer('Annotation is null, returning empty');
      return .empty;
    }

    var element = annotation.element;
    rule.logger.finer(
      'Annotation element: ${element?.displayName ?? "null"}, type: '
      '${element.runtimeType}',
    );
    if (element is! ConstructorElement) {
      rule.logger.finer('Element is not ConstructorElement, returning empty');
      return .empty;
    }

    var type = annotation.computeConstantValue();
    rule.logger.finer(
      'Computed constant value: ${type != null ? "success" : "null"}',
    );
    if (type == null) {
      rule.logger.finer('Type is null, returning empty');
      return .empty;
    }
    var prefix = type.getField('prefix')?.toStringValue();
    var suffix = type.getField('suffix')?.toStringValue();
    var containing = type.getField('containing')?.toStringValue();
    var option = type.getField('option');

    rule.logger.fine(
      '_mapKnownArguments() returning annotation: prefix=$prefix, '
      'suffix=$suffix, containing=$containing',
    );
    return _SubtypeNamingAnnotation(
      prefix: prefix,
      suffix: suffix,
      containing: containing,
      option: option,
    );
  }

  void _verifySuperTypes(
    SyntacticEntity name,
    InterfaceElement? element, {
    bool abstract = false,
  }) {
    rule.logger.info('_verifySuperTypes() started');
    if (element == null) {
      rule.logger.finer('Element is null, returning');
      return;
    }
    rule.logger.fine(
      'Verifying supertypes for: ${element.name}, abstract=$abstract',
    );
    var annotations = <_SubtypeNamingAnnotation>[];
    var visitedElements = <InterfaceElement>{element};
    rule.logger.finer('Processing ${element.allSupertypes.length} supertypes');
    for (var interface in element.allSupertypes) {
      var current = interface.element;
      if (!visitedElements.add(current)) {
        rule.logger.finer('Already visited ${current.name}, skipping');
        continue;
      }
      var currentAnnotations = current.metadata.annotations
          .where(_isSubtypeNamingAnnotation)
          .map(_mapKnownArguments)
          .toList();
      rule.logger.finer(
        'Supertype ${current.name} has ${currentAnnotations.length} '
        'SubtypeNaming annotations',
      );
      annotations.addAll(currentAnnotations);
    }

    rule.logger.fine('Total annotations to check: ${annotations.length}');
    for (var annotation in annotations) {
      rule.logger.finer(
        'Checking annotation: prefix=${annotation.prefix}, '
        'suffix=${annotation.suffix}, containing=${annotation.containing}',
      );
      if (annotation.option?.variable?.name == 'onlyConcrete' && abstract) {
        rule.logger.finer('  Skipping due to onlyConcrete with abstract type');
        continue;
      } else if (annotation.option?.variable?.name == 'onlyAbstract' &&
          !abstract) {
        rule.logger.finer('  Skipping due to onlyAbstract with concrete type');
        continue;
      } else if (annotation.option?.variable?.name == 'onlyInstantiable' &&
          (abstract || element is MixinElement)) {
        rule.logger.finer(
          '  Skipping due to onlyInstantiable with non-instantiable type',
        );
        continue;
      }
      var typeName = switch (name) {
        Token() => name.lexeme,
        Identifier() => name.name,
        _ => '',
      };
      rule.logger.finer('  Type name to verify: "$typeName"');
      var violations = <String>[];
      if (annotation.prefix != null &&
          !typeName.startsWith(annotation.prefix!)) {
        rule.logger.fine(
          '  Prefix violation: expected prefix "${annotation.prefix}"',
        );
        violations.add('prefix');
      }
      if (annotation.suffix != null && !typeName.endsWith(annotation.suffix!)) {
        rule.logger.fine(
          '  Suffix violation: expected suffix "${annotation.suffix}"',
        );
        violations.add('suffix');
      }
      if (annotation.containing != null &&
          !typeName.contains(annotation.containing!)) {
        rule.logger.fine(
          '  Containing violation: expected containing '
          '"${annotation.containing}"',
        );
        violations.add('containing');
      }
      if (violations.isNotEmpty) {
        rule.logger.fine(
          'Reporting naming violation for ${violations.join(", ")}',
        );
        switch (name) {
          case Token():
            rule.reportAtToken(
              name,
              diagnosticCode: rule.rule,
            );
          case AstNode():
            rule.reportAtNode(
              name,
              diagnosticCode: rule.rule,
            );
        }
      }
    }
    rule.logger.info('_verifySuperTypes() completed');
  }
}
