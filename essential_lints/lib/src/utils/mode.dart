/// Enumeration representing the current mode of operation.
enum Mode {
  /// Release mode.
  release,

  /// Profile mode.
  profile,

  /// Debug mode.
  debug,
  ;

  /// The current mode of operation.
  static const Mode current = bool.fromEnvironment('dart.vm.product')
      ? release
      : (bool.fromEnvironment('dart.vm.profile') ? profile : debug);

  /// Whether the current mode is release mode.
  bool get isRelease => this == release;

  /// Whether the current mode is profile mode.
  bool get isProfile => this == profile;

  /// Whether the current mode is debug mode.
  bool get isDebug => this == debug;

  @override
  String toString() =>
      '${switch (this) {
        release => 'Release',
        profile => 'Profile',
        debug => 'Debug',
      }} Mode';
}
