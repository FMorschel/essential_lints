import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:essential_lints/src/plugin.dart';
import 'package:essential_lints/src/rules/analysis_rule.dart';
import 'package:logging/logging.dart';

import 'diagnostic.dart';
import 'invalid_base_visitor.dart';
import 'rule.dart';

@staticLoggerEnforcement
class InvalidMembersRule extends LintRule<InvalidMembersRule> {
  InvalidMembersRule() : super(_diagnostic, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'InvalidMembersRule',
  );

  @override
  Logger get logger => _logger;

  static const _diagnostic = InternalDiagnosticCode(
    rule: .invalidMembers,
    problemMessage: 'This member is invalid {0}.',
    correctionMessage: 'Remove the invalid member.',
    severity: .ERROR,
  );

  @override
  final InternalDiagnosticCode diagnosticCode = _diagnostic;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _InvalidMembersVisitor(this, context);
    registry
      ..addDotShorthandPropertyAccess(this, visitor)
      ..addDotShorthandConstructorInvocation(this, visitor);
  }
}

class _InvalidMembersVisitor extends InvalidBaseVisitor<InvalidMembersRule> {
  _InvalidMembersVisitor(super.rule, super.context);

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
  void reportError(SimpleIdentifier node, String? name) {
    rule.reportAtNode(node, arguments: ['for $name']);
  }
}
