import 'package:essential_lints/src/assist/essential_lint_assists.dart';

import '../src/assist_test.dart';

class RemoveUselessElseTest extends AssistTest {
  @override
  EssentialLintAssists get assistKind => .removeUselessElse;
}
