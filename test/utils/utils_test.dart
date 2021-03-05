import 'package:commerciosdk/export.dart';
import 'package:test/test.dart';

void main() {
  const str100CharsLen =
      'xRqpfSGKVF8Qor1HcKhy2gwmUw0fSZ25IXp7y2DdJctxTyqsiP4YruHIWjY2Qkhe8aZxag9Smi3NwMrFs5CPYzkUF3P4sCOYmlRI';

  group('Function "calculateDefaultFee" returns expected values;', () {
    const defaultAmount = 100;
    const defaultDenom = 'commercio';
    const defaultGas = 200;

    test('if the messages number is greater than 1, the fees are multiplied.',
        () {
      const msgsNumber = 2;

      final expectedFee = StdFee(
        amount: [
          StdCoin(
            denom: defaultDenom,
            amount: (defaultAmount * msgsNumber).toString(),
          ),
        ],
        gas: (defaultGas * msgsNumber).toString(),
      );

      final fee = calculateDefaultFee(
        msgsNumber: msgsNumber,
        fee: defaultAmount,
        denom: defaultDenom,
        gas: defaultGas,
      );

      expect(fee.toJson(), expectedFee.toJson());
    });
  });

  group('matchUuidv4', () {
    test('Invalid strings should return false', () {
      // Empty
      expect(matchUuidv4(''), isFalse);

      // UUID v1
      expect(matchUuidv4('690f3bf4-5fbf-11eb-ae93-0242ac130002'), isFalse);

      // UUID v3, v5
      expect(matchUuidv4('6ba7b810-9dad-11d1-80b4-00c04fd430c8'), isFalse);

      // UUID null
      expect(matchUuidv4('00000000-0000-0000-0000-000000000000'), isFalse);
    });

    test('Valid UUID v4 should return true', () {
      expect(matchUuidv4('e21fd7bf-fd58-40ca-be2d-f50d29189276'), isTrue);
    });
  });

  group('matchBech32Format', () {
    test('Null value should throw ArgumentError', () {
      expect(() => matchBech32Format(null), throwsArgumentError);
    });

    test('String lenght not between 8 and 90 should return false', () {
      expect(matchBech32Format(''), isFalse);
      expect(matchBech32Format(str100CharsLen), isFalse);
    });

    test('Bech32 with "b", "i" or "o" after the 1 should return false', () {
      expect(matchBech32Format('did:com:1b'), isFalse);
      expect(matchBech32Format('did:com:1i'), isFalse);
      expect(matchBech32Format('did:com:1o'), isFalse);
    });

    test('Bech32 without the "1" as separator should return false', () {
      expect(matchBech32Format('did:com:acdefg'), isFalse);
    });

    test('Bech32 without the hrp part before "1" should return false', () {
      expect(matchBech32Format('1acdefg'), isFalse);
    });

    test('Valid Bech32 should return true', () {
      expect(matchBech32Format('did:com:1acdefg'), isTrue);
      expect(
        matchBech32Format('did:com:1mfddzjvr8vpeqdtm6fuay2nvnecuk9qa8usqq5'),
        isTrue,
      );
      expect(matchBech32Format('cosmos1acdefg'), isTrue);
    });
  });
}
