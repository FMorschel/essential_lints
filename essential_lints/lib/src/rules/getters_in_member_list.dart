import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';

import '../utils/extensions/list.dart';
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
  ) {
    var visitor = _GettersInMemberListVisitor(this, context);
    registry
      ..addClassDeclaration(this, visitor)
      ..addAnnotation(this, visitor);
  }
}

class _GettersInMemberListAnnotation {
  _GettersInMemberListAnnotation({
    required this.memberListName,
    required this.getters,
    required this.fields,
    required this.types,
  });

  final String memberListName;
  final List<DartType> types;
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

  static final Uri _annotationUri = Uri.parse(
    'package:essential_lints_annotations/src/getters_in_member_list.dart',
  );

  final GettersInMemberListRule rule;

  final RuleContext context;

  @override
  void visitAnnotation(Annotation node) {
    if (!_isGettersInMemberListAnnotation(node)) {
      return;
    }
    if (node.parent is! ClassDeclaration) {
      rule.reportAtNode(
        node.name,
        diagnosticCode: .notClassGettersInMemberList,
      );
    }
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    var annotations = node.sortedCommentAndAnnotations.whereType<Annotation>();
    if (annotations.isEmpty) {
      return;
    }
    var relevant = annotations.where(_isGettersInMemberListAnnotation);
    if (relevant.isEmpty) {
      return;
    }
    var arguments = relevant.map((annotation) => annotation.arguments).nonNulls;
    var finalAnnotations = <_GettersInMemberListAnnotation?>[];
    for (final argument in arguments) {
      finalAnnotations.add(_mapKnownArguments(argument));
    }
    if (finalAnnotations.isEmpty) {
      assert(false, 'We should be able to map at least one annotation.');
      return;
    }
    var element = node.declaredFragment?.element;
    if (element == null) {
      return;
    }
    for (final annotation in finalAnnotations.nonNulls) {
      if (annotation.memberListName.isEmpty) {
        continue;
      }
      var getterMember = element.getGetter(annotation.memberListName);
      if (getterMember == null || getterMember.isStatic) {
        rule.reportAtToken(
          node.name,
          diagnosticCode: .missingInstanceGettersInMemberList,
          arguments: [annotation.memberListName],
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
            diagnosticCode: .invalidMemberListGettersInMemberList,
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
        diagnosticCode: .invalidMemberListGettersInMemberList,
        arguments: [memberName.lexeme],
      );
      return null;
    }
    if (expression is! ListLiteral) {
      rule.reportAtOffset(
        expression.offset,
        1,
        diagnosticCode: .invalidMemberListGettersInMemberList,
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
          diagnosticCode: .nonMemberInGettersInMemberList,
        );
        continue;
      }
      literalElements.add((expression, getterElement));
    }

    bool valid(GetterElement element) {
      if (!annotation.getters && element.variable.isSynthetic ||
          !annotation.fields && !element.variable.isSynthetic ||
          annotation.types.isNotEmpty &&
              !annotation.types.contains(element.returnType)) {
        return false;
      }
      return true;
    }

    var validGetters = getters.where(valid).toList();
    for (final (expression, element) in literalElements) {
      if (!validGetters.contains(element)) {
        rule.reportAtNode(
          expression,
          diagnosticCode: .nonMemberInGettersInMemberList,
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

  bool _isGettersInMemberListAnnotation(Annotation annotation) {
    if (annotation.name.name != 'GettersInMemberList') {
      return false;
    }
    var element = annotation.element;
    if (element == null) {
      return false;
    }
    var library = element.library;
    if (library == null) {
      return false;
    }
    return library.uri == _annotationUri;
  }

  _GettersInMemberListAnnotation? _mapKnownArguments(
    ArgumentList argumentList,
  ) {
    var memberListName = '';
    var getters = true;
    var fields = true;
    var types = <DartType>[];
    for (final element in argumentList.arguments) {
      if (element is NamedExpression) {
        var name = element.name.label.name;
        var expression = element.expression;
        if (name == 'memberListName' && expression is StringLiteral) {
          memberListName = expression.stringValue ?? '';
          if (memberListName.isEmpty) {
            rule.reportAtNode(
              expression,
              diagnosticCode: .emptyMemberListNameGettersInMemberList,
            );
            return null;
          }
        } else if (name == 'getters' && expression is BooleanLiteral) {
          getters = expression.value;
        } else if (name == 'fields' && expression is BooleanLiteral) {
          fields = expression.value;
        } else if (name == 'types' && expression is ListLiteral) {
          for (final identifier in expression.elements) {
            if (identifier case InstanceCreationExpression(
              constructorName: ConstructorName(
                type: NamedType(
                  typeArguments: TypeArgumentList(:var singleType?),
                ),
              ),
            )) {
              types.add(singleType);
            }
          }
        }
      }
    }
    return _GettersInMemberListAnnotation(
      memberListName: memberListName,
      getters: getters,
      fields: fields,
      types: types,
    );
  }
}

extension on (Rule, GetterElement) {
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

extension on TypeArgumentList {
  DartType? get singleType {
    if (arguments.length != 1) {
      return null;
    }
    return arguments.first.type;
  }
}
