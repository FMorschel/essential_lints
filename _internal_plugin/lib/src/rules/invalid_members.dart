import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart';
import 'package:logging/logging.dart';

import 'diagnostic.dart';
import 'invalid_base_visitor.dart';

final _log = Logger('InvalidMembersRule');

class InvalidMembersRule extends AnalysisRule {
  InvalidMembersRule()
    : super(
        name: _diagnostic.name,
        description: 'Members that are invalid for a given modifier.',
      );

  static const _diagnostic = InternalDiagnosticCode(
    name: 'invalid_members',
    problemMessage: 'This member is invalid {0}.',
    correctionMessage: 'Remove the invalid member.',
    severity: .ERROR,
  );

  @override
  final DiagnosticCode diagnosticCode = _diagnostic;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _InvalidMembersVisitor(this, context);
    registry
      ..addDotShorthandPropertyAccess(this, visitor)
      ..addDotShorthandConstructorInvocation(this, visitor);
  }
}

class _InvalidMembersVisitor extends InvalidBaseVisitor {
  _InvalidMembersVisitor(InvalidMembersRule rule, RuleContext context)
    : super(context, rule, _log);

  @override
  String get annotationName => 'InvalidMembers';

  @override
  Uri get annotationLibraryUri => .parse(
    'package:essential_lints_annotations/src/_internal/invalid_members.dart',
  );

  @override
  String get invalidFieldName => 'invalidMembers';

  @override
  String get trackingTypeName => 'Group';

  @override
  Uri get trackingTypeLibraryUri => .parse(
    'package:essential_lints_annotations/src/sorting_members/'
    'sort_declarations.dart',
  );

  @override
  void reportError(AstNode node, String? name) {
    rule.reportAtNode(
      node,
      arguments: ['for $name'],
    );
  }
}
