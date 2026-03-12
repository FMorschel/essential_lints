import 'package:essential_lints/src/assist/essential_lint_assists.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/assist_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(MergeAsMultilineTest);
  });
}

@reflectiveTest
class MergeAsMultilineTest extends AssistTestProcessor {
  @override
  EssentialLintAssists get assistKind => .mergeAsMultiline;

  Future<void> test_empty() async {
    await resolveTestCode('''
void f(int x) {
  ''^
  '';
}
''');
    await assertHasAssist("""
void f(int x) {
  '''

''';
}
""");
  }

  Future<void> test_empty2() async {
    await resolveTestCode('''
void f(int x) {
  ''
  ''^;
}
''');
    await assertHasAssist("""
void f(int x) {
  '''

''';
}
""");
  }

  Future<void> test_notStringLiteral() async {
    await resolveTestCode('''
void f() { print(4^2); }
''');
    await assertNoAssist();
  }

  Future<void> test_notAdjacentStrings() async {
    await resolveTestCode('''
void f() { var s = 'hello^'; }
''');
    await assertNoAssist();
  }

  Future<void> test_twoStrings_sameLine() async {
    await resolveTestCode('''
void f() {
  var s = 'hello' 'wor^ld';
}
''');
    await assertHasAssist("""
void f() {
  var s = '''
helloworld''';
}
""");
  }

  Future<void> test_twoStrings_sameLine_withContent() async {
    await resolveTestCode('''
void f() {
  var s = 'foo' 'b^ar';
}
''');
    await assertHasAssist("""
void f() {
  var s = '''
foobar''';
}
""");
  }

  Future<void> test_twoStrings_differentLines_withContent() async {
    await resolveTestCode('''
void f() {
  var s = 'hello'^
  'world';
}
''');
    await assertHasAssist("""
void f() {
  var s = '''
hello
world''';
}
""");
  }

  Future<void> test_oneRawString_producesRawTriple() async {
    await resolveTestCode(r'''
void f() {
  var s = r'hell\no' 'wor^ld';
}
''');
    await assertHasAssist(r"""
void f() {
  var s = r'''
hell\noworld''';
}
""");
  }

  Future<void> test_allRawStrings_producesRawTriple() async {
    await resolveTestCode('''
void f() {
  var s = r'foo' r'ba^r';
}
''');
    await assertHasAssist("""
void f() {
  var s = r'''
foobar''';
}
""");
  }

  Future<void> test_interpolation_preventsRaw() async {
    await resolveTestCode(r'''
void f(x) {
  var s = '${24}x' 'wor^ld';
}
''');
    await assertHasAssist(r"""
void f(x) {
  var s = '''
${24}xworld''';
}
""");
  }

  Future<void> test_rawAndInterpolation_preventsRaw() async {
    await resolveTestCode(r'''
void f(x) {
  var s = r'hello' '${24}x^';
}
''');
    await assertHasAssist(r"""
void f(x) {
  var s = '''
hello${24}x''';
}
""");
  }

  Future<void> test_preventsRaw_escape() async {
    await resolveTestCode(r'''
void f(x) {
  var s = r'\$hello' '${24}x^';
}
''');
    await assertHasAssist(r"""
void f(x) {
  var s = '''
\\\$hello${24}x''';
}
""");
  }

  Future<void> test_trippleQuotes_escape() async {
    await resolveTestCode('''
void f(x) {
  var s = "''\'" r'hello^';
}
''');
    await assertHasAssist(r"""
void f(x) {
  var s = '''
''\'hello''';
}
""");
  }

  Future<void> test_trailingQuote_escape() async {
    await resolveTestCode('''
void f(x) {
  var s = r'hello' "'^";
}
''');
    await assertHasAssist(r"""
void f(x) {
  var s = '''
hello\'''';
}
""");
  }

  Future<void> test_trailingQuote_interpolated_escape() async {
    await resolveTestCode('''
void f(x) {
  var s = r'hello' "\${4}''\''^";
}
''');
    await assertHasAssist(r"""
void f(x) {
  var s = '''
hello${4}''\'\'''';
}
""");
  }

  Future<void> test_threeStrings_allSameLine() async {
    await resolveTestCode('''
void f() {
  var s = 'a' 'b' 'c^';
}
''');
    await assertHasAssist("""
void f() {
  var s = '''
abc''';
}
""");
  }

  Future<void> test_threeStrings_allDifferentLines() async {
    await resolveTestCode('''
void f() {
  var s = 'a'^
  'b'
  'c';
}
''');
    await assertHasAssist("""
void f() {
  var s = '''
a
b
c''';
}
""");
  }

  Future<void> test_threeStrings_mixedLines() async {
    await resolveTestCode('''
void f() {
  var s = 'a' 'b'^
  'c';
}
''');
    await assertHasAssist("""
void f() {
  var s = '''
ab
c''';
}
""");
  }

  Future<void> test_threeStrings_rawMixed() async {
    await resolveTestCode('''
void f() {
  var s = 'foo' r'bar' 'baz^';
}
''');
    await assertHasAssist("""
void f() {
  var s = r'''
foobarbaz''';
}
""");
  }

  Future<void> test_threeStrings_interpolationBlocksRaw() async {
    await resolveTestCode(r'''
void f(x) {
  var s = r'raw' '${24}x' 'plain^';
}
''');
    await assertHasAssist(r"""
void f(x) {
  var s = '''
raw${24}xplain''';
}
""");
  }

  Future<void> test_stopsAtCommentsWithContent() async {
    await resolveTestCode('''
void f() {
  var s = 'foo' // comment
  'bar^';
}
''');
    await assertNoAssist();
  }

  Future<void> test_stopsAtCommentsWithContent_2() async {
    await resolveTestCode('''
void f() {
  var s = 'foo' // comment
  'bar^'
  'baz';
}
''');
    await assertHasAssist("""
void f() {
  var s = 'foo' // comment
  '''
bar
baz''';
}
""");
  }

  Future<void> test_stopsAtCommentsWithContent_3() async {
    await resolveTestCode('''
void f() {
  var s = 'foo'
  'bar^' // comment
  'baz';
}
''');
    await assertHasAssist("""
void f() {
  var s = '''
foo
bar''' // comment
  'baz';
}
""");
  }

  Future<void> test_emptyCommentsAreIgnored() async {
    await resolveTestCode('''
void f() {
  var s = 'foo' //
  'bar^';
}
''');
    await assertHasAssist("""
void f() {
  var s = '''
foo
bar''';
}
""");
  }
}
