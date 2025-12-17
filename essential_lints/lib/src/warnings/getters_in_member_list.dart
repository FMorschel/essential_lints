import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';

import '../utils/extensions/list.dart';
import '../utils/extensions/object.dart';
import 'essential_lint_warnings.dart';
import 'warning.dart';

/// {@template getters_in_member_list_rule}
/// A lint rule that ensures getters/fields are included in member lists.
/// {@endtemplate}
class GettersInMemberListRule extends MultiWarningRule<GettersInMemberList> {
  /// {@macro getters_in_member_list_rule}
  GettersInMemberListRule() : super(.gettersInMemberList);

  @override
  List<GettersInMemberList> get subWarnings => GettersInMemberList.values;

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

class _GettersInMemberListAnnotation {
  const _GettersInMemberListAnnotation({
    required this.memberListName,
    required this.getters,
    required this.fields,
    required this.types,
    required this.superTypes,
  });

  static const _GettersInMemberListAnnotation empty = .new(
    memberListName: '',
    getters: true,
    fields: false,
    types: [],
    superTypes: [],
  );

  final String memberListName;
  final List<DartType> types;
  final List<DartType> superTypes;
  final bool getters;
  final bool fields;

  String get gettersAndFieldsDescription => getters && !fields
      ? 'getters'
      : !getters && fields
      ? 'fields'
      : 'getters/fields';
}

class _GettersInMemberListVisitor extends SimpleAstVisitor<void> {
  _GettersInMemberListVisitor(this.rule, this.context);

  static const _annotationName = 'GettersInMemberList';

  static final Uri _annotationUri = .parse(
    'package:essential_lints_annotations/src/getters_in_member_list.dart',
  );

  final GettersInMemberListRule rule;
  final RuleContext context;

  @override
  void visitAnnotation(Annotation node) {
    if (_isGettersInMemberListAnnotation(node.elementAnnotation)) {
      var annotation = _mapKnownArguments(node.elementAnnotation);
      if (annotation == null) {
        assert(false, 'The annotation should not be null here.');
        return;
      }
      if (annotation.memberListName.isEmpty) {
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
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    var element = node.declaredFragment?.element;
    if (element == null) {
      return;
    }
    var relevant = element.metadata.annotations
        .where(_isGettersInMemberListAnnotation)
        .map(_mapKnownArguments)
        .nonNulls;
    for (final annotation in relevant) {
      var memberListName = annotation.memberListName;
      if (annotation.memberListName.isEmpty) {
        continue;
      }
      var getterMember = element.getGetter(memberListName);
      if (getterMember == null || getterMember.isStatic) {
        rule.reportAtToken(
          node.name,
          diagnosticCode: GettersInMemberList.missingList,
          arguments: [memberListName],
        );
        continue;
      }
      var member = node.members
          .where((rule, getterMember).whereMatches)
          .singleOrNull;
      Token? memberName;
      Element? memberElement;
      if (member case MethodDeclaration(
        isGetter: true,
        :var name,
        declaredFragment: Fragment(:var element),
      )) {
        memberElement = element;
        memberName = name;
      } else if (member case FieldDeclaration(
        fields: VariableDeclarationList(
          :var variables,
        ),
      )) {
        for (final variable in variables) {
          if (variable.declaredFragment?.element == getterMember.variable) {
            memberElement = getterMember;
            memberName = variable.name;
            break;
          }
        }
      }
      if (memberName == null || memberElement == null) {
        continue;
      }
      var expression = _calculateList(member, memberName);
      if (expression == null) {
        continue;
      }
      var getters = element.getters.toList()..remove(memberElement);
      var missing = _handleMemberList(getters, annotation, expression);
      if (missing.isNotEmpty) {
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
  }

  ListLiteral? _calculateList(ClassMember? member, Token memberName) {
    Expression? expression;
    if (member case MethodDeclaration(:var body, isGetter: true)) {
      switch (body) {
        case BlockFunctionBody(:var block):
          var statement = block.statements.last;
          if (statement is! ReturnStatement) {
            // We don't know how to handle this case.
            return null;
          }
          expression = statement.expression;
        case ExpressionFunctionBody(expression: var expressionBody):
          expression = expressionBody;
        case EmptyFunctionBody():
        case NativeFunctionBody():
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
      for (final variable in variables) {
        if (variable.initializer != null) {
          expression = variable.initializer;
          break;
        }
      }
    }
    if (expression == null) {
      rule.reportAtNode(
        member,
        diagnosticCode: GettersInMemberList.invalidMemberList,
        arguments: [memberName.lexeme],
      );
      return null;
    }
    if (expression is! ListLiteral) {
      rule.reportAtOffset(
        expression.offset,
        1,
        diagnosticCode: GettersInMemberList.invalidMemberList,
        arguments: [memberName.lexeme],
      );
      // We don't know how to handle this case.
      return null;
    }
    return expression;
  }

  /// Sees if the [list] contains all required getters/fields.
  ///
  /// Returns a list of missing member names, or an empty list if all are
  /// present.
  List<String> _handleMemberList(
    List<GetterElement> getters,
    _GettersInMemberListAnnotation annotation,
    ListLiteral list,
  ) {
    var literalElements = <(CollectionElement, Element)>[];
    for (final expression in list.elements) {
      SimpleIdentifier? getterIdentifier;
      if (expression
          case SimpleIdentifier identifier ||
              PropertyAccess(propertyName: var identifier)) {
        getterIdentifier = identifier;
      }
      var getterElement = getterIdentifier?.element;
      if (getterElement == null) {
        rule.reportAtNode(
          expression,
          diagnosticCode: GettersInMemberList.nonMemberIn,
        );
        continue;
      }
      literalElements.add((expression, getterElement));
    }

    bool valid(GetterElement element) {
      if (element.isStatic ||
          !annotation.getters && element.variable.isSynthetic ||
          !annotation.fields && !element.variable.isSynthetic ||
          annotation.types.isNotEmpty &&
              !annotation.types.contains(element.returnType) ||
          annotation.superTypes.isNotEmpty &&
              annotation.superTypes.none(
                (type) => context.typeSystem.isSubtypeOf(
                  element.returnType,
                  type,
                ),
              )) {
        return false;
      }
      return true;
    }

    var validGetters = getters.where(valid).toList();
    for (final (expression, element) in literalElements) {
      if (!validGetters.contains(element)) {
        rule.reportAtNode(
          expression,
          diagnosticCode: GettersInMemberList.nonMemberIn,
        );
      }
    }
    var missing = <String>[];
    var elements = literalElements.map((e) => e.$2).toList();
    for (final element in validGetters) {
      if (!elements.contains(element)) {
        missing.add(element.displayName);
      }
    }
    return missing;
  }

  bool _isGettersInMemberListAnnotation(ElementAnnotation? annotation) {
    if (annotation?.element is! ConstructorElement) {
      return false;
    }
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
    var element = annotation?.element;
    if (element is! ConstructorElement) return .empty;

    var type = annotation?.computeConstantValue();
    if (type == null) return .empty;
    var memberListNameString = type.getField('memberListName')?.toSymbolValue();
    var getters = type.getField('getters')?.toBoolValue();
    var fields = type.getField('fields')?.toBoolValue();
    var types = type.getField('types')?.toListValue();
    var superTypes = type.getField('superTypes')?.toListValue();

    return _GettersInMemberListAnnotation(
      memberListName: memberListNameString ?? '',
      getters: getters ?? true,
      fields: fields ?? false,
      types: [...?types?.map((e) => e.type.singleTypeArgument).nonNulls],
      superTypes: [
        ...?superTypes?.map((e) => e.type.singleTypeArgument).nonNulls,
      ],
    );
  }
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
      for (final variable in variables) {
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
