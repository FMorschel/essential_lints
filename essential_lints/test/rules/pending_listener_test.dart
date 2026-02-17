import 'package:_internal_testing/flutter_dependency_mixin.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
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

  Future<void> test_added_part() async {
    var mainPath = join(testPackageLibPath, 'main.dart');
    newFile(mainPath, '''
import 'package:flutter/foundation.dart';

part 'test.dart';
''');
    newFile(testFile.path, '''
part of 'main.dart';

class C {
  C(this.listenable);
  final Listenable listenable;

  void a() {
    listenable.addListener(a);
  }
}
''');
    await assertDiagnosticsInFile(testFile.path, [lint(126, 1)]);
    await assertNoDiagnosticsInFile(mainPath);
  }

  Future<void> test_disposed() async {
    await assertNoDiagnostics('''
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

  Future<void> test_disposed_cascade() async {
    await assertNoDiagnostics('''
import 'package:flutter/foundation.dart';

class C {
  C(this.listenable);
  final ChangeNotifier listenable;

  void a() {
    listenable.addListener(a);
    listenable..dispose();
  }
}
''');
  }

  Future<void> test_removed_twice() async {
    await assertNoDiagnostics('''
import 'package:flutter/foundation.dart';

class C {
  C(this.listenable);
  final ChangeNotifier listenable;

  void a() {
    listenable.addListener(a);
    listenable.removeListener(a);
    listenable.removeListener(a);
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
    await assertNoDiagnostics('''
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

  Future<void> test_dispose_prevents_pending_listener_warning() async {
    await assertNoDiagnostics('''
import 'package:flutter/foundation.dart';

class C {
  C(this.listenable);
  final ChangeNotifier listenable;

  void a() {
    listenable.addListener(a);
    // No removeListener, but dispose cleans up
    listenable.dispose();
  }
}
''');
  }

  Future<void> test_remove_then_dispose_no_unnecessary_warning() async {
    await assertNoDiagnostics('''
import 'package:flutter/foundation.dart';

class C {
  C(this.listenable);
  final ChangeNotifier listenable;

  void a() {
    listenable.addListener(a);
    listenable.removeListener(a);
    listenable.dispose();
  }
}
''');
  }

  Future<void> test_dispose_does_not_justify_unnecessary_remove() async {
    await assertDiagnostics(
      '''
import 'package:flutter/foundation.dart';

class C {
  C(this.listenable);
  final ChangeNotifier listenable;

  void a() {
    // No addListener, so removeListener is unnecessary
    listenable.removeListener(a);
    listenable.dispose();
  }
}
''',
      [error(PendingListener.unnecessaryRemove, 210, 1)],
    );
  }

  Future<void> test_multiple_listeners_with_dispose() async {
    await assertDiagnostics(
      '''
import 'package:flutter/foundation.dart';

class C {
  C(this.listenable);
  final ChangeNotifier listenable;

  void a() {}
  void b() {}

  void setup() {
    listenable.addListener(a);
    listenable.addListener(b);
    listenable.removeListener(a);
    // b is not removed, but dispose cleans up
    listenable.dispose();
  }
}
''',
      [],
    );
  }

  Future<void> test_property_access_matched() async {
    await assertNoDiagnostics('''
import 'package:flutter/foundation.dart';

class Widget {
  final Listenable controller = ChangeNotifier();
}

class C {
  C(this.widget);
  final Widget widget;

  void listener() {}

  void setup() {
    widget.controller.addListener(listener);
    widget.controller.removeListener(listener);
  }
}
''');
  }

  Future<void> test_property_access_unmatched() async {
    await assertDiagnostics(
      '''
import 'package:flutter/foundation.dart';

class Widget {
  final Listenable controller1 = ChangeNotifier();
  final Listenable controller2 = ChangeNotifier();
}

class C {
  C(this.widget);
  final Widget widget;

  void listener() {}

  void setup() {
    widget.controller1.addListener(listener);
    widget.controller2.removeListener(listener);
  }
}
''',
      [
        lint(289, 8),
        error(PendingListener.unnecessaryRemove, 338, 8),
      ],
    );
  }

  Future<void> test_nested_property_access_matched() async {
    await assertNoDiagnostics('''
import 'package:flutter/foundation.dart';

class Controller {
  final Listenable notifier = ChangeNotifier();
}

class Widget {
  final Controller controller = Controller();
}

class C {
  C(this.widget);
  final Widget widget;

  void listener() {}

  void setup() {
    widget.controller.notifier.addListener(listener);
    widget.controller.notifier.removeListener(listener);
  }
}
''');
  }

  Future<void> test_nested_property_access_unmatched() async {
    await assertDiagnostics(
      '''
import 'package:flutter/foundation.dart';

class Controller {
  final Listenable notifier1 = ChangeNotifier();
  final Listenable notifier2 = ChangeNotifier();
}

class Widget {
  final Controller controller = Controller();
}

class C {
  C(this.widget);
  final Widget widget;

  void listener() {}

  void setup() {
    widget.controller.notifier1.addListener(listener);
    widget.controller.notifier2.removeListener(listener);
  }
}
''',
      [
        lint(362, 8),
        error(PendingListener.unnecessaryRemove, 420, 8),
      ],
    );
  }

  Future<void> test_this_property_access_matched() async {
    await assertNoDiagnostics('''
import 'package:flutter/foundation.dart';

class C {
  C(this.listenable);
  final Listenable listenable;

  void listener() {}

  void setup() {
    this.listenable.addListener(listener);
    this.listenable.removeListener(listener);
  }
}
''');
  }

  Future<void> test_mixed_property_access_forms() async {
    await assertNoDiagnostics('''
import 'package:flutter/foundation.dart';

class C {
  C(this.listenable);
  final Listenable listenable;

  void listener() {}

  void setup() {
    listenable.addListener(listener);
    this.listenable.removeListener(listener);
  }
}
''');
  }

  Future<void> test_same_name_differentElements() async {
    await assertDiagnostics(
      '''
import 'package:flutter/foundation.dart';

class C {
  C(this.listenable);
  final Listenable listenable;

  void listener() {}

  void setup() {
    listenable.addListener(listener);
    {
      void listener() {}
      listenable.removeListener(listener);
    }
  }
}
''',
      [
        lint(173, 8),
        error(PendingListener.unnecessaryRemove, 247, 8),
      ],
    );
  }

  Future<void> test_added_closure_with_dispose() async {
    await assertNoDiagnostics('''
import 'package:flutter/foundation.dart';

class C {
  C(this.listenable);
  final ChangeNotifier listenable;

  void a() {
    listenable.addListener(() {});
    listenable.dispose();
  }
}
''');
  }

  Future<void> test_removed_closure_always_warns() async {
    await assertDiagnostics(
      '''
import 'package:flutter/foundation.dart';

class C {
  C(this.listenable);
  final ChangeNotifier listenable;

  void a() {
    listenable.removeListener(() {});
    listenable.dispose();
  }
}
''',
      [error(PendingListener.closuresCannotBeMatched, 154, 3)],
    );
  }

  Future<void> test_multiple_closures_with_dispose() async {
    await assertNoDiagnostics('''
import 'package:flutter/foundation.dart';

class C {
  C(this.listenable);
  final ChangeNotifier listenable;

  void setup() {
    listenable.addListener(() {});
    listenable.addListener(() {});
    listenable.dispose();
  }
}
''');
  }

  Future<void> test_closure_without_dispose_still_warns() async {
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
}
