import 'package:essential_lints/src/fixes/essential_lint_fixes.dart';
import 'package:essential_lints/src/rules/rule.dart';
import 'package:essential_lints/src/rules/useless_else.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/fix_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(RemoveUselessElseTest);
  });
}

@reflectiveTest
class RemoveUselessElseTest extends LintFixTestProcessor {
  @override
  EssentialLintFixes get fix => .removeUselessElse;

  @override
  LintRule get rule => UselessElseRule();

  Future<void> test_followingStatements() async {
    await resolveTestCode('''
void f(int x) {
  if (x > 0) {
    return;
  } else {
    print('x is not positive');
  }
  print('This is after else');
}
''');
    await assertHasFix('''
void f(int x) {
  if (x > 0) {
    return;
  }
  print('x is not positive');
  print('This is after else');
}
''');
  }

  Future<void> test_return() async {
    await resolveTestCode('''
void f(int x) {
  if (x > 0) {
    return;
  } else {
    print('x is not positive');
  }
}
''');
    await assertHasFix('''
void f(int x) {
  if (x > 0) {
    return;
  }
  print('x is not positive');
}
''');
  }

  Future<void> test_statement() async {
    await resolveTestCode('''
void f(int x) {
  if (x > 0) {
    return;
  } else print('x is not positive');
}
''');
    await assertHasFix('''
void f(int x) {
  if (x > 0) {
    return;
  }
  print('x is not positive');
}
''');
  }

  Future<void> test_switchBody() async {
    await resolveTestCode('''
void f(int x) {
  if (x > 0) {
    return;
  } else {
    switch(x) {
      case -1:
        print('x is -1');
        break;
      default:
        print('x is not positive');
    }
  }
}
''');
    await assertHasFix('''
void f(int x) {
  if (x > 0) {
    return;
  }
  switch(x) {
    case -1:
      print('x is -1');
      break;
    default:
      print('x is not positive');
  }
}
''');
  }

  Future<void> test_throw() async {
    await resolveTestCode('''
void f(int x) {
  if (x > 0) {
    throw Exception('x is positive');
  } else {
    print('x is not positive');
  }
}
''');
    await assertHasFix('''
void f(int x) {
  if (x > 0) {
    throw Exception('x is positive');
  }
  print('x is not positive');
}
''');
  }

  Future<void> test_useless_switch() async {
    await resolveTestCode('''
void f(int x) {
  if (x > 0) {
    switch(x) {
      default:
        return;
    }
  } else {
    print('x is not positive');
  }
}
''');
    await assertHasFix('''
void f(int x) {
  if (x > 0) {
    switch(x) {
      default:
        return;
    }
  }
  print('x is not positive');
}
''');
  }
}
