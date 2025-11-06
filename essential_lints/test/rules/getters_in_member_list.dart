import '../../lib/src/rules/getters_in_member_list.dart';
import '../../lib/src/rules/rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../src/rule_test_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(GettersInMemberListTest);
  });
}

@reflectiveTest
class GettersInMemberListTest extends RuleTestProcessor {
  @override
  Rule get rule => GettersInMemberListRule();
}
