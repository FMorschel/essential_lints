import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/src/dart/ast/ast.dart';
import 'package:collection/collection.dart';
import 'package:essential_lints/src/plugin.dart';
import 'package:essential_lints/src/rules/analysis_rule.dart';
import 'package:essential_lints/src/utils/base_visitor.dart';
import 'package:essential_lints/src/utils/diagnostic_message.dart';
import 'package:logging/logging.dart';

import 'diagnostic.dart';
import 'rule.dart';

@staticLoggerEnforcement
class SubDiagnosticRule
    extends MultiLintRule<SubDiagnosticRule, InternalMultiLints> {
  SubDiagnosticRule() : super(InternalMultiLints.base, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'SubDiagnosticRule',
  );

  @override
  Visitor<SubDiagnosticRule, void> visitorFor(RuleContext context) =>
      _SubDiagnosticVisitor(this, context);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = visitorFor(context);
    registry
      ..addEnumConstantDeclaration(this, visitor)
      ..addEnumDeclaration(this, visitor);
  }
}

class _SubDiagnosticVisitor extends BaseVisitor<SubDiagnosticRule> {
  _SubDiagnosticVisitor(super.rule, super.context);

  static final Uri _uri = .parse(
    'package:essential_lints/src/warnings/essential_lint_warnings.dart',
  );

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    var element = node.declaredFragment?.element;
    if (element == null) return;
    if (element.allSupertypes.none(_isSubDiagnostic)) {
      return;
    }
    var uniqueNames = <String, List<Token>>{};
    for (var constant in node.body.constants) {
      var element = constant.declaredFragment?.element;
      if (element == null) continue;
      var constantValue = element.computeConstantValue().getFieldOrSelf('code');
      if (constantValue == null) continue;
      var name = constantValue.thisOrRuleField('_uniqueName')?.toStringValue();
      if (name == null) continue;
      if (uniqueNames.containsKey(name)) {
        var list = (uniqueNames[name] ?? [])..add(constant.name);
        rule.reportAtToken(
          constant.name,
          diagnosticCode: InternalMultiLints.nonUniqueName,
          contextMessages: [
            for (var token in list)
              DiagnosticMessageImpl(
                message: 'The name is also used here.',
                filePath: context.definingUnit.file.path,
                offset: token.offset,
                length: token.length,
                url: null,
              ),
          ],
        );
      } else {
        uniqueNames[name] = [constant.name];
      }
    }
  }

  @override
  void visitEnumConstantDeclaration(EnumConstantDeclaration node) {
    var element = node.declaredFragment?.element;
    if (element == null) return;
    var enclosingEnum = element.enclosingElement;
    if (enclosingEnum is! InterfaceElement) return;
    if (enclosingEnum.allSupertypes.none(_isSubDiagnostic)) {
      return;
    }
    var baseField = enclosingEnum.fields.firstWhereOrNull(_base);
    if (baseField == null) {
      rule.logger.warning(
        'SubDiagnostic enum ${enclosingEnum.name} must have a base field.',
      );
      return;
    }
    var base = baseField
        .computeConstantValue()
        .getFieldOrSelf('code')
        .thisOrRuleField('name');
    if (base == null) {
      rule.logger.warning(
        'Could not compute constant values for ${enclosingEnum.name}.'
        '${element.name}.',
      );
      return;
    }
    var constant = element
        .computeConstantValue()
        .getFieldOrSelf('code')
        .thisOrRuleField('name')
        ?.toStringValue();
    if (base.toStringValue() case var name when name != constant) {
      rule.reportAtToken(
        node.name,
        diagnosticCode: InternalMultiLints.base,
        arguments: [name ?? '<null>'],
      );
    }
  }

  bool _isSubDiagnostic(InterfaceType type) {
    return type.element.name == 'SubDiagnostic' &&
        type.element.library.uri == _uri;
  }

  bool _base(FieldElement element) => element.name == 'base';
}

extension on DartObject? {
  DartObject? thisOrSuperField(String field) {
    var current = this;
    while (current != null) {
      var fieldValue = current.getField(field);
      if (fieldValue != null) return fieldValue;
      current = current.getField('(super)');
    }
    return null;
  }

  DartObject? thisOrRuleField(String field) {
    var current = this;
    while (current != null) {
      var fieldValue = current.thisOrSuperField(field);
      if (fieldValue != null) return fieldValue;
      current = current.thisOrSuperField('rule');
    }
    return null;
  }

  DartObject? getFieldOrSelf(String field) {
    return this?.getField(field) ?? this;
  }
}
