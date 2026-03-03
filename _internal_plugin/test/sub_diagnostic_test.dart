import 'package:_internal_plugin/src/rules/diagnostic.dart';
import 'package:_internal_plugin/src/rules/sub_diagnostic.dart';
import 'package:_internal_testing/dependencies.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(SubDiagnosticTest);
  });
}

@reflectiveTest
class SubDiagnosticTest extends AnalysisRuleTest
    with AnnotationsDependencyMixin {
  @override
  Future<void> setUp() async {
    rule = SubDiagnosticRule();
    await addAnnotationsDependency();
    await addLintDependency();
    super.setUp();
    newFile(join(testPackageLibPath, 'other.dart'), '''
part of 'test.dart';

class TestRule extends Rule {
  const TestRule._({required super.name, required super.description});
  static const instance = TestRule._(
    name: 'single_rule',
    description: 'A single rule for testing.',
  );
  static const instance2 = TestRule._(
    name: 'single_rule2',
    description: 'A single rule for testing.',
  );
}

class InternalDiagnosticCode extends WarningCode {
  const InternalDiagnosticCode({
    required TestRule super.rule,
    required super.problemMessage,
    super.uniqueName,
    super.severity = .WARNING,
    super.type = .STATIC_WARNING,
    super.correctionMessage,
  });
}

mixin SubDiagnostic
    on d.SubDiagnostic {}

enum BaseLints
    with
        EnumDiagnostic,
        SuperDiagnostic<SubLints> {
  subDiagnostic(
    InternalDiagnosticCode(rule: TestRule.instance, problemMessage: ''),
    SubLints.values,
  );

  const BaseLints(this.code, this.subDiagnostics);

  @override
  final InternalDiagnosticCode code;

  @override
  final List<SubLints> subDiagnostics;
}
''');
  }

  Future<void> test_subDiagnostic() async {
    await assertNoDiagnostics('''
import 'package:essential_lints/src/warnings/essential_lint_warnings.dart'
    as d
    show SubDiagnostic;
import 'package:essential_lints/src/warnings/essential_lint_warnings.dart'
    hide SubDiagnostic;
import 'package:essential_lints/src/warnings/warning.dart';

part 'other.dart';

@staticAllEnforcement
enum SubLints
    with
        EnumDiagnostic,
        d.SubDiagnostic,
        SubDiagnostic {
  subLint(
    InternalDiagnosticCode(
      rule: .instance,
      uniqueName: 'sub_lint',
      problemMessage: '',
    ),
  );

  const SubLints(this.code);

  static const List<EnumDiagnostic> all = [...values, base];

  static const BaseLints base = .subDiagnostic;

  @override
  final InternalDiagnosticCode code;
}
''');
  }

  Future<void> test_baseName() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints/src/warnings/essential_lint_warnings.dart'
    as d
    show SubDiagnostic;
import 'package:essential_lints/src/warnings/essential_lint_warnings.dart'
    hide SubDiagnostic;
import 'package:essential_lints/src/warnings/warning.dart';

part 'other.dart';

@staticAllEnforcement
enum SubLints
    with
        EnumDiagnostic,
        d.SubDiagnostic,
        SubDiagnostic {
  subLint(
    InternalDiagnosticCode(
      rule: .instance2,
      uniqueName: 'sub_lint',
      problemMessage: '',
    ),
  );

  const SubLints(this.code);

  static const List<EnumDiagnostic> all = [...values, base];

  static const BaseLints base = .subDiagnostic;

  @override
  final InternalDiagnosticCode code;
}
''',
      [lint(408, 7)],
    );
  }

  Future<void> test_notUniqueName() async {
    await assertDiagnostics(
      '''
import 'package:essential_lints/src/warnings/essential_lint_warnings.dart'
    as d
    show SubDiagnostic;
import 'package:essential_lints/src/warnings/essential_lint_warnings.dart'
    hide SubDiagnostic;
import 'package:essential_lints/src/warnings/warning.dart';

part 'other.dart';

@staticAllEnforcement
enum SubLints
    with
        EnumDiagnostic,
        d.SubDiagnostic,
        SubDiagnostic {
  subLint(
    InternalDiagnosticCode(
      rule: .instance,
      uniqueName: 'sub_lint',
      problemMessage: '',
    ),
  ),
  other(
    InternalDiagnosticCode(
      rule: .instance,
      uniqueName: 'sub_lint',
      problemMessage: '',
    ),
  );

  const SubLints(this.code);

  static const List<EnumDiagnostic> all = [...values, base];

  static const BaseLints base = .subDiagnostic;

  @override
  final InternalDiagnosticCode code;
}
''',
      [error(InternalMultiLints.nonUniqueName, 538, 5)],
    );
  }

  Future<void> test_uniqueName() async {
    await assertNoDiagnostics('''
import 'package:essential_lints/src/warnings/essential_lint_warnings.dart'
    as d
    show SubDiagnostic;
import 'package:essential_lints/src/warnings/essential_lint_warnings.dart'
    hide SubDiagnostic;
import 'package:essential_lints/src/warnings/warning.dart';

part 'other.dart';

@staticAllEnforcement
enum SubLints
    with
        EnumDiagnostic,
        d.SubDiagnostic,
        SubDiagnostic {
  subLint(
    InternalDiagnosticCode(
      rule: .instance,
      uniqueName: 'sub_lint',
      problemMessage: '',
    ),
  ),
  other(
    InternalDiagnosticCode(
      rule: .instance,
      uniqueName: 'other',
      problemMessage: '',
    ),
  );

  const SubLints(this.code);

  static const List<EnumDiagnostic> all = [...values, base];

  static const BaseLints base = .subDiagnostic;

  @override
  final InternalDiagnosticCode code;
}
''');
  }
}
