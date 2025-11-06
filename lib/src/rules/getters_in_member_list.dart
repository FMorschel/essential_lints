import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';

import 'rule.dart';

/// {@template getters_in_member_list_rule}
/// A lint rule that ensures getters/fields are included in member lists.
/// {@endtemplate}
class GettersInMemberListRule extends Rule {
  /// {@macro getters_in_member_list_rule}
  GettersInMemberListRule() : super(.gettersInMemberList);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {}
}
