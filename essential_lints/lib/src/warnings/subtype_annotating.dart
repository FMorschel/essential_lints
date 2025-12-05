import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';

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
      abstract: node.abstractKeyword != null,
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
    var onlyConcrete = type.getField('onlyConcrete')?.toBoolValue() ?? false;

    return _SubtypeNamingAnnotation(
      annotations: annotations,
      onlyConcrete: onlyConcrete,
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

    String dartObjectToString(DartObject? dartObject) {
      if (dartObject == null || dartObject.isNull) {
        return 'null';
      } else if (dartObject.toTypeValue() case var type?) {
        return type.getDisplayString();
      } else if (dartObject.constructorInvocation case var constructor?) {
        return "'${constructor.constructor.displayName}("
            '${constructor.positionalArguments // formatting trick
            .map(dartObjectToString).join(', ')}'
            '${constructor.positionalArguments.isNotEmpty && // formatting trick
                    constructor.namedArguments.isNotEmpty ? ', ' : ''}'
            '${constructor.namedArguments.entries // formatting trick
            .map((entry) => '${entry.key}: ${dartObjectToString(entry.value)}')
            // formatting trick
            .join(', ')}'
            ")'";
      } else if (dartObject.toDoubleValue() case var doubleValue?) {
        return '$doubleValue';
      } else if (dartObject.toIntValue() case var intValue?) {
        return '$intValue';
      } else if (dartObject.toStringValue() case var stringValue?) {
        return "'$stringValue'";
      } else if (dartObject.toBoolValue() case var boolValue?) {
        return '$boolValue';
      } else if (dartObject.variable case var variable?) {
        return variable.displayName;
      } else if (dartObject.toListValue() case var listValue?) {
        return '[${listValue.map(dartObjectToString).commaSeparated}]';
      } else if (dartObject.toSymbolValue() case var symbol?) {
        return symbol;
      } else if (dartObject.toMapValue() case var mapValue?) {
        var entries = mapValue.entries
            .map(
              (entry) =>
                  '${dartObjectToString(entry.key)}: '
                  '${dartObjectToString(entry.value)}',
            )
            .commaSeparated;
        return '{$entries}';
      } else if (dartObject.toSetValue() case var setValue?) {
        return '{${setValue.map(dartObjectToString).commaSeparated}}';
      } else if (dartObject.toRecordValue() case var recordValue?) {
        var positional = recordValue.positional
            .map(dartObjectToString)
            .commaSeparated;
        var named = recordValue.named.entries
            .map((entry) => '${entry.key}: ${dartObjectToString(entry.value)}')
            .commaSeparated;
        return '(${[
          if (positional.isNotEmpty) positional,
          if (named.isNotEmpty) named,
        ].commaSeparated})';
      }
      return dartObject.toString();
    }

    for (final annotation in annotations) {
      if (annotation.onlyConcrete && abstract) {
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
    required this.onlyConcrete,
  });

  static _SubtypeNamingAnnotation empty = const .new(
    annotations: [],
    onlyConcrete: false,
  );

  final List<DartObject> annotations;
  final bool onlyConcrete;
}
