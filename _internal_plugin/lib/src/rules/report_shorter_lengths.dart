import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:essential_lints/src/plugin.dart';
import 'package:essential_lints/src/rules/analysis_rule.dart';
import 'package:essential_lints/src/utils/base_visitor.dart';
import 'package:logging/logging.dart';

import 'diagnostic.dart';
import 'rule.dart';

@staticLoggerEnforcement
class ReportShorterLengthsRule extends LintRule<ReportShorterLengthsRule> {
  ReportShorterLengthsRule() : super(_diagnostic, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'ReportShorterLengthsRule',
  );

  @override
  Logger get logger => _logger;

  static const _diagnostic = InternalDiagnosticCode(
    name: 'report_shorter_lengths',
    problemMessage: 'Report shorter lengths to avoid unnecessary overlaps.',
    correctionMessage: 'Chose a more specific node or token.',
    description: 'Report for long nodes.',
  );

  @override
  final InternalDiagnosticCode diagnosticCode = _diagnostic;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _ReportShorterLengthsVisitor(this, context);
    registry.addMethodInvocation(this, visitor);
  }
}

class _ReportShorterLengthsVisitor
    extends BaseVisitor<ReportShorterLengthsRule> {
  _ReportShorterLengthsVisitor(super.rule, super.context);

  static const classes = ['AnalysisRule', 'MultiAnalysisRule'];
  static const method = 'reportAtNode';

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (_isMethodFromEitherClass(node.methodName.element)) {
      var firstArgument = node.argumentList.arguments.firstOrNull;
      if (firstArgument == null) return;
      if (containsMoreEntities(firstArgument) ||
          containsAbstractSubtypes(firstArgument)) {
        // ignore: _internal_plugin/report_shorter_lengths special case
        rule.reportAtNode(firstArgument);
      }
    }
  }

  bool _isMethodFromEitherClass(Element? element) {
    element = element?.baseElement;
    if (element is! MethodElement) return false;
    var enclosingClass = element.enclosingElement;
    if (enclosingClass is! ClassElement) return false;
    return classes.contains(enclosingClass.name) && element.name == method;
  }

  bool containsMoreEntities(Expression firstArgument) {
    var type = firstArgument.staticType;
    if (type == null) return false;
    var element = type.element;
    if (element is! ClassElement) return false;
    return element.getters.any((getter) {
      var type = getter.returnType;
      if (type is InterfaceType &&
          (getter.returnType.isDartCoreList ||
              getter.returnType.isDartCoreIterable ||
              getter.returnType.isDartCoreSet)) {
        type = type.typeArguments.firstOrNull ?? type;
      }
      var element = type.element;
      if (element is! ClassElement) return false;
      bool isAstNode(InterfaceType interface) =>
          interface.element.name == 'AstNode' &&
              interface.element.library.uri ==
                  .parse('package:analyzer/src/dart/ast/ast.dart') ||
          interface.element.allSupertypes.reversed.any(isAstNode);

      return element.allSupertypes.reversed.any(isAstNode);
    });
  }

  bool containsAbstractSubtypes(Expression firstArgument) {
    var type = firstArgument.staticType;
    if (type == null) return true; // We don't know so we assume it does.
    var element = type.element;
    if (element is! ClassElement) {
      return true; // We don't know so we assume it does.
    }
    var subtypes = element.library.classes.where(
      (c) =>
          typeSystem.isSubtypeOf(c.thisType, element.thisType) &&
          c.thisType != element.thisType,
    );
    for (var subtype in subtypes) {
      if (subtype.isAbstract) {
        return true;
      }
    }
    return false;
  }
}
