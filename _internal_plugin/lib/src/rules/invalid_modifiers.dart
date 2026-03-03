import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:essential_lints/src/plugin.dart';
import 'package:essential_lints/src/rules/analysis_rule.dart';
import 'package:essential_lints/src/utils/base_visitor.dart';
import 'package:logging/logging.dart';

import 'diagnostic.dart';
import 'invalid_base_visitor.dart';
import 'rule.dart';

@staticLoggerEnforcement
class InvalidModifiersRule extends LintRule<InvalidModifiersRule> {
  InvalidModifiersRule() : super(_diagnostic, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'InvalidModifiersRule',
  );

  @override
  Logger get logger => _logger;

  static const _diagnostic = InternalDiagnosticCode(
    rule: .invalidModifiers,
    problemMessage: 'This modifier is invalid for {0}.',
    correctionMessage: 'Remove the invalid modifier.',
    severity: .ERROR,
  );

  @override
  final InternalDiagnosticCode diagnosticCode = _diagnostic;

  @override
  Visitor<InvalidModifiersRule, void> visitorFor(RuleContext context) =>
      _InvalidModifiersVisitor(this, context);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = visitorFor(context);
    registry
      ..addDotShorthandPropertyAccess(this, visitor)
      ..addDotShorthandConstructorInvocation(this, visitor);
  }
}

class _InvalidModifiersVisitor
    extends InvalidBaseVisitor<InvalidModifiersRule> {
  _InvalidModifiersVisitor(super.rule, super.context);

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
  void reportError(SimpleIdentifier node, String? name) {
    rule.reportAtNode(node, arguments: [name ?? '']);
  }
}
