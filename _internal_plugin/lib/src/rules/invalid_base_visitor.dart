import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/src/dart/ast/ast.dart';
import 'package:logging/logging.dart';

/// Base visitor for checking invalid modifiers/members in dot shorthand
/// syntax.
///
/// This visitor tracks types through the AST and checks if child types are
/// invalid for parent constructors based on annotations.
abstract class InvalidBaseVisitor extends SimpleAstVisitor<void> {
  InvalidBaseVisitor(this.context, this.rule, this.log);

  final RuleContext context;
  final AnalysisRule rule;
  final Logger log;
  final _nodeToType = <AstNode, DartType>{};

  /// The name of the annotation to check for (e.g., 'InvalidModifiers' or
  /// 'InvalidMembers')
  String get annotationName;

  /// The URI of the annotation's library
  Uri get annotationLibraryUri;

  /// The name of the field in the annotation that contains the set of invalid
  /// types
  String get invalidFieldName;

  /// The name of the type to track (e.g., 'Modifier' or 'Group')
  String get trackingTypeName;

  /// The URI of the tracking type's library
  Uri get trackingTypeLibraryUri;

  @override
  void visitDotShorthandPropertyAccess(DotShorthandPropertyAccess node) {
    log
      ..fine('\n=== visitDotShorthandPropertyAccess ===')
      ..fine('Node: $node')
      ..fine('Property name: ${node.propertyName.name}')
      ..fine('Current _nodeToType before: $_nodeToType');
    var typeToProcess = node.staticType;
    log.fine('Type to process: $typeToProcess');
    _process(typeToProcess, node.propertyName, node);
    node.parent?.accept(this);
    _nodeToType.clear();
  }

  void _process(
    DartType? type,
    AstNode nodeForReporting,
    AstNode nodeForProcessing,
  ) {
    log.fine('  _process called with type: $type');
    if (type == null) {
      log.fine('  Type is null, returning');
      return;
    }
    if (type.element case InterfaceElement(
      :var allSupertypes,
    ) when allSupertypes.any(_isTrackingType)) {
      log.fine(
        '  Type is a $trackingTypeName, adding to map: '
        '$nodeForReporting -> $type',
      );
      _nodeToType[nodeForReporting] = type;
    } else {
      log.fine('  Type is NOT a $trackingTypeName');
    }
  }

  @override
  void visitArgumentList(ArgumentList node) {
    log
      ..fine('\n=== visitArgumentList ===')
      ..fine('Current _nodeToType: $_nodeToType');
    node.parent?.accept(this);
  }

  @override
  void visitDotShorthandConstructorInvocation(
    DotShorthandConstructorInvocation node,
  ) {
    log
      ..fine('\n=== visitDotShorthandConstructorInvocation ===')
      ..fine('Node: $node')
      ..fine('Constructor name: ${node.constructorName.name}')
      ..fine('Current _nodeToType: $_nodeToType');

    var constructor = node.constructorName.element;
    if (constructor is! ConstructorElement) {
      log.fine('Constructor element is not a ConstructorElement, skipping');
      assert(
        false,
        'How can we have a DotShorthandConstructorInvocation '
        'without a ConstructorElement?',
      );
      return;
    }
    log.fine('Constructor element: $constructor');

    // Follow redirected constructor chain if present
    var enclosing =
        (constructor.redirectedConstructor ?? constructor).enclosingElement;
    log
      ..fine('Enclosing element (after following redirects): $enclosing')
      ..fine('  Checking element: ${enclosing.name}');
    var invalidAnnotations = enclosing.metadata.annotations
        .where(_isInvalidAnnotation)
        .toList();
    log.fine(
      '  Found ${invalidAnnotations.length} @$annotationName annotations',
    );
    for (final annotation in invalidAnnotations) {
      var constantValue = annotation.computeConstantValue();
      if (constantValue == null) continue;
      var invalidSet = constantValue.getField(invalidFieldName)?.toSetValue();
      if (invalidSet == null) continue;
      log.fine('  Checking ${invalidSet.length} invalid items');
      for (final member in invalidSet) {
        log.fine('    Member type: ${member.type}');
        // Check if ANY child type in the chain is invalid for current node
        if (member.type case InterfaceType(
          :var typeArguments,
        ) when typeArguments.length == 1) {
          log.fine('    Type argument: ${typeArguments.first}');
          for (final entry in _nodeToType.entries) {
            final childNode = entry.key;
            final childType = entry.value;
            var isAssignable = context.typeSystem.isAssignableTo(
              childType,
              typeArguments.first,
            );
            log.fine(
              '    Is $childType assignable to ${typeArguments.first}? '
              '$isAssignable',
            );
            if (isAssignable) {
              log.fine('    REPORTING ERROR!');
              reportError(childNode, node.constructorName.name);
              break; // Only report once per invalid type
            }
          }
        }
      }
    }

    log.fine('Continuing traversal with current type');
    // Continue traversal with current node's type
    _process(enclosing.thisType, node.constructorName, node);
    log.fine('Setting _node to current and traversing up');
    node.parent?.accept(this);
    _nodeToType.clear();
  }

  /// Report an error at the given node
  void reportError(AstNode node, String? name);

  bool _isInvalidAnnotation(ElementAnnotation element) {
    if (element.computeConstantValue() case DartObject(:var type)) {
      return type?.element?.name == annotationName &&
          type?.element?.library?.uri == annotationLibraryUri;
    }
    return false;
  }

  bool _isTrackingType(InterfaceType element) {
    return element.element.name == trackingTypeName &&
        element.element.library.uri == trackingTypeLibraryUri;
  }
}
