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

class InternalDiagnosticCode extends WarningCode<TestRule> {
  const InternalDiagnosticCode({
    required super.rule,
    required super.problemMessage,
    super.uniqueName,
    super.severity = .WARNING,
    super.type = .STATIC_WARNING,
    super.correctionMessage,
  });
}

mixin SubDiagnostic<T extends WarningCode<R>, R extends TestRule>
    on d.SubDiagnostic<T, R> {}

enum BaseLints
    with
        EnumDiagnostic<InternalDiagnosticCode, TestRule>,
        SuperDiagnostic<SubLints, InternalDiagnosticCode, TestRule> {
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
