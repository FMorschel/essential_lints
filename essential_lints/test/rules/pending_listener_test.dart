import 'package:_internal_testing/flutter_dependency_mixin.dart';
import 'package:analyzer/utilities/package_config_file_builder.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:analyzer_testing/utilities/utilities.dart';
import 'package:essential_lints/src/rules/essential_lint_rules.dart';
import 'package:essential_lints/src/rules/pending_listener.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(PendingListenerTest);
  });
}

@reflectiveTest
class PendingListenerTest extends MultiLintTestProcessor<PendingListener>
    with FlutterDependencyMixin {
  @override
  MultiLintRule<PendingListener> get rule => PendingListenerRule();

  @override
  void setUp() {
    super.setUp();
    createFlutterMock();
    newPackageConfigJsonFileFromBuilder(
      testPackageRootPath,
      PackageConfigFileBuilder()..add(
        name: 'flutter',
        rootPath: flutterFolder.path,
      ),
    );
    pubspecYamlContent(
      dependencies: ['flutter'],
    );
  }

  Future<void> test_added_cascade() async {
    await assertDiagnostics(
      '''
import 'package:flutter/foundation.dart';

class C {
  C(this.listenable);
  final Listenable listenable;

  void a() {
    listenable..addListener(a);
  }
}
''',
      [lint(148, 1)],
    );
  }

  Future<void> test_added() async {
    await assertDiagnostics(
      '''
import 'package:flutter/foundation.dart';

class C {
  C(this.listenable);
  final Listenable listenable;

  void a() {
    listenable.addListener(a);
  }
}
''',
      [lint(147, 1)],
    );
  }

  Future<void> test_disposed() async {
    await assertNoDiagnostics(
      '''
import 'package:flutter/foundation.dart';

class C {
  C(this.listenable);
  final ChangeNotifier listenable;

  void a() {
    listenable.addListener(a);
    listenable.dispose();
  }
}
''');
  }

  Future<void> test_added_closure() async {
    await assertDiagnostics(
      '''
import 'package:flutter/foundation.dart';

class C {
  C(this.listenable);
  final Listenable listenable;

  void a() {
    listenable.addListener(() {});
  }
}
''',
      [error(PendingListener.closuresCannotBeMatched, 147, 3)],
    );
  }

  Future<void> test_added_removed() async {
    await assertNoDiagnostics('''
import 'package:flutter/foundation.dart';

class C {
  C(this.listenable);
  final Listenable listenable;

  void a() {
    listenable.addListener(a);
    listenable.removeListener(a);
  }
}
''');
  }

  Future<void> test_different_targets() async {
    await assertDiagnostics(
      '''
import 'package:flutter/foundation.dart';

class C {
  C(this.listenable1, this.listenable2);
  final Listenable listenable1;
  final Listenable listenable2;

  void a() {
    listenable1.addListener(a);
    listenable2.removeListener(a);
  }
}
''',
      [
        lint(200, 1),
        error(PendingListener.unnecessaryRemove, 235, 1),
      ],
    );
  }

  Future<void> test_different_targets_OK() async {
    await assertNoDiagnostics(
      '''
import 'package:flutter/foundation.dart';

class C {
  C(this.listenable1, this.listenable2);
  final Listenable listenable1;
  final Listenable listenable2;

  void a() {
    listenable1.addListener(a);
    listenable2.addListener(a);
    listenable1.removeListener(a);
    listenable2.removeListener(a);
  }
}
''');
  }

  Future<void> test_removed() async {
    await assertDiagnostics(
      '''
import 'package:flutter/foundation.dart';

class C {
  C(this.listenable);
  final Listenable listenable;

  void a() {
    listenable.removeListener(a);
  }
}
''',
      [error(PendingListener.unnecessaryRemove, 150, 1)],
    );
  }

  Future<void> test_removed_closure() async {
    await assertDiagnostics(
      '''
import 'package:flutter/foundation.dart';

class C {
  C(this.listenable);
  final Listenable listenable;

  void a() {
    listenable.removeListener(() {});
  }
}
''',
      [error(PendingListener.closuresCannotBeMatched, 150, 3)],
    );
  }
}
