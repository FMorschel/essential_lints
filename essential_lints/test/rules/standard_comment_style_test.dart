import 'package:essential_lints/src/rules/rule.dart';
import 'package:essential_lints/src/rules/standard_comment_style.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(StandardCommentStyleRuleTest);
  });
}

@reflectiveTest
class StandardCommentStyleRuleTest extends LintTestProcessor {
  @override
  LintRule get rule => StandardCommentStyleRule();

  Future<void> test_beforeEof() async {
    await assertDiagnostics(
      '''
void f() {}
//this comment is after code
''',
      [lint(12, 28)],
    );
  }

  Future<void> test_codeBlock() async {
    await assertNoDiagnostics('''
/// This is a doc comment.
///
/// ```dart
/// void f() {}
/// ```
///
/// A new paragraph.
void f() {}
''');
  }

  Future<void> test_codeBlock_wrongComments() async {
    await assertDiagnostics(
      '''
/// This is a doc comment
///
/// ```dart
/// void f() {}
/// ```
///
/// a new paragraph.
void f() {}
''',
      [
        lint(0, 25),
        lint(70, 20),
      ],
    );
  }

  Future<void> test_docComment() async {
    await assertDiagnostics(
      '''
/// This is a doc comment
void f() {}
''',
      [lint(0, 25)],
    );
  }

  Future<void> test_emptyComment() async {
    await assertNoDiagnostics('''
//
//
''');
  }

  Future<void> test_improperlyFormattedComment() async {
    await assertDiagnostics(
      '''
// This is an improperly formatted comment
''',
      [lint(0, 42)],
    );
  }

  Future<void> test_multiline_correct() async {
    await assertNoDiagnostics('''
/* This is a multiline comment.
   that follows the rules. */
''');
  }

  Future<void> test_multiline_leadingStars() async {
    await assertNoDiagnostics('''
/* This is a multiline comment.
   * It has leading stars.  */
''');
  }

  Future<void> test_multiline_wrong() async {
    await assertDiagnostics(
      '''
/* this is a multiline comment
that does not follow the rules */
''',
      [lint(0, 64)],
    );
  }

  Future<void> test_multipleComments() async {
    await assertNoDiagnostics('''
// This is a
// multiline comment!
''');
  }

  Future<void> test_multipleComments_missingDot() async {
    await assertDiagnostics(
      '''
// This is a
// multiline comment
''',
      [lint(0, 12)],
    );
  }

  Future<void> test_noLeadingSpace() async {
    await assertDiagnostics(
      '''
//This comment has no leading space.
''',
      [lint(0, 36)],
    );
  }

  Future<void> test_noPhrase() async {
    await assertNoDiagnostics('''
// 1234
''');
  }

  Future<void> test_noWhitespace_specific_comment() async {
    await assertDiagnostics(
      '''
// This is a
//multiline comment!
''',
      [lint(13, 20)],
    );
  }

  Future<void> test_properlyFormattedComment() async {
    await assertNoDiagnostics('''
// This is a properly formatted comment.
''');
  }

  Future<void> test_secondParagraph() async {
    await assertNoDiagnostics('''
// This is a
// multiline comment!
//
//
// Another paragraph starts here?
''');
  }

  Future<void> test_secondParagraph_lowercase() async {
    await assertDiagnostics(
      '''
// This is a
// multiline comment!
//
// another paragraph starts here?
''',
      [lint(38, 33)],
    );
  }

  Future<void> test_startsWithlowercase() async {
    await assertDiagnostics(
      '''
// this comment starts with lowercase.
''',
      [lint(0, 38)],
    );
  }

  Future<void> test_endsInColon() async {
    await assertNoDiagnostics('''
// This comment ends in colon:
''');
  }

  Future<void> test_endsInSemicolon() async {
    await assertNoDiagnostics('''
// This comment ends in semicolon;
''');
  }
}
