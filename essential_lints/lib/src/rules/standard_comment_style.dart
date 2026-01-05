// This code is based on an idea from dart_code_metrics package see
// https://github.com/dart-code-checker/dart-code-metrics/blob/master/lib/src/analyzers/lint_analyzer/rules/rules_list/format_comment/format_comment_rule.dart

import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'rule.dart';

/// {@template standard_comment_style}
/// A rule that checks for proper formatting of comments.
/// {@endtemplate}
class StandardCommentStyleRule extends LintRule {
  /// {@macro standard_comment_style}
  StandardCommentStyleRule() : super(.standardCommentStyle);

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    var visitor = _StandardCommentStyleVisitor(this, context);
    registry.addCompilationUnit(this, visitor);
  }
}

class _StandardCommentStyleVisitor extends SimpleAstVisitor<void> {
  _StandardCommentStyleVisitor(this.rule, this.context);

  static const _punctuation = {'.', '!', '?', ':', ';'};
  static final _startingComment = RegExp(r'^((///?)|/\*)');
  static final _endOfComment = RegExp(r'(\*/)$');
  static final _nonWhitespace = RegExp(r'^\S');
  static final _noLetter = RegExp('^[^A-Za-z]');
  static final _noUppercaseLetter = RegExp('^[^A-Z]');
  static final _codeBlockDelimitor = RegExp('^```');

  final StandardCommentStyleRule rule;

  final RuleContext context;

  @override
  void visitCompilationUnit(CompilationUnit node) {
    _gatherComments(node.beginToken);
    super.visitCompilationUnit(node);
  }

  void _gatherComments(Token? token) {
    var list = <CommentToken>[];
    while (token != null && (!token.isEof || token.precedingComments != null)) {
      Token? commentToken = token.precedingComments;
      while (commentToken is CommentToken) {
        list.add(commentToken);
        token = commentToken = commentToken.next;
      }
      _handleCommentList(list);
      list.clear();
      if (token?.next == token) {
        break;
      }
      token = token?.next;
    }
  }

  void _handleCommentList(List<CommentToken> list) {
    var textComment = <(String, CommentToken)>[];
    for (var comment in list) {
      var commentText = comment.lexeme
          .replaceFirst(_startingComment, '')
          .trimRight();
      if (comment.type == .MULTI_LINE_COMMENT) {
        commentText = commentText.replaceFirst(_endOfComment, '').trimRight();
      }
      if (commentText.isNotEmpty && commentText.startsWith(_nonWhitespace)) {
        rule.reportAtToken(comment);
        return;
      }
      textComment.add((commentText.trim(), comment));
    }
    var commentText = textComment.map((e) => e.$1).join('\n');
    if (commentText.isEmpty) {
      return;
    }
    if (commentText.trim().startsWith(_noLetter)) {
      return;
    }
    for (var (:String paragraph, :CommentToken firstComment)
        in textComment.paragraphs) {
      if (paragraph.isEmpty) {
        continue;
      }
      if (paragraph.startsWith(_noUppercaseLetter)) {
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
        rule.reportAtToken(firstComment);
      }
    }
  }
}

extension on List<(String, CommentToken)> {
  List<({String paragraph, CommentToken firstComment})> get paragraphs {
    var result = <({String paragraph, CommentToken firstComment})>[];
    var buffer = StringBuffer();
    CommentToken? firstComment;
    var foundCodeBlock = false;

    void flushParagraph() {
      if (buffer.isNotEmpty && firstComment != null) {
        result.add((
          paragraph: buffer.toString(),
          firstComment: firstComment!,
        ));
      }
      buffer.clear();
      firstComment = null;
    }

    for (var (text, comment) in this) {
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
        flushParagraph();
        foundCodeBlock = !foundCodeBlock;
        if (!foundCodeBlock) {
          continue;
        }
      }
      if (foundCodeBlock) {
        /// Skip warnings inside code blocks.
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
