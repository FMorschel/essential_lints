import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart';
import 'package:logging/logging.dart';

import 'diagnostic.dart';
import 'invalid_base_visitor.dart';

final _log = Logger('InvalidModifiersRule');

class InvalidModifiersRule extends AnalysisRule {
  InvalidModifiersRule()
    : super(
        name: _diagnostic.name,
        description: 'Modifiers that are invalid for a given modifier.',
      );

  static const _diagnostic = InternalDiagnosticCode(
    name: 'invalid_modifiers',
    problemMessage: 'This modifier is invalid for {0}.',
    correctionMessage: 'Remove the invalid modifier.',
    severity: .ERROR,
  );

  @override
  final DiagnosticCode diagnosticCode = _diagnostic;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _InvalidModifiersVisitor(this, context);
    registry
      ..addDotShorthandPropertyAccess(this, visitor)
      ..addDotShorthandConstructorInvocation(this, visitor);
  }
}

class _InvalidModifiersVisitor extends InvalidBaseVisitor {
  _InvalidModifiersVisitor(InvalidModifiersRule rule, RuleContext context)
    : super(context, rule, _log);

  @override
  String get annotationName => 'InvalidModifiers';

  @override
  Uri get annotationLibraryUri => .parse(
    'package:essential_lints_annotations/src/_internal/'
    'invalid_modifiers.dart',
  );

  @override
  String get invalidFieldName => 'invalidModifiers';

  @override
  String get trackingTypeName => 'Modifier';

  @override
  Uri get trackingTypeLibraryUri => .parse(
    'package:essential_lints_annotations/src/sorting_members/'
    'sort_declarations.dart',
  );

  @override
  void reportError(AstNode node, String? name) {
    rule.reportAtNode(
      node,
      arguments: [name ?? ''],
    );
  }
}
