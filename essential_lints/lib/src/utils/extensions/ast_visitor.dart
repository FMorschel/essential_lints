import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

/// An extension that simplifies the usage of [TimedAstVisitor].
extension AstVisitorExt<T> on AstVisitor<T> {
  /// A getter that wraps this visitor in a [TimedAstVisitor] if it isn't one.
  TimedAstVisitor<T> get timed {
    if (this case TimedAstVisitor<T> self) return self;
    return TimedAstVisitor(this);
  }
}
