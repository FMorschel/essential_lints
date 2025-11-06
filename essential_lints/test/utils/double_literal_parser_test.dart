import 'package:essential_lints/src/utils/double_literal_parser.dart';
import 'package:test/test.dart';

void main() {
  group('DoubleLiteralParser', () {
    group('valid formats', () {
      test('parses simple decimal', () {
        final parser = DoubleLiteralParser('1.5');
        expect(parser.hasIntegerPart, isTrue);
        expect(parser.hasDecimalPoint, isTrue);
        expect(parser.hasExponent, isFalse);
        expect(parser.hasLeadingZeros, isFalse);
        expect(parser.hasTrailingZeros, isFalse);
        expect(parser.relevantNumber, '1.5');
      });

      test('parses zero decimal', () {
        final parser = DoubleLiteralParser('0.0');
        expect(parser.hasIntegerPart, isTrue);
        expect(parser.hasDecimalPoint, isTrue);
        expect(parser.hasExponent, isFalse);
        expect(parser.hasLeadingZeros, isFalse);
        expect(parser.hasTrailingZeros, isFalse);
        expect(parser.relevantNumber, '0.0');
      });

      test('parses decimal without integer part', () {
        final parser = DoubleLiteralParser('.5');
        expect(parser.hasIntegerPart, isFalse);
        expect(parser.hasDecimalPoint, isTrue);
        expect(parser.hasExponent, isFalse);
        expect(parser.hasLeadingZeros, isFalse);
        expect(parser.hasTrailingZeros, isFalse);
        expect(parser.relevantNumber, '.5');
      });

      test('parses exponent only', () {
        final parser = DoubleLiteralParser('1e5');
        expect(parser.hasIntegerPart, isTrue);
        expect(parser.hasDecimalPoint, isFalse);
        expect(parser.hasExponent, isTrue);
        expect(parser.hasLeadingZeros, isFalse);
        expect(parser.hasExponentLeadingZeros, isFalse);
        expect(parser.relevantNumber, '1');
        expect(parser.exponent, 'e');
        expect(parser.exponentNumber, '5');
      });

      test('parses decimal with exponent', () {
        final parser = DoubleLiteralParser('1.5e10');
        expect(parser.hasIntegerPart, isTrue);
        expect(parser.hasDecimalPoint, isTrue);
        expect(parser.hasExponent, isTrue);
        expect(parser.hasLeadingZeros, isFalse);
        expect(parser.hasTrailingZeros, isFalse);
        expect(parser.hasExponentLeadingZeros, isFalse);
        expect(parser.relevantNumber, '1.5');
        expect(parser.exponent, 'e');
        expect(parser.exponentNumber, '10');
      });

      test('parses decimal without integer and with exponent', () {
        final parser = DoubleLiteralParser('.5e2');
        expect(parser.hasIntegerPart, isFalse);
        expect(parser.hasDecimalPoint, isTrue);
        expect(parser.hasExponent, isTrue);
        expect(parser.relevantNumber, '.5');
        expect(parser.exponent, 'e');
      });

      test('parses exponent with positive sign', () {
        final parser = DoubleLiteralParser('1.0e+5');
        expect(parser.hasExponent, isTrue);
        expect(parser.exponent, 'e+');
        expect(parser.exponentNumber, '5');
      });

      test('parses exponent with negative sign', () {
        final parser = DoubleLiteralParser('1.0e-5');
        expect(parser.hasExponent, isTrue);
        expect(parser.exponent, 'e-');
        expect(parser.exponentNumber, '5');
      });

      test('parses uppercase E', () {
        final parser = DoubleLiteralParser('1.0E5');
        expect(parser.hasExponent, isTrue);
        expect(parser.exponent, 'E');
      });
    });

    group('leading zeros detection', () {
      test('detects leading zeros before integer', () {
        final parser = DoubleLiteralParser('01.5');
        expect(parser.hasLeadingZeros, isTrue);
        expect(parser.leadingZeros, '0');
        expect(parser.hasIntegerPart, isTrue);
        expect(parser.relevantNumber, '1.5');
      });

      test('detects multiple leading zeros', () {
        final parser = DoubleLiteralParser('001.5');
        expect(parser.hasLeadingZeros, isTrue);
        expect(parser.leadingZeros, '00');
        expect(parser.relevantNumber, '1.5');
      });

      test('no leading zeros for single zero', () {
        final parser = DoubleLiteralParser('0.5');
        expect(parser.hasLeadingZeros, isFalse);
        expect(parser.leadingZeros, '');
      });

      test('detects leading zeros with exponent', () {
        final parser = DoubleLiteralParser('01.5e10');
        expect(parser.hasLeadingZeros, isTrue);
        expect(parser.leadingZeros, '0');
      });
    });

    group('trailing zeros detection', () {
      test('detects single trailing zero', () {
        final parser = DoubleLiteralParser('1.50');
        expect(parser.hasTrailingZeros, isTrue);
        expect(parser.trailingZeros, '0');
      });

      test('detects multiple trailing zeros', () {
        final parser = DoubleLiteralParser('1.5000');
        expect(parser.hasTrailingZeros, isTrue);
        expect(parser.trailingZeros, '000');
      });

      test('no trailing zeros for single zero fractional', () {
        final parser = DoubleLiteralParser('1.0');
        expect(parser.hasTrailingZeros, isFalse);
        expect(parser.trailingZeros, '');
      });

      test('detects trailing zeros with exponent', () {
        final parser = DoubleLiteralParser('1.500e10');
        expect(parser.hasTrailingZeros, isTrue);
        expect(parser.trailingZeros, '00');
      });

      test('no trailing zeros when ending with non-zero', () {
        final parser = DoubleLiteralParser('1.123');
        expect(parser.hasTrailingZeros, isFalse);
      });
    });

    group('exponent leading zeros detection', () {
      test('detects exponent leading zero', () {
        final parser = DoubleLiteralParser('1.0e05');
        expect(parser.hasExponentLeadingZeros, isTrue);
        expect(parser.exponentLeadingZeros, '0');
      });

      test('detects multiple exponent leading zeros', () {
        final parser = DoubleLiteralParser('1.0e001');
        expect(parser.hasExponentLeadingZeros, isTrue);
        expect(parser.exponentLeadingZeros, '00');
      });

      test('no exponent leading zeros', () {
        final parser = DoubleLiteralParser('1.0e5');
        expect(parser.hasExponentLeadingZeros, isFalse);
        expect(parser.exponentLeadingZeros, '');
      });

      test('detects exponent leading zeros with sign', () {
        final parser = DoubleLiteralParser('1.0e+01');
        expect(parser.hasExponentLeadingZeros, isTrue);
        expect(parser.exponentLeadingZeros, '0');
      });
    });

    group('combined cases', () {
      test('parses all problematic components', () {
        final parser = DoubleLiteralParser('001.5000e005');
        expect(parser.hasLeadingZeros, isTrue);
        expect(parser.leadingZeros, '00');
        expect(parser.hasTrailingZeros, isTrue);
        expect(parser.trailingZeros, '000');
        expect(parser.hasExponentLeadingZeros, isTrue);
        expect(parser.exponentLeadingZeros, '00');
        expect(parser.exponentNumber, '5');
      });

      test('parses complex valid number', () {
        final parser = DoubleLiteralParser('123.456e789');
        expect(parser.hasLeadingZeros, isFalse);
        expect(parser.hasTrailingZeros, isFalse);
        expect(parser.hasExponentLeadingZeros, isFalse);
        expect(parser.relevantNumber, '123.456');
        expect(parser.exponent, 'e');
      });

      test('parses zero with exponent', () {
        final parser = DoubleLiteralParser('0.0e1');
        expect(parser.hasIntegerPart, isTrue);
        expect(parser.hasDecimalPoint, isTrue);
        expect(parser.hasExponent, isTrue);
        expect(parser.hasLeadingZeros, isFalse);
        expect(parser.hasTrailingZeros, isFalse);
      });
    });

    group('edge cases', () {
      test('parses large integer part', () {
        final parser = DoubleLiteralParser('999999.1');
        expect(parser.hasIntegerPart, isTrue);
        expect(parser.relevantNumber, '999999.1');
      });

      test('parses large fractional part', () {
        final parser = DoubleLiteralParser('1.999999');
        expect(parser.hasDecimalPoint, isTrue);
        expect(parser.relevantNumber, '1.999999');
      });

      test('parses large exponent', () {
        final parser = DoubleLiteralParser('1.0e999');
        expect(parser.hasExponent, isTrue);
        expect(parser.exponentNumber, '999');
      });

      test('parses minimum valid decimal', () {
        final parser = DoubleLiteralParser('.0');
        expect(parser.hasIntegerPart, isFalse);
        expect(parser.hasDecimalPoint, isTrue);
        expect(parser.relevantNumber, '.0');
      });
    });

    group('regex validation', () {
      test('validates proper double literal formats', () {
        // These should all parse successfully
        expect(() => DoubleLiteralParser('1.0'), returnsNormally);
        expect(() => DoubleLiteralParser('1e5'), returnsNormally);
        expect(() => DoubleLiteralParser('1.0e5'), returnsNormally);
        expect(() => DoubleLiteralParser('.5'), returnsNormally);
        expect(() => DoubleLiteralParser('0.0'), returnsNormally);
      });

      test('validates formats with issues but still valid syntax', () {
        // These have formatting issues but are syntactically valid
        expect(() => DoubleLiteralParser('01.0'), returnsNormally);
        expect(() => DoubleLiteralParser('1.00'), returnsNormally);
        expect(() => DoubleLiteralParser('1.0e01'), returnsNormally);
      });
    });
    group('isValidDouble', () {
      test('valid double with decimal point', () {
        final parser = DoubleLiteralParser('1.0');
        expect(parser.isValidDouble, isTrue);
      });

      test('valid double with exponent', () {
        final parser = DoubleLiteralParser('1e5');
        expect(parser.isValidDouble, isTrue);
      });

      test('valid double with both decimal and exponent', () {
        final parser = DoubleLiteralParser('1.0e5');
        expect(parser.isValidDouble, isTrue);
      });

      test('invalid double without decimal or exponent', () {
        final parser = DoubleLiteralParser('10');
        expect(parser.isValidDouble, isFalse);
      });
    });
    group('parts', () {
      test('parses all parts correctly', () {
        final parser = DoubleLiteralParser('00123.45600E-00789');
        expect(parser.leadingZeros, '00');
        expect(parser.relevantNumber, '123.456');
        expect(parser.trailingZeros, '00');
        expect(parser.exponent, 'E-');
        expect(parser.exponentLeadingZeros, '00');
        expect(parser.exponentNumber, '789');
      });
    });
  });
}
