/// {@template double_literal_parser}
/// A parser for double literals that extracts components such as
/// leading zeros, integer part, fractional part, and exponent.
/// {@endtemplate}
class DoubleLiteralParser {
  /// {@macro double_literal_parser}
  DoubleLiteralParser(String lexeme)
    : assert(
        _regExp.hasMatch(lexeme),
        'Invalid double literal format: $lexeme',
      ),
      _match = _regExp.firstMatch(lexeme)!;

  static const _leadingZeroGroup = 1;
  static const _relevantNumberGroup = 3;
  static const _integerPartGroup = 4;
  static const _decimalPointGroup = 6;
  static const _trailingZeroGroup = 9;
  static const _exponentGroup = 11;
  static const _exponentLeadingZeroGroup = 14;
  static const _exponentNumberGroup = 15;

  static final _regExp = RegExp(
    r'^(0+(?=[0-9]))?(((0|([1-9][0-9]*))?(\.(([0-9]*[1-9])|0))?)(0+)?)(((e|E)(\+|-)?)(0+)?([0-9]+))?$',
  );

  final Match _match;

  /// Whether the double literal has leading zeros before the integer part.
  bool get hasLeadingZeros => _match.group(_leadingZeroGroup) != null;

  /// Whether the double literal has trailing zeros after the decimal point.
  bool get hasTrailingZeros => _match.group(_trailingZeroGroup) != null;

  /// Whether the double literal has leading zeros in the exponent part.
  bool get hasExponentLeadingZeros =>
      _match.group(_exponentLeadingZeroGroup) != null;

  /// Whether the double literal has an integer part.
  bool get hasIntegerPart => _match.group(_integerPartGroup) != null;

  /// Whether the double literal has a decimal point.
  bool get hasDecimalPoint => _match.group(_decimalPointGroup) != null;

  /// Whether the double literal has an exponent part.
  bool get hasExponent => _match.group(_exponentGroup) != null;

  /// Whether the double literal is a valid double format.
  bool get isValidDouble => hasDecimalPoint || hasExponent;

  /// The leading zeros before the integer part.
  String get leadingZeros => _match.group(_leadingZeroGroup) ?? '';

  /// The relevant number part (integer and fractional) of the double literal,
  /// excluding leading zeros and trailing zeros.
  String get relevantNumber => _match.group(_relevantNumberGroup) ?? '';

  /// The trailing zeros after the decimal point.
  String get trailingZeros => _match.group(_trailingZeroGroup) ?? '';

  /// The exponent part of the double literal, including the 'e' or 'E'.
  String get exponent => _match.group(_exponentGroup) ?? '';

  /// The leading zeros in the exponent part.
  String get exponentLeadingZeros =>
      _match.group(_exponentLeadingZeroGroup) ?? '';

  /// The numeric part of the exponent.
  String get exponentNumber => _match.group(_exponentNumberGroup) ?? '';
}
