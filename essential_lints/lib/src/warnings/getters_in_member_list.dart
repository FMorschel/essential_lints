import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../rules/analysis_rule.dart';
import '../utils/base_visitor.dart';
import '../utils/extensions/list.dart';
import '../utils/extensions/object.dart';
import 'essential_lint_warnings.dart';
import 'warning.dart';

/// {@template getters_in_member_list_rule}
/// A lint rule that ensures getters/fields are included in member lists.
/// {@endtemplate}
@staticLoggerEnforcement
class GettersInMemberListRule
    extends MultiWarningRule<GettersInMemberListRule, GettersInMemberList> {
  /// {@macro getters_in_member_list_rule}
  GettersInMemberListRule() : super(.gettersInMemberList, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'GettersInMemberListRule',
  );

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _GettersInMemberListVisitor(this, context);
    registry
      ..addClassDeclaration(this, visitor)
      ..addAnnotation(this, visitor);
  }
}

class _GettersInMemberListVisitor extends BaseVisitor<GettersInMemberListRule> {
  _GettersInMemberListVisitor(super.rule, super.context);

  static const _annotationName = 'GettersInMemberList';

  static final Uri _annotationUri = .parse(
    'package:essential_lints_annotations/src/getters_in_member_list.dart',
  );

  @override
  void visitAnnotation(Annotation node) {
    logger.info('GettersInMemberListVisitor.visitAnnotation() started');
    if (_isGettersInMemberListAnnotation(node.elementAnnotation)) {
      logger.fine('Found GettersInMemberList annotation');
      var annotation = _mapKnownArguments(node.elementAnnotation);
      if (annotation == null) {
        logger.finer('Annotation mapping failed');
        assert(false, 'The annotation should not be null here.');
        return;
      }
      logger.fine(
        'Annotation mapped: memberListName="${annotation.memberListName}"',
      );
      if (annotation.memberListName.isEmpty) {
        logger.finer('Member list name is empty, reporting error');
        rule.reportAtNode(
          node.arguments?.arguments
                  .firstWhereOrNull(_isMemberListName)
                  .whenTypeOrNull<NamedExpression>()
                  ?.expression ??
              node.name,
          diagnosticCode: GettersInMemberList.invalidMemberListName,
        );
      }
    }
    logger.info('GettersInMemberListVisitor.visitAnnotation() completed');
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    logger.info(
      'GettersInMemberListVisitor.visitClassDeclaration() started',
    );
    var element = node.declaredFragment?.element;
    if (element == null) {
      logger.finer('Class element is null, returning');
      return;
    }
    logger.fine('Processing class: ${node.namePart.typeName.lexeme}');
    var relevant = element.metadata.annotations
        .where(_isGettersInMemberListAnnotation)
        .map(_mapKnownArguments)
        .nonNulls;
    logger.fine(
      'Found ${relevant.length} relevant GettersInMemberList annotations',
    );
    for (var annotation in relevant) {
      var memberListName = annotation.memberListName;
      logger.finer(
        'Processing annotation for member list: $memberListName',
      );
      if (annotation.memberListName.isEmpty) {
        logger.finer('Member list name is empty, skipping');
        continue;
      }
      var getterMember = element.getGetter(memberListName);
      logger.finer(
        'Looking for getter: $memberListName, found: ${getterMember != null}',
      );
      if (getterMember == null ||
          getterMember.isStatic && annotation.instanceOnly) {
        logger.fine(
          'Getter missing or static-only mismatch, reporting missing list',
        );
        rule.reportAtToken(
          node.namePart.typeName,
          diagnosticCode: GettersInMemberList.missingList,
          arguments: [
            memberListName,
            if (annotation.instance) /*a*/ 'n instance' else '',
          ],
        );
        continue;
      }
      var member = node.body.membersOrNull
          ?.where((rule, getterMember).whereMatches)
          .singleOrNull;
      Token? memberName;
      Element? memberElement;
      if (member case MethodDeclaration(
        isGetter: true,
        :var name,
        declaredFragment: Fragment(:var element),
      )) {
        logger.finer('Found getter method: ${name.lexeme}');
        memberElement = element;
        memberName = name;
      } else if (member case FieldDeclaration(
        fields: VariableDeclarationList(
          :var variables,
        ),
      )) {
        logger.finer(
          'Found field declaration with ${variables.length} variables',
        );
        for (var variable in variables) {
          if (variable.declaredFragment?.element == getterMember.variable) {
            memberElement = getterMember;
            memberName = variable.name;
            break;
          }
        }
      }
      if (memberName == null || memberElement == null) {
        logger.finer('Member name or element not found, skipping');
        continue;
      }
      logger.fine('Member found: ${memberName.lexeme}');
      var expression = _calculateList(member, memberName);
      if (expression == null) {
        logger.finer('Could not calculate list, skipping');
        continue;
      }
      var getters = {
        for (var getter in element.getters) getter.displayName: getter,
      };
      for (var element in element.inheritedConcreteMembers.values) {
        if (element case GetterElement(:var enclosingElement)
            when enclosingElement != typeProvider.objectElement &&
                !getters.keys.contains(element.displayName)) {
          getters.addAll({
            element.displayName: element,
          });
        }
      }
      logger.fine('Total getters to check: ${getters.length}');
      var missing = _handleMemberList(
        getters.values.toList(),
        annotation,
        expression,
      );
      logger.fine('Missing members: ${missing.length}');
      if (missing.isNotEmpty) {
        logger.finer('Reporting missing members: ${missing.join(", ")}');
        rule.reportAtToken(
          memberName,
          diagnosticCode: EssentialMultiWarnings.gettersInMemberList,
          arguments: [
            annotation.gettersAndFieldsDescription,
            missing.quotedAndCommaSeparatedWithAnd,
          ],
        );
      }
    }
    logger.info(
      'GettersInMemberListVisitor.visitClassDeclaration() completed',
    );
  }

  ListLiteral? _calculateList(ClassMember? member, Token memberName) {
    logger.fine(
      '_calculateList() started for member: ${memberName.lexeme}',
    );
    Expression? expression;
    if (member case MethodDeclaration(:var body, isGetter: true)) {
      logger.finer('Member is getter method, checking body type');
      switch (body) {
        case BlockFunctionBody(:var block):
          logger.finer(
            'Body is BlockFunctionBody with ${block.statements.length} '
            'statements',
          );
          var statement = block.statements.last;
          if (statement is! ReturnStatement) {
            logger.finer(
              'Last statement is not ReturnStatement: ${statement.runtimeType}',
            );
            // We don't know how to handle this case.
            return null;
          }
          logger.finer('Extracted expression from return statement');
          expression = statement.expression;
        case ExpressionFunctionBody(expression: var expressionBody):
          logger.finer('Body is ExpressionFunctionBody');
          expression = expressionBody;
        case EmptyFunctionBody():
          logger.fine('Body is EmptyFunctionBody, reporting error');
          rule.reportAtToken(
            member.name,
            diagnosticCode: GettersInMemberList.invalidMemberList,
            arguments: [memberName.lexeme],
          );
          return null;
        case NativeFunctionBody():
          logger.fine('Body is NativeFunctionBody, reporting error');
          rule.reportAtToken(
            member.name,
            diagnosticCode: GettersInMemberList.invalidMemberList,
            arguments: [memberName.lexeme],
          );
          return null;
      }
    } else if (member case FieldDeclaration(
      fields: VariableDeclarationList(
        :var variables,
      ),
    )) {
      logger.finer(
        'Member is field declaration with ${variables.length} variables',
      );
      for (var variable in variables) {
        if (variable.initializer != null) {
          logger.finer(
            'Found variable with initializer: ${variable.name.lexeme}',
          );
          expression = variable.initializer;
          break;
        }
      }
    }
    if (expression == null) {
      logger.fine('Expression is null, reporting error');
      rule.reportAtNode(
        member,
        diagnosticCode: GettersInMemberList.invalidMemberList,
        arguments: [memberName.lexeme],
      );
      return null;
    }
    logger.finer('Expression type: ${expression.runtimeType}');
    if (expression is! ListLiteral) {
      logger.fine('Expression is not ListLiteral, reporting error');
      rule.reportAtOffset(
        expression.offset,
        1,
        diagnosticCode: GettersInMemberList.invalidMemberList,
        arguments: [memberName.lexeme],
      );
      // We don't know how to handle this case.
      return null;
    }
    logger.fine('Successfully extracted ListLiteral');
    return expression;
  }

  /// Sees if the [list] contains all required getters/fields.
  ///
  /// Returns a list of missing member names, or an empty list if all are
  /// present.
  Set<String> _handleMemberList(
    List<GetterElement> getters,
    _GettersInMemberListAnnotation annotation,
    ListLiteral list,
  ) {
    logger.fine(
      '_handleMemberList() started with ${getters.length} getters to check',
    );
    var literalElements = <(CollectionElement, Element)>[];
    logger.finer('Processing ${list.elements.length} list elements');
    for (var expression in list.elements) {
      if (expression case ParenthesizedExpression(expression: var value)) {
        logger.finer('Unwrapping ParenthesizedExpression');
        expression = value.unParenthesized;
      }
      if (expression
          case NullAwareElement(:var value) ||
              ParenthesizedExpression(expression: var value) ||
              SpreadElement(expression: var value)) {
        logger.finer(
          'Unwrapping NullAwareElement/ParenthesizedExpression/SpreadElement',
        );
        expression = value.unParenthesized;
      }
      SimpleIdentifier? getterIdentifier;
      if (expression
          case SimpleIdentifier identifier ||
              PropertyAccess(propertyName: var identifier)) {
        getterIdentifier = identifier;
      }
      var getterElement = getterIdentifier?.element;
      logger.finer(
        'List element: ${getterIdentifier?.name ?? "<unknown>"}, element '
        'found: ${getterElement != null}',
      );
      if (getterElement == null) {
        logger.finer(
          'No element found for: ${getterIdentifier?.name ?? "unknown"}, '
          'reporting error',
        );
        rule.reportAtNode(
          expression,
          diagnosticCode: GettersInMemberList.nonMemberIn,
        );
        continue;
      }
      literalElements.add((expression, getterElement));
    }

    bool valid(GetterElement element) {
      if ((!annotation.static && element.isStatic) ||
          (!annotation.instance && !element.isStatic) ||
          !annotation.getters && !element.variable.isOriginDeclaration ||
          !annotation.fields && element.variable.isOriginDeclaration ||
          annotation.types.isNotEmpty &&
              !annotation.types.contains(element.returnType) ||
          annotation.superTypes.isNotEmpty &&
              annotation.superTypes.none(
                (type) => typeSystem.isSubtypeOf(element.returnType, type),
              )) {
        return false;
      }
      return true;
    }

    var validGetters = getters.where(valid).toList();
    logger.fine('Valid getters after filtering: ${validGetters.length}');
    for (var (expression, element) in literalElements) {
      if (!validGetters.contains(element)) {
        logger.finer(
          'List element ${element.displayName} is not in valid getters, '
          'reporting error',
        );
        rule.reportAtNode(
          expression,
          diagnosticCode: GettersInMemberList.nonMemberIn,
        );
      }
    }
    var missing = <String>{};
    var elements = literalElements.map((e) => e.$2).toList();
    for (var element in validGetters) {
      if (!elements.contains(element)) {
        logger.finer('Missing member: ${element.displayName}');
        missing.add(element.displayName);
      }
    }
    logger.fine(
      '_handleMemberList() completed, found ${missing.length} missing members',
    );
    missing.remove(annotation.memberListName);
    return missing;
  }

  bool _isGettersInMemberListAnnotation(ElementAnnotation? annotation) {
    var element = annotation?.computeConstantValue()?.type?.element;
    return element?.library?.uri == _annotationUri &&
        element?.name == _annotationName;
  }

  bool _isMemberListName(Expression element) {
    if (element is! NamedExpression) {
      return false;
    }
    return element.name.label.name == 'memberListName';
  }

  _GettersInMemberListAnnotation? _mapKnownArguments(
    ElementAnnotation? annotation,
  ) {
    logger.fine('_mapKnownArguments() started');
    var type = annotation?.computeConstantValue();
    if (type == null) {
      logger.finer('Constant value is null, returning empty');
      return .empty;
    }
    var memberListNameString = type.getField('memberListName')?.toSymbolValue();
    var getters = type.getField('getters')?.toBoolValue();
    var fields = type.getField('fields')?.toBoolValue();
    var types = type.getField('types')?.toListValue();
    var superTypes = type.getField('superTypes')?.toListValue();
    var membersOption = type.getField('membersOption');

    logger.finer(
      'Extracted annotation fields: memberListName=$memberListNameString, '
      'getters=$getters, fields=$fields, types_count=${types?.length}, '
      'superTypes_count=${superTypes?.length}',
    );
    var result = _GettersInMemberListAnnotation(
      memberListName: memberListNameString ?? '',
      getters: getters ?? true,
      fields: fields ?? false,
      types: [...?types?.map((e) => e.type.singleTypeArgument).nonNulls],
      superTypes: [
        ...?superTypes?.map((e) => e.type.singleTypeArgument).nonNulls,
      ],
      membersOption: membersOption,
    );
    logger.fine(
      '_mapKnownArguments() completed with result: getters=${result.getters}, '
      'fields=${result.fields}',
    );
    return result;
  }
}

class _GettersInMemberListAnnotation {
  const _GettersInMemberListAnnotation({
    required this.memberListName,
    required this.getters,
    required this.fields,
    required this.types,
    required this.superTypes,
    required this.membersOption,
  });

  static const _GettersInMemberListAnnotation empty = .new(
    memberListName: '',
    getters: true,
    fields: false,
    types: [],
    superTypes: [],
    membersOption: null,
  );

  final String memberListName;
  final List<DartType> types;
  final List<DartType> superTypes;
  final bool getters;
  final bool fields;
  final DartObject? membersOption;

  String get gettersAndFieldsDescription => getters && !fields
      ? 'getters'
      : !getters && fields
      ? 'fields'
      : 'getters/fields';

  bool get static => membersOption?.variable?.name != 'instance';
  bool get instance => membersOption?.variable?.name != 'static';

  bool get instanceOnly => instance && !static;
  bool get staticOnly => static && !instance;
}

extension on (MultiWarningRule, GetterElement) {
  bool whereMatches(ClassMember member) {
    if (member case MethodDeclaration(
      declaredFragment: Fragment(:var element),
      isGetter: true,
    ) when element == $2.variable || element == $2) {
      return true;
    } else if (member case FieldDeclaration(
      fields: VariableDeclarationList(
        :var variables,
      ),
    )) {
      for (var variable in variables) {
        if (variable.declaredFragment?.element == $2.variable) {
          return true;
        }
      }
    }
    return false;
  }
}

extension on DartType? {
  DartType? get singleTypeArgument {
    if (this case InterfaceType type) {
      return type.typeArguments.singleOrNull;
    }
    return null;
  }
}

extension on ClassBody {
  List<ClassMember>? get membersOrNull => switch (this) {
    BlockClassBody(:var members) => members,
    EmptyClassBody() => null,
  };
}
