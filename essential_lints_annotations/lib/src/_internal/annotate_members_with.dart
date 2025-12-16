import 'package:meta/meta_meta.dart';

/// {@template annotate_members_with}
/// Annotation to indicate that members should be annotated with specific
/// annotations.
/// {@endtemplate}
@Target({
  .classType,
  .mixinType,
  .extensionType,
  .enumType,
})
class AnnotateMembersWith {
  /// {@macro annotate_members_with}
  const AnnotateMembersWith(
    this.annotation, {
    this.onlyConcrete = false,
    this.onlyPublic = false,
  });

  /// The annotation to be used for annotating members.
  final Object annotation;

  /// Whether to annotate only concrete members.
  final bool onlyConcrete;

  /// Whether to annotate only public members.
  final bool onlyPublic;
}
