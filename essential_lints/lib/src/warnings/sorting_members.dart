import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:collection/collection.dart';
import 'package:essential_lints_annotations/src/sorting_members/sort_declarations.dart'; // ignore: implementation_imports used only for exhaustiveness
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import 'warning.dart';

final _logger = Logger('sorting_members_rule');

/// {@template sorting_members_rule}
/// The rule for sorting_members warning.
/// {@endtemplate}
class SortingMembersRule extends WarningRule {
  /// {@macro sorting_members_rule}
  SortingMembersRule() : super(.sortingMembers);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _SortingMembersVisitor(this, context);
    registry
      ..addClassDeclaration(this, visitor)
      ..addMixinDeclaration(this, visitor)
      ..addExtensionDeclaration(this, visitor)
      ..addExtensionTypeDeclaration(this, visitor)
      ..addEnumDeclaration(this, visitor);
  }
}

/// {@template member_result}
/// Result of analyzing a member.
/// {@endtemplate}
class MemberResult {
  /// {@macro member_result}
  MemberResult({
    required this.node,
    required this.element,
    required this.validatorIndex,
    required this.requiredLinesBefore,
    required this.requiredLinesAfter,
  });

  /// The member node.
  final AstNode node;

  /// The member element.
  final Element element;

  /// The index of the validator that matched this member, or null if none
  /// matched.
  final int? validatorIndex;

  /// The required number of blank lines before this member, based on spacing
  /// rules.
  final int? requiredLinesBefore;

  /// The required number of blank lines after this member, based on spacing
  /// rules.
  final int? requiredLinesAfter;
}

abstract class _BaseMemberVisitor extends RecursiveAstVisitor<void> {
  _BaseMemberVisitor(this.unit);

  final CompilationUnit unit;

  LineInfo get lineInfo => unit.lineInfo;

  int _getDeclarationLastLine(AstNode node) {
    return lineInfo.getLocation(node.endToken.offset).lineNumber;
  }

  String _getMemberName(AstNode node, Element element) {
    // Treat unnamed constructors as "new" for alphabetical sorting
    if (node is ConstructorDeclaration && node.name == null) {
      return 'new';
    }
    return element.name ?? '';
  }

  void handleMember(AstNode node, Element element);

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    var element = node.declaredFragment?.element;
    if (element == null) return;
    handleMember(node, element);
  }

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    // Check each variable in the field declaration
    for (var variable in node.fields.variables) {
      var element = variable.declaredFragment?.element;
      if (element == null) continue;
      handleMember(node, element);
    }
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    var element = node.declaredFragment?.element;
    if (element == null) return;
    handleMember(node, element);
  }
}

class _LintingMemberVisitor extends _BaseMemberVisitor {
  _LintingMemberVisitor(
    this.rule,
    RuleContext context,
    this.validatorFromAnnotation,
  ) : super(context.definingUnit.unit);

  final ValidatorFromAnnotation validatorFromAnnotation;
  final SortingMembersRule rule;
  int current = 0;
  bool reported = false;
  int? previousDeclarationLastLine;
  String? previousMemberName;
  String? previousUnsortedMemberName;
  int? previousValidatorIndex;
  bool? previousWasSorted;

  int _getBlankLinesBetween(int lastLine, int currentLine) {
    // Number of blank lines = (current line - last line - 1)
    // e.g., line 5 to line 7 has 1 blank line (line 6)
    return currentLine - lastLine - 1;
  }

  void _checkSpacing(
    AstNode node,
    Element element, {
    required int validatorIndex,
    required bool isSorted,
  }) {
    if (previousDeclarationLastLine == null) return;

    var currentLine = lineInfo.getLocation(node.beginToken.offset).lineNumber;
    var blankLines = _getBlankLinesBetween(
      previousDeclarationLastLine!,
      currentLine,
    );

    // Check linesBetweenSameSortMembers - when staying within same validator
    if (validatorFromAnnotation.linesBetweenSameSortMembers != null &&
        previousValidatorIndex == validatorIndex &&
        previousValidatorIndex != null &&
        previousValidatorIndex != -1 &&
        validatorIndex != -1) {
      var required = validatorFromAnnotation.linesBetweenSameSortMembers!;
      if (blankLines != required) {
        _reportAt(node, element);
        return;
      }
    }

    // Check linesAroundSortedMembers - when transitioning between different
    // validators (both sorted)
    if (validatorFromAnnotation.linesAroundSortedMembers != null &&
        previousValidatorIndex != validatorIndex &&
        previousValidatorIndex != null &&
        previousValidatorIndex != -1 &&
        validatorIndex != -1) {
      var required = validatorFromAnnotation.linesAroundSortedMembers!;
      if (blankLines != required) {
        _reportAt(node, element);
        return;
      }
    }

    // Check linesAroundUnsortedMembers - when transitioning between sorted and
    // unsorted
    if (validatorFromAnnotation.linesAroundUnsortedMembers != null &&
        previousWasSorted != isSorted) {
      var required = validatorFromAnnotation.linesAroundUnsortedMembers!;
      if (blankLines != required) {
        _reportAt(node, element);
        return;
      }
    }

    // Check spacing between unsorted members when:
    // 1. alphabetizeUnsortedMembers is enabled, OR
    // 2. There are no validators at all (all members are unsorted)
    if (validatorFromAnnotation.linesAroundUnsortedMembers != null &&
        !isSorted &&
        (previousWasSorted == null || previousWasSorted == false) &&
        (validatorFromAnnotation.alphabetizeUnsortedMembers ||
            validatorFromAnnotation.validators.isEmpty)) {
      var required = validatorFromAnnotation.linesAroundUnsortedMembers!;
      if (blankLines != required) {
        _reportAt(node, element);
        return;
      }
    }
  }

  void _checkAlphabeticalSorted(
    AstNode node,
    Element element,
    String memberName,
  ) {
    if (previousMemberName != null &&
        validatorFromAnnotation.alphabetizeSortedMembers) {
      // Special case: "new" (unnamed constructor) always comes first
      if (previousMemberName == 'new' && memberName != 'new') {
        // Previous was unnamed constructor, current is not - correct order
      } else if (memberName == 'new' && previousMemberName != 'new') {
        // Current is unnamed constructor, previous was not - wrong order
        _reportAt(node, element);
        return;
      } else {
        // Both are "new" or neither is "new" - use regular alphabetical
        // comparison
        if (memberName.toLowerCase().compareTo(
              previousMemberName!.toLowerCase(),
            ) <
            0) {
          _reportAt(node, element);
          return;
        }
      }
    }
  }

  void _checkAlphabeticalUnsorted(
    AstNode node,
    Element element,
    String memberName,
  ) {
    if (previousUnsortedMemberName != null &&
        validatorFromAnnotation.alphabetizeUnsortedMembers) {
      // Special case: "new" (unnamed constructor) always comes first
      if (previousUnsortedMemberName == 'new' && memberName != 'new') {
        // Previous was unnamed constructor, current is not - correct order
      } else if (memberName == 'new' && previousUnsortedMemberName != 'new') {
        // Current is unnamed constructor, previous was not - wrong order
        _reportAt(node, element);
        return;
      } else {
        // Both are "new" or neither is "new" - use regular alphabetical
        // comparison
        if (memberName.toLowerCase().compareTo(
              previousUnsortedMemberName!.toLowerCase(),
            ) <
            0) {
          _reportAt(node, element);
          return;
        }
      }
    }
  }

  @override
  void handleMember(AstNode node, Element element) {
    if (reported) return;

    // If there are no validators, all members are unsorted
    if (validatorFromAnnotation.validators.isEmpty) {
      var memberName = _getMemberName(node, element);
      _checkSpacing(node, element, validatorIndex: -1, isSorted: false);
      if (reported) return;

      _checkAlphabeticalUnsorted(node, element, memberName);
      if (reported) return;

      previousUnsortedMemberName = memberName;
      previousDeclarationLastLine = _getDeclarationLastLine(node);
      previousValidatorIndex = -1;
      previousWasSorted = false;
      return;
    }

    if (current >= validatorFromAnnotation.validators.length) return;

    var validator = validatorFromAnnotation.validators[current];
    var memberName = _getMemberName(node, element);

    if (validator.isValid(node, element)) {
      // Check spacing before alphabetical/order checks
      _checkSpacing(node, element, validatorIndex: current, isSorted: true);
      if (reported) return;

      _checkAlphabeticalSorted(node, element, memberName);
      if (reported) return;

      // Member matches current validator
      // Check ALL validators for a more specific match
      for (var i = 0; i < validatorFromAnnotation.validators.length; i++) {
        if (i == current) continue; // Skip current validator
        var otherValidator = validatorFromAnnotation.validators[i];
        if (otherValidator.isValid(node, element) &&
            otherValidator.isMoreSpecificThan(validator)) {
          // There's a more specific validator elsewhere
          if (i > current) {
            // More specific validator is ahead - jump to it
            current = i;
            previousMemberName = null;
            previousDeclarationLastLine = _getDeclarationLastLine(node);
            previousValidatorIndex = i;
            previousWasSorted = true;
            return;
          } else {
            // More specific validator is behind - member is out of order
            _reportAt(node, element);
            return;
          }
        }
      }
      // No more specific validator found - this is the right match
      // Reset previousMemberName if validator changed
      if (previousValidatorIndex != current) {
        previousMemberName = null;
      }
      previousMemberName = memberName;
      previousDeclarationLastLine = _getDeclarationLastLine(node);
      previousValidatorIndex = current;
      previousWasSorted = true;
      return;
    }

    // Member doesn't match current validator.
    // Check if member matches any previous validators (wrong order)
    for (var i = 0; i < current; i++) {
      if (validatorFromAnnotation.validators[i].isValid(node, element)) {
        // Member matches a previous validator - report error
        _reportAt(node, element);
        return;
      }
    }

    // Try to find a new validator that matches this member
    var previousCurrent = current;
    for (
      var i = current + 1;
      i < validatorFromAnnotation.validators.length;
      i++
    ) {
      if (validatorFromAnnotation.validators[i].isValid(node, element)) {
        // Found a matching validator ahead - check spacing before moving to it
        _checkSpacing(node, element, validatorIndex: i, isSorted: true);
        if (reported) return;

        // Move to the new validator
        current = i;
        // Reset previousMemberName when changing validators
        previousMemberName = memberName;
        previousDeclarationLastLine = _getDeclarationLastLine(node);
        previousValidatorIndex = i;
        previousWasSorted = true;
        return;
      }
    }

    // No matching validator found - this is an unsorted member
    // Now check spacing and alphabetical constraints for unsorted members.
    _checkSpacing(node, element, validatorIndex: -1, isSorted: false);
    if (reported) return;

    _checkAlphabeticalUnsorted(node, element, memberName);
    if (reported) return;
    current = previousCurrent;
    // Reset previousUnsortedMemberName when transitioning to unsorted
    if (previousWasSorted ?? true) {
      previousUnsortedMemberName = null;
    }
    previousUnsortedMemberName = memberName;
    previousDeclarationLastLine = _getDeclarationLastLine(node);
    previousValidatorIndex = -1;
    previousWasSorted = false;
  }

  void _reportAt(AstNode node, Element element) {
    switch (node) {
      case MethodDeclaration(:var name):
        rule.reportAtToken(name);
      case FieldDeclaration(:var fields):
        for (var variable in fields.variables) {
          if (variable.declaredFragment?.element == element) {
            rule.reportAtToken(variable.name);
            break;
          }
        }
      case ConstructorDeclaration(:var name):
        if (name != null) {
          rule.reportAtToken(name);
        } else {
          rule.reportAtNode(node.returnType);
        }
      default:
        _logger.severe('Unexpected node type for member: $node');
        assert(false, 'Unexpected node type for member: $node');
        rule.reportAtNode(node);
    }
    reported = true;
  }
}

/// {@template tracking_member_visitor}
/// Visitor that tracks members and their validator matches.
/// {@endtemplate}
class TrackingMemberVisitor extends _BaseMemberVisitor {
  /// {@macro tracking_member_visitor}
  TrackingMemberVisitor(
    super.unit,
    this.validatorFromAnnotation,
  );

  /// The configuration extracted from the SortingMembers annotation.
  final ValidatorFromAnnotation validatorFromAnnotation;

  /// The list of members analyzed.
  final List<MemberResult> members = [];

  @override
  void handleMember(AstNode node, Element element) {
    var index = validatorFromAnnotation.match(node, element);
    members.add(
      MemberResult(
        node: node,
        element: element,
        validatorIndex: index,
        requiredLinesAfter: null,
        requiredLinesBefore: null,
      ),
    );
  }

  /// Returns the members sorted according to the validator indices and, if
  /// needed, alphabetically, with spacing information.
  List<MemberResult> get sortedMembers {
    var sorted = <MemberResult>[];

    // Separate sorted and unsorted members
    var sortedMembers = <MemberResult>[];
    var unsortedMembers = <MemberResult>[];

    for (var member in members) {
      if (member.validatorIndex != null) {
        sortedMembers.add(member);
      } else {
        unsortedMembers.add(member);
      }
    }

    // If alphabetizeUnsortedMembers is true, group all unsorted members
    // together
    if (validatorFromAnnotation.alphabetizeUnsortedMembers ||
        validatorFromAnnotation.validators.isEmpty) {
      // Group sorted members by validator index
      var membersByValidator = <int, List<MemberResult>>{};
      for (var member in sortedMembers) {
        membersByValidator
            .putIfAbsent(member.validatorIndex!, () => [])
            .add(member);
      }

      // Sort members within each validator group if needed
      for (var validatorIndex in membersByValidator.keys) {
        if (validatorFromAnnotation.alphabetizeSortedMembers) {
          membersByValidator[validatorIndex]!.sort(_compareAlphabetical);
        }
      }

      // Process validators in order
      var sortedValidatorIndices = membersByValidator.keys.toList()..sort();

      for (var validatorIndex in sortedValidatorIndices) {
        sorted.addAll(membersByValidator[validatorIndex]!);
      }

      // Add all unsorted members at the end
      if (validatorFromAnnotation.alphabetizeUnsortedMembers) {
        unsortedMembers.sort(_compareAlphabetical);
      }
      sorted.addAll(unsortedMembers);
    } else {
      // Keep unsorted members attached to the specific sorted member before
      // them
      var unsortedAttachments = <MemberResult?, List<MemberResult>>{};
      MemberResult? lastSortedMember;

      for (var member in members) {
        if (member.validatorIndex != null) {
          lastSortedMember = member;
        } else {
          unsortedAttachments
              .putIfAbsent(lastSortedMember, () => [])
              .add(member);
        }
      }

      // First, add any unsorted members that came before any sorted members
      if (unsortedAttachments.containsKey(null)) {
        sorted.addAll(unsortedAttachments[null]!);
      }

      // Group sorted members by validator index while preserving original order
      var membersByValidator = <int, List<MemberResult>>{};
      for (var member in sortedMembers) {
        membersByValidator
            .putIfAbsent(member.validatorIndex!, () => [])
            .add(member);
      }

      // Sort members within each validator group if needed
      for (var validatorIndex in membersByValidator.keys) {
        if (validatorFromAnnotation.alphabetizeSortedMembers) {
          membersByValidator[validatorIndex]!.sort(_compareAlphabetical);
        }
      }

      // Process validators in order
      var sortedValidatorIndices = membersByValidator.keys.toList()..sort();

      for (var validatorIndex in sortedValidatorIndices) {
        var membersWithValidator = membersByValidator[validatorIndex]!;

        for (var member in membersWithValidator) {
          sorted.add(member);

          // Add any unsorted members that follow this specific sorted member
          if (unsortedAttachments.containsKey(member)) {
            sorted.addAll(unsortedAttachments[member]!);
          }
        }
      }
    }

    // Calculate required spacing for each member
    var sortedWithSpacing = <MemberResult>[];
    for (var i = 0; i < sorted.length; i++) {
      var member = sorted[i];
      int? requiredLinesBefore;
      int? requiredLinesAfter;

      if (i > 0) {
        var prevIndex = sorted[i - 1].validatorIndex;
        var currIndex = member.validatorIndex;
        requiredLinesBefore = _calculateRequiredBlankLines(
          prevIndex,
          currIndex,
        );
      }

      if (i < sorted.length - 1) {
        var currIndex = member.validatorIndex;
        var nextIndex = sorted[i + 1].validatorIndex;
        requiredLinesAfter = _calculateRequiredBlankLines(
          currIndex,
          nextIndex,
        );
      }

      sortedWithSpacing.add(
        MemberResult(
          node: member.node,
          element: member.element,
          validatorIndex: member.validatorIndex,
          requiredLinesBefore: requiredLinesBefore,
          requiredLinesAfter: requiredLinesAfter,
        ),
      );
    }

    return sortedWithSpacing;
  }

  int? _calculateRequiredBlankLines(
    int? prevIndex,
    int? currIndex,
  ) {
    // Both sorted (matched validators)
    if (prevIndex != null &&
        currIndex != null &&
        prevIndex != -1 &&
        currIndex != -1) {
      if (prevIndex == currIndex) {
        // Same validator
        return validatorFromAnnotation.linesBetweenSameSortMembers;
      } else {
        // Different validators
        return validatorFromAnnotation.linesAroundSortedMembers;
      }
    }

    // Transition between sorted and unsorted
    if ((prevIndex == null || prevIndex == -1) !=
        (currIndex == null || currIndex == -1)) {
      return validatorFromAnnotation.linesAroundUnsortedMembers;
    }

    // Both unsorted
    if ((prevIndex == null || prevIndex == -1) &&
        (currIndex == null || currIndex == -1)) {
      // Use linesAroundUnsortedMembers for spacing between unsorted members
      // when:
      // 1. alphabetizeUnsortedMembers is enabled, OR
      // 2. There are no validators at all (all members are unsorted)
      if (validatorFromAnnotation.alphabetizeUnsortedMembers ||
          validatorFromAnnotation.validators.isEmpty) {
        return validatorFromAnnotation.linesAroundUnsortedMembers;
      }
    }

    // Default: no spacing requirement
    return null;
  }

  int _compareAlphabetical(MemberResult a, MemberResult b) {
    var nameA = _getMemberName(a.node, a.element);
    var nameB = _getMemberName(b.node, b.element);

    if (nameA == 'new' && nameB != 'new') return -1;
    if (nameA != 'new' && nameB == 'new') return 1;

    return nameA.toLowerCase().compareTo(nameB.toLowerCase());
  }
}

class _SortingMembersVisitor extends SimpleAstVisitor<void> {
  _SortingMembersVisitor(this.rule, this.context);

  final SortingMembersRule rule;
  final RuleContext context;

  bool _isSortingMembers(ElementAnnotation annotation) {
    var object = annotation.computeConstantValue();
    return object?.type?.element?.name == 'SortingMembers' &&
        object?.type?.element?.library?.uri ==
            .parse(
              'package:essential_lints_annotations/src/sorting_members.dart',
            );
  }

  void _handleAnnotatedNode(AnnotatedNode node) {
    for (var annotation in node.metadata) {
      var element = annotation.elementAnnotation;
      if (element == null) {
        continue;
      }
      if (_isSortingMembers(element)) {
        var validatorFromAnnotation = ValidatorFromAnnotation.fromAnnotation(
          element,
        );
        var visitor = _LintingMemberVisitor(
          rule,
          context,
          validatorFromAnnotation,
        );
        node.visitChildren(visitor);
      }
    }
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    _handleAnnotatedNode(node);
  }

  @override
  void visitMixinDeclaration(MixinDeclaration node) {
    _handleAnnotatedNode(node);
  }

  @override
  void visitExtensionDeclaration(ExtensionDeclaration node) {
    _handleAnnotatedNode(node);
  }

  @override
  void visitExtensionTypeDeclaration(ExtensionTypeDeclaration node) {
    _handleAnnotatedNode(node);
  }

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    _handleAnnotatedNode(node);
  }
}

/// {@template validator_from_annotation}
/// Configuration extracted from a SortingMembers annotation.
/// {@endtemplate}
class ValidatorFromAnnotation {
  ValidatorFromAnnotation._({
    required this.annotation,
    required this.validators,
    required this.linesBetweenSameSortMembers,
    required this.linesAroundSortedMembers,
    required this.linesAroundUnsortedMembers,
    required this.alphabetizeSortedMembers,
    required this.alphabetizeUnsortedMembers,
  });

  /// {@macro validator_from_annotation}
  factory ValidatorFromAnnotation.fromAnnotation(
    ElementAnnotation annotation,
  ) {
    var constantValue = annotation.computeConstantValue();
    if (constantValue == null) {
      throw ArgumentError(
        'Annotation does not have a constant value: $annotation',
      );
    }
    var declarations = constantValue.getField('declarations')?.toSetValue();
    var validators = <ListMemberTypeValidator>[];
    for (var declaration in {...?declarations}) {
      var list = <MemberTypeValidator>[];
      DartObject? current = declaration;
      String? typeName;
      While:
      do {
        typeName = current?.type?.element?.lookupName;
        switch (typeName) {
          case '_Field':
            list.add(const _FieldMemberTypeValidator());
            list.add(
              _ExpectedNamedMemberTypeValidator(
                expectedName: current?.getField('name')?.toSymbolValue() ?? '',
              ),
            );
            break While;
          case '_Constructor':
            list.add(const _ConstructorMemberTypeValidator());
            list.add(
              _ExpectedNamedMemberTypeValidator(
                expectedName: current?.getField('name')?.toSymbolValue() ?? '',
              ),
            );
            break While;
          case '_Method':
            list.add(const _MethodMemberTypeValidator());
            list.add(
              _ExpectedNamedMemberTypeValidator(
                expectedName: current?.getField('name')?.toSymbolValue() ?? '',
              ),
            );
            break While;
          case '_Getter':
            list.add(const _GetterMemberTypeValidator());
            list.add(
              _ExpectedNamedMemberTypeValidator(
                expectedName: current?.getField('name')?.toSymbolValue() ?? '',
              ),
            );
            break While;
          case '_Setter':
            list.add(const _SetterMemberTypeValidator());
            list.add(
              _ExpectedNamedMemberTypeValidator(
                expectedName: current?.getField('name')?.toSymbolValue() ?? '',
              ),
            );
            break While;
          case 'Fields':
            list.add(const _FieldMemberTypeValidator());
          case 'Constructors':
            list.add(const _ConstructorMemberTypeValidator());
          case 'Methods':
            list.add(const _MethodMemberTypeValidator());
          case 'Getters':
            list.add(const _GetterMemberTypeValidator());
          case 'Setters':
            list.add(const _SetterMemberTypeValidator());
          case 'FieldsGettersSetters':
            list.add(const _FieldsGettersSettersMemberTypeValidator());
          case 'GettersSetters':
            list.add(const _GettersSettersMemberTypeValidator());
          case '_Named':
            list.add(const _NamedMemberTypeValidator());
          case '_Abstract':
            list.add(const _AbstractMemberTypeValidator());
          case '_Const':
            list.add(const _ConstMemberTypeValidator());
          case '_External':
            list.add(const _ExternalMemberTypeValidator());
          case '_Factory':
            list.add(const _FactoryMemberTypeValidator());
          case '_Final':
            list.add(const _FinalMemberTypeValidator());
          case '_Initialized':
            list.add(const _InitializedMemberTypeValidator());
          case '_Late':
            list.add(const _LateMemberTypeValidator());
          case '_Nullable':
            list.add(const _NullableMemberTypeValidator());
          case '_Operator':
            list.add(const _OperatorMemberTypeValidator());
          case '_Overridden':
            list.add(const _OverriddenMemberTypeValidator());
          case '_Private':
            list.add(const _PrivateMemberTypeValidator());
          case '_Public':
            list.add(const _PublicMemberTypeValidator());
          case '_Redirecting':
            list.add(const _RedirectingMemberTypeValidator());
          case '_Static':
            list.add(const _StaticMemberTypeValidator());
          case '_Unnamed':
            list.add(const _UnnamedMemberTypeValidator());
          case '_Var':
            list.add(const _VarMemberTypeValidator());
          case '_Typed':
            list.add(const _TypedMemberTypeValidator());
          case '_Instance':
            list.add(const _InstanceMemberTypeValidator());
          case '_Dynamic':
            list.add(const _DynamicMemberTypeValidator());
          case '_New':
            list.add(const _NewMemberTypeValidator());
          default:
            _logger.severe('Unknown member type: $typeName');
            assert(false, 'Unknown member type: $typeName');
        }
        current =
            current?.constructorInvocation?.positionalArguments.firstOrNull;
      } while (current != null);
      validators.add(ListMemberTypeValidator(validators: list));
    }
    return ValidatorFromAnnotation._(
      annotation: annotation,
      validators: validators,
      linesBetweenSameSortMembers: constantValue
          .getField('linesBetweenSameSortMembers')
          ?.toIntValue(),
      linesAroundSortedMembers: constantValue
          .getField('linesAroundSortedMembers')
          ?.toIntValue(),
      linesAroundUnsortedMembers: constantValue
          .getField('linesAroundUnsortedMembers')
          ?.toIntValue(),
      alphabetizeSortedMembers:
          constantValue.getField('alphabetizeSortedMembers')?.toBoolValue() ??
          false,
      alphabetizeUnsortedMembers:
          constantValue.getField('alphabetizeUnsortedMembers')?.toBoolValue() ??
          false,
    );
  }

  /// The annotation from which this configuration was extracted.
  final ElementAnnotation annotation;

  /// The list of validators defining the sorting order.
  final List<ListMemberTypeValidator> validators;

  /// Required blank lines between members matched by the same validator.
  final int? linesBetweenSameSortMembers;

  /// Required blank lines when transitioning between different validators.
  final int? linesAroundSortedMembers;

  /// Required blank lines when transitioning between sorted and unsorted
  /// members.
  final int? linesAroundUnsortedMembers;

  /// Whether to alphabetize members matched by validators.
  final bool alphabetizeSortedMembers;

  /// Whether to alphabetize unsorted members.
  final bool alphabetizeUnsortedMembers;

  /// Finds the best matching validator index for the given member.
  ///
  /// Returns the index of the most specific validator that matches,
  /// or null if no validator matches.
  int? match(AstNode node, Element element) {
    var matches = <int>[];
    for (var i = 0; i < validators.length; i++) {
      if (validators[i].isValid(node, element)) {
        matches.add(i);
      }
    }
    if (matches.isEmpty) return null;

    // Find the best match
    // A match is better if it is more specific.
    // If A is more specific than B, A wins.
    // If neither is more specific than the other, the earlier one wins.

    var bestIndex = matches[0];
    var bestValidator = validators[bestIndex];

    for (var i = 1; i < matches.length; i++) {
      var currentIndex = matches[i];
      var currentValidator = validators[currentIndex];

      if (currentValidator.isMoreSpecificThan(bestValidator)) {
        bestIndex = currentIndex;
        bestValidator = currentValidator;
      }
    }
    return bestIndex;
  }
}

/// {@template member_type_validator}
/// Base class for validators that check if a member matches specific criteria.
/// {@endtemplate}
@immutable
sealed class MemberTypeValidator {
  /// {@macro member_type_validator}
  const MemberTypeValidator();

  // ignore: unused_element exhaustiveness
  factory MemberTypeValidator._(HelperEnum constant) {
    return switch (constant) {
      .abstract => const _AbstractMemberTypeValidator(),
      .const_ => const _ConstMemberTypeValidator(),
      .constructor => const _ConstructorMemberTypeValidator(),
      .dynamic => const _DynamicMemberTypeValidator(),
      .external => const _ExternalMemberTypeValidator(),
      .factory_ => const _FactoryMemberTypeValidator(),
      .field => const _FieldMemberTypeValidator(),
      .final_ => const _FinalMemberTypeValidator(),
      .getter => const _GetterMemberTypeValidator(),
      .initialized => const _InitializedMemberTypeValidator(),
      .instance => const _InstanceMemberTypeValidator(),
      .late => const _LateMemberTypeValidator(),
      .method => const _MethodMemberTypeValidator(),
      .named => const _NamedMemberTypeValidator(),
      .new_ => const _NewMemberTypeValidator(),
      .nullable => const _NullableMemberTypeValidator(),
      .operator => const _OperatorMemberTypeValidator(),
      .overridden => const _OverriddenMemberTypeValidator(),
      .private => const _PrivateMemberTypeValidator(),
      .public => const _PublicMemberTypeValidator(),
      .redirecting => const _RedirectingMemberTypeValidator(),
      .setter => const _SetterMemberTypeValidator(),
      .static => const _StaticMemberTypeValidator(),
      .typed => const _TypedMemberTypeValidator(),
      .unnamed => const _UnnamedMemberTypeValidator(),
      .var_ => const _VarMemberTypeValidator(),
      .constructors => const _ConstructorMemberTypeValidator(),
      .fields => const _FieldMemberTypeValidator(),
      .fieldsGettersSetters => const _FieldsGettersSettersMemberTypeValidator(),
      .getters => const _GetterMemberTypeValidator(),
      .gettersSetters => const _GettersSettersMemberTypeValidator(),
      .methods => const _MethodMemberTypeValidator(),
      .setters => const _SetterMemberTypeValidator(),
    };
  }

  /// Returns true if the member matches this validator.
  bool isValid(AstNode member, Element element);
}

/// {@template list_member_type_validator}
/// A validator that checks if a member matches all validators in a list.
/// {@endtemplate}
class ListMemberTypeValidator extends MemberTypeValidator {
  /// {@macro list_member_type_validator}
  const ListMemberTypeValidator({
    required this.validators,
  });

  /// The list of validators that must all match.
  final List<MemberTypeValidator> validators;

  @override
  bool isValid(AstNode member, Element element) {
    for (var validator in validators) {
      if (!validator.isValid(member, element)) {
        return false;
      }
    }
    return true;
  }

  /// Returns true if this validator is more specific than [other].
  /// A validator is more specific if it has all validators from [other]
  /// plus additional ones (making it more restrictive).
  bool isMoreSpecificThan(ListMemberTypeValidator other) {
    // If this has fewer or equal validators, it can't be more specific
    if (validators.length <= other.validators.length) return false;

    // Check if all validators from other exist in this list
    for (var otherValidator in other.validators.reversed) {
      if (validators.none((v) => v == otherValidator)) return false;
    }

    return true;
  }
}

class _FieldMemberTypeValidator extends MemberTypeValidator {
  const _FieldMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) => element is FieldElement;
}

class _FieldsGettersSettersMemberTypeValidator extends MemberTypeValidator {
  const _FieldsGettersSettersMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) =>
      element is FieldElement ||
      element is GetterElement ||
      element is SetterElement;
}

class _ConstructorMemberTypeValidator extends MemberTypeValidator {
  const _ConstructorMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) =>
      element is ConstructorElement;
}

class _DynamicMemberTypeValidator extends MemberTypeValidator {
  const _DynamicMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (element is FieldElement) {
      return member.thisOrAncestorOfType<FieldDeclaration>()?.fields.type ==
          null;
    }
    if (element is MethodElement) {
      return member.thisOrAncestorOfType<MethodDeclaration>()?.returnType ==
          null;
    }
    return false;
  }
}

class _MethodMemberTypeValidator extends MemberTypeValidator {
  const _MethodMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) => element is MethodElement;
}

class _GetterMemberTypeValidator extends MemberTypeValidator {
  const _GetterMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) => element is GetterElement;
}

class _GettersSettersMemberTypeValidator extends MemberTypeValidator {
  const _GettersSettersMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) =>
      element is GetterElement || element is SetterElement;
}

class _SetterMemberTypeValidator extends MemberTypeValidator {
  const _SetterMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) => element is SetterElement;
}

class _ExpectedNamedMemberTypeValidator extends MemberTypeValidator {
  const _ExpectedNamedMemberTypeValidator({
    required this.expectedName,
  });

  final String expectedName;

  @override
  bool isValid(AstNode member, Element element) =>
      element.name == expectedName ||
      (element is ConstructorElement &&
          element.name == 'new' &&
          expectedName.isEmpty);
}

class _AbstractMemberTypeValidator extends MemberTypeValidator {
  const _AbstractMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (element is ConstructorElement) {
      return element.isAbstract;
    }
    if (element is FieldElement) {
      return element.isAbstract;
    }
    if (element is MethodElement) {
      return element.isAbstract;
    }
    return false;
  }
}

class _ConstMemberTypeValidator extends MemberTypeValidator {
  const _ConstMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (element is FieldElement) {
      return element.isConst;
    }
    if (element is ConstructorElement) {
      return element.isConst;
    }
    return false;
  }
}

class _ExternalMemberTypeValidator extends MemberTypeValidator {
  const _ExternalMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (element is FieldElement) {
      return element.isExternal;
    }
    if (element is MethodElement) {
      return element.isExternal;
    }
    if (element is ConstructorElement) {
      return element.isExternal;
    }
    return false;
  }
}

class _FactoryMemberTypeValidator extends MemberTypeValidator {
  const _FactoryMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (element is ConstructorElement) {
      return element.isFactory;
    }
    return false;
  }
}

class _FinalMemberTypeValidator extends MemberTypeValidator {
  const _FinalMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (element is FieldElement) {
      return element.isFinal;
    }
    return false;
  }
}

class _InitializedMemberTypeValidator extends MemberTypeValidator {
  const _InitializedMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (member is! FieldDeclaration) {
      return false;
    }
    var fieldDeclaration = member.thisOrAncestorOfType<FieldDeclaration>();
    if (fieldDeclaration == null) {
      return false;
    }
    for (var variable in fieldDeclaration.fields.variables) {
      if (variable.declaredFragment?.element == element &&
          variable.initializer != null) {
        return true;
      }
    }
    return false;
  }
}

class _InstanceMemberTypeValidator extends MemberTypeValidator {
  const _InstanceMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (element is FieldElement) {
      return !element.isStatic;
    }
    if (element is MethodElement) {
      return !element.isStatic;
    }
    return false;
  }
}

class _LateMemberTypeValidator extends MemberTypeValidator {
  const _LateMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (member is! FieldDeclaration) {
      return false;
    }
    var fieldDeclaration = member.thisOrAncestorOfType<FieldDeclaration>();
    if (fieldDeclaration == null) {
      return false;
    }
    return fieldDeclaration.fields.isLate;
  }
}

class _NamedMemberTypeValidator extends MemberTypeValidator {
  const _NamedMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (member is! ConstructorDeclaration) {
      return false;
    }
    return member.name != null;
  }
}

class _NewMemberTypeValidator extends MemberTypeValidator {
  const _NewMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    var enclosingElement = element.enclosingElement;
    if (enclosingElement is InterfaceElement) {
      for (var name in enclosingElement.inheritedMembers.keys) {
        if (name.name == element.lookupName) {
          return false;
        }
      }
      return true;
    }
    if (enclosingElement is ExtensionElement) {
      return true;
    }
    return false;
  }
}

class _NullableMemberTypeValidator extends MemberTypeValidator {
  const _NullableMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    DartType? type;
    if (element is FieldElement) {
      type = element.type;
    } else if (element is MethodElement) {
      type = element.returnType;
    } else if (element is PropertyAccessorElement) {
      type = element.returnType;
    }
    return type?.nullabilitySuffix == NullabilitySuffix.question;
  }
}

class _OperatorMemberTypeValidator extends MemberTypeValidator {
  const _OperatorMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (member is! MethodDeclaration) {
      return false;
    }
    return member.isOperator;
  }
}

class _OverriddenMemberTypeValidator extends MemberTypeValidator {
  const _OverriddenMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    var enclosingElement = element.enclosingElement;
    if (enclosingElement is InterfaceElement) {
      for (var name in enclosingElement.inheritedMembers.keys) {
        if (name.name == element.lookupName) {
          return true;
        }
      }
    }
    return false;
  }
}

class _PrivateMemberTypeValidator extends MemberTypeValidator {
  const _PrivateMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) => element.isPrivate;
}

class _PublicMemberTypeValidator extends MemberTypeValidator {
  const _PublicMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) => element.isPublic;
}

class _RedirectingMemberTypeValidator extends MemberTypeValidator {
  const _RedirectingMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (member is! ConstructorDeclaration) {
      return false;
    }
    return member.redirectedConstructor != null;
  }
}

class _StaticMemberTypeValidator extends MemberTypeValidator {
  const _StaticMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (element is FieldElement) {
      return element.isStatic;
    }
    if (element is MethodElement) {
      return element.isStatic;
    }
    return false;
  }
}

class _TypedMemberTypeValidator extends MemberTypeValidator {
  const _TypedMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (element is FieldElement) {
      return member.thisOrAncestorOfType<FieldDeclaration>()?.fields.type !=
          null;
    }
    if (element is MethodElement) {
      return member.thisOrAncestorOfType<MethodDeclaration>()?.returnType !=
          null;
    }
    return false;
  }
}

class _UnnamedMemberTypeValidator extends MemberTypeValidator {
  const _UnnamedMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (member is! ConstructorDeclaration) {
      return false;
    }
    return member.name == null;
  }
}

class _VarMemberTypeValidator extends MemberTypeValidator {
  const _VarMemberTypeValidator();

  @override
  bool isValid(AstNode member, Element element) {
    if (element is FieldElement) {
      var keyword = member
          .thisOrAncestorOfType<FieldDeclaration>()
          ?.fields
          .keyword;
      return keyword?.keyword == Keyword.VAR;
    }
    return false;
  }
}
