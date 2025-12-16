import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart';

import 'diagnostic.dart';

mixin ConsiderMixin on MultiAnalysisRule {
  static const _multipleConsider = InternalDiagnosticCode(
    name: 'multiple_consider',
    problemMessage: 'Multiple @Consider annotations found.',
    correctionMessage: 'Remove the extra @Consider annotations.',
    severity: .ERROR,
  );

  final DiagnosticCode multipleConsider = _multipleConsider;

  bool isConsider(ElementAnnotation? element) {
    if (element?.computeConstantValue() case DartObject(:var type)) {
      return type?.element?.name == 'Consider' &&
          type?.element?.library?.uri ==
              .parse(
                'package:essential_lints_annotations/src/_internal/'
                'consider.dart',
              );
    }
    return false;
  }

  DartType? parseType(ElementAnnotation? consider) {
    if (consider?.computeConstantValue() case DartObject(:var type)) {
      if (type is InterfaceType && type.typeArguments.length == 1) {
        return type.typeArguments.first;
      }
    }
    return null;
  }
}

class ConsiderAnnotationVisitor extends SimpleAstVisitor<void> {
  ConsiderAnnotationVisitor(this.rule, this.context);

  final ConsiderMixin rule;
  final RuleContext context;

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    _handleAnnotations(node);
  }

  void _handleAnnotations(AnnotatedNode node) {
    var metadata = node.sortedCommentAndAnnotations;
    var annotations = metadata.whereType<Annotation>().map(
      (a) => (a, a.elementAnnotation),
    );
    var considerAnnotations = annotations.where((r) => rule.isConsider(r.$2));
    if (considerAnnotations.length > 1) {
      for (final (annotation, _) in considerAnnotations.skip(1)) {
        rule.reportAtNode(
          annotation,
          diagnosticCode: rule.multipleConsider,
        );
      }
    }
  }

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    _handleAnnotations(node);
  }
}
