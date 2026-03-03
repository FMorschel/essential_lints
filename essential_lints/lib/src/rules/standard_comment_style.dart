// This code is based on an idea from dart_code_metrics package see
// https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/format_comment/format_comment_rule.dart

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:logging/logging.dart';

import '../plugin.dart';
import '../utils/base_visitor.dart';
import 'analysis_rule.dart';
import 'rule.dart';

/// {@template standard_comment_style}
/// A rule that checks for proper formatting of comments.
/// {@endtemplate}
@staticLoggerEnforcement
class StandardCommentStyleRule extends LintRule<StandardCommentStyleRule> {
  /// {@macro standard_comment_style}
  StandardCommentStyleRule() : super(.standardCommentStyle, _logger);

  static final Logger _logger = EssentialLintsPlugin.newLogger(
    'StandardCommentStyleRule',
  );

  @override
  Visitor<StandardCommentStyleRule, void> visitorFor(RuleContext context) =>
      _StandardCommentStyleVisitor(this, context);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = visitorFor(context);
    registry.addCompilationUnit(this, visitor);
  }
}

class _StandardCommentStyleVisitor
    extends BaseVisitor<StandardCommentStyleRule> {
  _StandardCommentStyleVisitor(super.rule, super.context);

  static const _punctuation = {'.', '!', '?', ':', ';'};
  static final _startingComment = RegExp(r'^((///?)|/\*)');
  static final _endOfComment = RegExp(r'(\*/)$');
  static final _nonWhitespace = RegExp(r'^\S');
  static final _noLetter = RegExp('^[^A-Za-z]');
  static final _noUppercaseLetter = RegExp('^[^A-Z]');
  static final _mdCompatible = RegExp(r'(#|>|-|\*|>\s)');
  static final _dartdocCompatible = RegExp(r'\{@.*\}');
  static final _codeBlockDelimitor = RegExp('^```');
  static final _ignoreForFile = RegExp('^ignore_for_file:');
  static final _ignore = RegExp('^ignore:');

  @override
  void visitCompilationUnit(CompilationUnit node) {
    logger.info('visitCompilationUnit() started');
    _gatherComments(node.beginToken);
    logger.info('visitCompilationUnit() completed');
    super.visitCompilationUnit(node);
  }

  void _gatherComments(Token? token) {
    logger.info('_gatherComments() started');
    var list = <CommentToken>[];
    while (token != null && (!token.isEof || token.precedingComments != null)) {
      var current = token;
      Token? commentToken = token.precedingComments;
      while (commentToken is CommentToken) {
        list.add(commentToken);
        token = commentToken = commentToken.next ?? current;
      }
      if (list.isNotEmpty) {
        logger.finer('Found ${list.length} comment token(s), handling group');
        _handleCommentList(list);
        list.clear();
      }
      if (token?.next == token) {
        break;
      }
      token = token?.next;
    }
    logger.info('_gatherComments() completed');
  }

  void _handleCommentList(List<CommentToken> list) {
    logger.info('_handleCommentList() started with ${list.length} comment(s)');
    var textComment = <(String, CommentToken)>[];
    for (var comment in list) {
      var commentText = comment.lexeme
          .replaceFirst(_startingComment, '')
          .trimRight();
      logger.finer('Processing comment token: ${commentText.length} chars');
      if (_ignore.hasMatch(commentText.trim()) ||
          _ignoreForFile.hasMatch(commentText.trim())) {
        logger.finer(
          'Ignoring comment due to ignore directive: '
          '${commentText.trim().split("\n").first}',
        );
        continue;
      }
      if (comment.type == .MULTI_LINE_COMMENT) {
        commentText = commentText.replaceFirst(_endOfComment, '').trimRight();
      }
      if (commentText.isNotEmpty && commentText.startsWith(_nonWhitespace)) {
        logger.fine('Reporting non-leading-whitespace comment at token');
        rule.reportAtToken(comment);
        return;
      }
      textComment.add((commentText.trim(), comment));
    }
    logger.finer('Collected ${textComment.length} text comment(s)');
    var commentText = textComment.map((e) => e.$1).join('\n');
    if (commentText.isEmpty) {
      logger.finer('Combined comment text empty, skipping');
      return;
    }
    if (commentText.trim().startsWith(_noLetter)) {
      logger.finer('Comment starts with no letter, skipping');
      return;
    }
    for (var (:String paragraph, :CommentToken firstComment)
        in textComment.paragraphs) {
      logger.finer('Processing paragraph: ${paragraph.length} chars');
      if (paragraph.startsWith(_dartdocCompatible)) {
        paragraph = paragraph
            .substring(_dartdocCompatible.firstMatch(paragraph)!.end)
            .trim();
      }
      if (paragraph.isEmpty) {
        logger.finer('Paragraph empty after dartdoc strip, skipping');
        continue;
      }
      if (paragraph.startsWith(_mdCompatible)) {
        logger.finer(
          'Paragraph starts with markdown-compatible token, skipping',
        );
        continue;
      }
      if (paragraph.startsWith(_noUppercaseLetter)) {
        logger.fine('Reporting paragraph starting without uppercase letter');
        rule.reportAtToken(firstComment);
        continue;
      }
      var hasPunctuation = false;
      for (var punctuation in _punctuation) {
        if (paragraph.endsWith(punctuation)) {
          hasPunctuation = true;
          continue;
        }
      }
      if (!hasPunctuation) {
        logger.fine('Reporting paragraph missing end punctuation');
        rule.reportAtToken(firstComment);
      }
    }
  }
}

extension on List<(String, CommentToken)> {
  List<({String paragraph, CommentToken firstComment})> get paragraphs {
    StandardCommentStyleRule._logger.finer(
      'Extracting paragraphs from $length comment parts',
    );
    var result = <({String paragraph, CommentToken firstComment})>[];
    var buffer = StringBuffer();
    CommentToken? firstComment;
    var foundCodeBlock = false;

    void flushParagraph() {
      if (buffer.isNotEmpty && firstComment != null) {
        result.add((paragraph: buffer.toString(), firstComment: firstComment!));
      }
      buffer.clear();
      firstComment = null;
    }

    for (var (text, comment) in this) {
      StandardCommentStyleRule._logger.finer(
        'Paragraph builder processing comment fragment length ${text.length}',
      );
      if (text.trim().isEmpty) {
        flushParagraph();
        continue;
      }
      if (buffer.isNotEmpty) {
        buffer.write(' ');
      }
      if (text.trim().startsWith(
        _StandardCommentStyleVisitor._codeBlockDelimitor,
      )) {
        StandardCommentStyleRule._logger.finer('Found code block delimiter');
        flushParagraph();
        foundCodeBlock = !foundCodeBlock;
        if (!foundCodeBlock) {
          continue;
        }
      }
      if (foundCodeBlock) {
        /// Skip warnings inside code blocks.
        StandardCommentStyleRule._logger.finer(
          'Inside code block, skipping fragment',
        );
        continue;
      }
      buffer.write(text);
      firstComment ??= comment;
    }
    if (buffer.isNotEmpty && firstComment != null) {
      result.add((paragraph: buffer.toString(), firstComment: firstComment!));
    }
    return result;
  }
}
