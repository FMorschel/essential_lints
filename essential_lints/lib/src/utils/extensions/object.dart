/// Extension to safely cast an Object to a specific type T, returning null if
/// the cast is not possible.
extension WhenType on Object? {
  /// Safely casts the object to type T, or returns null if the object is not
  /// of type T.
  T? whenTypeOrNull<T>() => this is T ? this as T : null;
}
