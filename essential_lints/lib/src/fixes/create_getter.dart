import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/range_factory.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../rules/analysis_rule.dart';
import 'essential_lint_fixes.dart';
import 'fix.dart';

/// {@template create_getter_fix}
/// A fix that creates a getter for a missing getter reference.
/// {@endtemplate}
@staticLoggerEnforcement
class CreateGetterFix extends CorrectionProducerLogger with WarningFix {
  /// {@macro create_getter_fix}
  CreateGetterFix({required super.context}) : super(_logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'CreateGetterFix',
  );

  static final _memberPattern = RegExp(r"('(([$]|\w)+)')");

  @override
  CorrectionApplicability get applicability => .acrossSingleFile;

  @override
  EssentialLintWarningFixes get fix => .createGetter;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    logger.info('CreateGetterFix.compute() started');
    var diagnostic = this.diagnostic;
    if (diagnostic == null) {
      logger.finer('Diagnostic is null, returning');
      return;
    }
    logger.fine('Diagnostic found');
    var getterName = _memberPattern.firstMatch(
      diagnostic.correctionMessage ?? '',
    );
    if (getterName == null) {
      logger.finer('No getter name found in correction message, returning');
      return;
    }
    logger.fine('Getter name pattern matched');
    var name = getterName.group(2);
    if (name == null) {
      logger.finer('Extracted getter name is null, returning');
      return;
    }
    logger.fine('Extracted getter name: $name');
    var node = this.node.thisOrAncestorOfType<ClassDeclaration>();
    if (node == null) {
      logger.finer('No ClassDeclaration ancestor found, returning');
      return;
    }
    logger.fine('Found ClassDeclaration node');
    if (node.declaredFragment!.element case ClassElement(:var getters)) {
      if (getters.any((g) => g.name == name)) {
        logger.fine('Getter $name already exists in class, returning');
        return;
      }
    }
    logger.fine('Getter $name does not exist, proceeding with creation');
    await builder.addDartFileEdit(file, (builder) {
      var offset = node.lastMemberOrNull?.end ?? node.closeBraceToken?.offset;
      var needsNewLine =
          offset == node.openBraceToken?.end || node.lastMemberOrNull != null;
      var needsClosingBrace = offset == null;
      logger.finer(
        'Insertion point calculated: offset=$offset, '
        'needsNewLine=$needsNewLine, needsClosingBrace=$needsClosingBrace',
      );
      if (offset == null) {
        if (node.body case EmptyClassBody body) {
          offset = body.semicolon.end;
          logger.finer(
            'EmptyClassBody found, replacing semicolon with opening brace',
          );
          builder.addReplacement(range.token(body.semicolon), (builder) {
            builder.write(' {');
          });
        } else {
          logger.finer('Cannot determine insertion offset, returning');
          assert(false, 'Cannot determine where to insert the getter.');
          return;
        }
      }
      builder.addInsertion(offset, (builder) {
        if (needsNewLine) {
          builder.writeln();
        }
        logger.finer('Writing getter declaration for $name');
        builder
          ..write(utils.oneIndent)
          ..writeGetterDeclaration(
            name,
            returnType: typeProvider.listType(typeProvider.objectQuestionType),
            bodyWriter: () => builder.write('=> [];'),
          );
        if (offset == node.closeBraceToken?.offset) {
          builder.writeln();
        }
        if (needsClosingBrace) {
          builder
            ..writeln()
            ..write('}');
        }
      });
    });
    logger.info('CreateGetterFix.compute() completed successfully');
  }
}

extension on AstNode {
  /// Returns the last member of the class, or `null` if there are no members.
  ClassMember? get lastMemberOrNull => switch (body) {
    BlockClassBody(:var members) => members.lastOrNull,
    EmptyClassBody() => null,
    _ => null,
  };

  ClassBody? get body {
    var self = this;
    if (self is ClassDeclaration) {
      return self.body;
    }
    return null;
  }

  Token? get openBraceToken {
    var self = this;
    if (self is ClassDeclaration) {
      var body = self.body;
      return switch (body) {
        BlockClassBody(:var leftBracket) => leftBracket,
        EmptyClassBody() => null,
      };
    }
    return null;
  }

  Token? get closeBraceToken {
    var self = this;
    if (self is ClassDeclaration) {
      var body = self.body;
      return switch (body) {
        BlockClassBody(:var rightBracket) => rightBracket,
        EmptyClassBody() => null,
      };
    }
    return null;
  }
}
