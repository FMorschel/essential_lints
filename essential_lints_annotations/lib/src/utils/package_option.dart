/// {@template package_option}
/// Options for identifying the package inheritance of an annotation.
///
/// This is used to determine whether an annotation should be inherited by
/// subtypes only in the same package, or also in other packages.
/// {@endtemplate}
enum PackageOption {
  /// Only subtypes in the same package should inherit the annotation.
  private,

  /// Subtypes in any package should inherit the annotation.
  inherit;
}
