import 'package:analysis_server_plugin/plugin.dart';
import 'package:essential_lints/main.dart';
import 'package:essential_lints/src/assist/essential_lint_assists.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/assist_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(RemoveUselessElseTest);
  });
}

@reflectiveTest
class RemoveUselessElseTest extends AssistTestProcessor {
  @override
  EssentialLintAssists get assistKind => .removeUselessElse;

  @override
  List<Plugin> get plugins => [plugin];

  Future<void> test_return() async {
    await resolveTestCode('''
void f(int x) {
  if (x > 0) {
    return;
  } els^e {
    print('x is not positive');
  }
}
''');
    await assertHasAssist('''
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
  } els^e {
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
    await assertHasAssist('''
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

  Future<void> test_followingStatements() async {
    await resolveTestCode('''
void f(int x) {
  if (x > 0) {
    return;
  } els^e {
    print('x is not positive');
  }
  print('This is after else');
}
''');
    await assertHasAssist('''
void f(int x) {
  if (x > 0) {
    return;
  }
  print('x is not positive');
  print('This is after else');
}
''');
  }

  Future<void> test_on_if() async {
    await resolveTestCode('''
void f(int x) {
  if^ (x > 0) {
    return;
  } else {
    print('x is not positive');
  }
}
''');
    await assertNoAssist();
  }

  Future<void> test_throw() async {
    await resolveTestCode('''
void f(int x) {
  if (x > 0) {
    throw Exception('x is positive');
  } el^se {
    print('x is not positive');
  }
}
''');
    await assertHasAssist('''
void f(int x) {
  if (x > 0) {
    throw Exception('x is positive');
  }
  print('x is not positive');
}
''');
  }

  Future<void> test_notUseless_nested() async {
    await resolveTestCode('''
void f(int x) {
  if (x > 0) {
    if (1 == 1) {
      throw Exception('x is positive');
    } else {
      print('never reached');
    }
  } el^se {
    print('x is not positive');
  }
}
''');
    await assertNoAssist();
  }

  Future<void> test_notUseless() async {
    await resolveTestCode('''
void f(int x) {
  if (x > 0) {
    print('never reached');
  } el^se {
    print('x is not positive');
  }
}
''');
    await assertNoAssist();
  }

  Future<void> test_notUseless_switch() async {
    await resolveTestCode('''
void f(int x) {
  if (x > 0) {
    switch(x) {
      case 1:
        return;
      default:
        print('x is positive');
    }
  } el^se {
    print('x is not positive');
  }
}
''');
    await assertNoAssist();
  }

  Future<void> test_useless_switch() async {
    await resolveTestCode('''
void f(int x) {
  if (x > 0) {
    switch(x) {
      default:
        return;
    }
  } el^se {
    print('x is not positive');
  }
}
''');
    await assertHasAssist('''
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

  Future<void> test_statement() async {
    await resolveTestCode('''
void f(int x) {
  if (x > 0) {
    return;
  } el^se print('x is not positive');
}
''');
    await assertHasAssist('''
void f(int x) {
  if (x > 0) {
    return;
  }
  print('x is not positive');
}
''');
  }
}
