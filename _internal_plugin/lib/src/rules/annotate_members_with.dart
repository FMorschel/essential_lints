import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart';
import 'package:essential_lints/src/utils/dart_object_to_string.dart';

import 'diagnostic.dart';

class AnnotateMembersWithRule extends AnalysisRule {
  AnnotateMembersWithRule()
    : super(
        name: _diagnostic.name,
        description:
            'Members that should be annotated with specific annotations.',
      );

  static const _diagnostic = InternalDiagnosticCode(
    name: 'annotate_members_with',
    problemMessage: "This member should be annotated with '{0}'.",
    correctionMessage: 'Add the required annotation.',
    severity: .ERROR,
  );

  @override
  final DiagnosticCode diagnosticCode = _diagnostic;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _AnnotateMembersWithVisitor(this, context);
    registry
      ..addMethodDeclaration(this, visitor)
      ..addFieldDeclaration(this, visitor)
      ..addConstructorDeclaration(this, visitor);
  }
}

class _AnnotateMembersWithVisitor extends GeneralizingAstVisitor<void> {
  _AnnotateMembersWithVisitor(this.rule, this.context);

  final AnnotateMembersWithRule rule;
  final RuleContext context;

  @override
  void visitClassMember(ClassMember node) {
    _checkAnnotations(node);
  }

  void _checkAnnotations(ClassMember node) {
    var elements = _getElements(node);
    var metadata = node.enclosingAnnotatedNode.sortedCommentAndAnnotations;
    var annotations = metadata.whereType<Annotation>().map(
      (a) => a.elementAnnotation,
    );
    var finalAnnotations = <_AnnotateMembersWith>[];
    for (var elementAnnotation in annotations) {
      if (elementAnnotation?.computeConstantValue()
          case DartObject(:var type) && var annotation) {
        if (type?.element?.name == 'AnnotateMembersWith' &&
            type?.element?.library?.uri ==
                .parse(
                  'package:essential_lints_annotations/src/_internal/'
                  'annotate_members_with.dart',
                )) {
          var requiredAnnotation = annotation.getField('annotation');
          var onlyConcrete =
              annotation.getField('onlyConcrete')?.toBoolValue() ?? false;
          var onlyPublic =
              annotation.getField('onlyPublic')?.toBoolValue() ?? false;
          finalAnnotations.add(
            _AnnotateMembersWith(
              annotation: requiredAnnotation,
              onlyConcrete: onlyConcrete,
              onlyPublic: onlyPublic,
            ),
          );
        }
      }
    }
    for (var annotation in finalAnnotations) {
      var annotationObject = annotation.annotation;
      if (annotationObject == null) {
        continue;
      }

      bool validElementAnnotation(ElementAnnotation elementAnnotation) {
        var object = elementAnnotation.computeConstantValue();
        var type = object?.type;
        var annotationType = annotationObject.type;
        var annotationAsType = annotationObject.toTypeValue();
        if (annotationType != null &&
            annotationType.isDartCoreType &&
            type != null &&
            annotationAsType != null) {
          if (context.typeSystem.isAssignableTo(type, annotationAsType)) {
            // Valid annotation type.
            return true;
          }
        }
        return annotationObject == object;
      }

      for (var element in elements) {
        if (annotation.onlyConcrete &&
            ((element is ExecutableElement && element.isAbstract) ||
                (element is FieldElement && element.isAbstract))) {
          continue;
        }
        if (annotation.onlyPublic && element.isPrivate) {
          continue;
        }
        var hasRequiredAnnotation = element.metadata.annotations.any(
          validElementAnnotation,
        );
        if (!hasRequiredAnnotation) {
          var requiredAnnotationString = dartObjectToString(
            annotation.annotation,
          );
          if (node.name case var name?) {
            rule.reportAtToken(
              name,
              arguments: [requiredAnnotationString],
            );
          } else if (node case ConstructorDeclaration(:var returnType)) {
            rule.reportAtNode(
              returnType,
              arguments: [requiredAnnotationString],
            );
          } else {
            rule.reportAtNode(
              node,
              arguments: [requiredAnnotationString],
            );
          }
        }
      }
    }
  }

  List<Element> _getElements(ClassMember node) {
    if (node case FieldDeclaration(:var fields)) {
      return fields.variables
          .map((v) => v.declaredFragment?.element)
          .nonNulls
          .toList();
    }
    return [?node.declaredFragment?.element];
  }
}

extension on ClassMember {
  AnnotatedNode get enclosingAnnotatedNode {
    var parent = this.parent;
    while (parent != null) {
      if (parent is AnnotatedNode) {
        return parent;
      }
      parent = parent.parent;
    }
    throw StateError('No enclosing AnnotatedNode found.');
  }

  Token? get name {
    return switch (this) {
      MethodDeclaration(:var name) => name,
      FieldDeclaration(:var fields) => fields.variables.first.name,
      ConstructorDeclaration(:var name) => name,
    };
  }
}

class _AnnotateMembersWith {
  _AnnotateMembersWith({
    required this.annotation,
    required this.onlyConcrete,
    required this.onlyPublic,
  });

  final DartObject? annotation;
  final bool onlyConcrete;
  final bool onlyPublic;
}
