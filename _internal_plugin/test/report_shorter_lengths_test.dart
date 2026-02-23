import 'package:_internal_plugin/src/rules/report_shorter_lengths.dart';
import 'package:_internal_testing/analyzer_dependency.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(ReportShorterLengthsTest);
  });
}

@reflectiveTest
class ReportShorterLengthsTest extends AnalysisRuleTest
    with AnalyzerDependencyMixin {
  @override
  Future<void> setUp() async {
    rule = ReportShorterLengthsRule();
    await addAnalyzerDependency();
    super.setUp();
  }

  Future<void> test_base() async {
    await assertDiagnostics(
      '''
import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

abstract class C implements AnalysisRule {
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _V(this);
  }
}

class _V extends SimpleAstVisitor<void> {
  _V(this.rule);

  final C rule;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    rule.reportAtNode(node);
  }
}
''',
      [lint(621, 4)],
    );
  }

  Future<void> test_generalizing() async {
    await assertDiagnostics(
      '''
import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

abstract class C implements AnalysisRule {
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _V(this);
  }
}

class _V extends GeneralizingAstVisitor<void> {
  _V(this.rule);

  final C rule;

  @override
  void visitCombinator(Combinator node) {
    rule.reportAtNode(node);
  }
}
''',
      [lint(615, 4)],
    );
  }

  Future<void> test_consider_nested() async {
    await assertNoDiagnostics('''
import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

abstract class R implements AnalysisRule {
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _V(this);
  }
}

class _V extends SimpleAstVisitor<void> {
  _V(this.rule);

  final R rule;

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    rule.reportAtNode(node);
  }
}
''');
  }

  Future<void> test_nullable() async {
    await assertNoDiagnostics('''
import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';

abstract class R implements AnalysisRule {
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    SimpleIdentifier? node;
    reportAtNode(node);
  }
}
''');
  }

  Future<void> test_multi() async {
    await assertDiagnostics(
      '''
import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

abstract class C implements MultiAnalysisRule {
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _V(this);
  }
}

class _V extends SimpleAstVisitor<void> {
  _V(this.rule);

  final C rule;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    rule.reportAtNode(node, diagnosticCode: rule.diagnosticCodes.first);
  }
}
''',
      [lint(626, 4)],
    );
  }
}
