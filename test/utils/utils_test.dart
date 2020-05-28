import 'package:commerciosdk/export.dart';
import 'package:test/test.dart';

void main() {
  group('Function "calculateDefaultFee" returns expected values;', () {
    const defaultAmount = 100;
    const defaultDenom = "commercio";
    const defaultGas = 200;
    test('if the messages number is greater than 1, the fees are multiplied.',
        () {
      final msgsAmount = 2;

      final expectedFee = StdFee(
        amount: [
          StdCoin(
            denom: defaultDenom,
            amount: (defaultAmount * msgsAmount).toString(),
          ),
        ],
        gas: (defaultGas * msgsAmount).toString(),
      );

      final fee = calculateDefaultFee(
        msgsAmount,
        defaultAmount,
        defaultDenom,
        defaultGas,
      );

      expect(fee.toJson(), expectedFee.toJson());
    });

    test('if the message is only one, the fees are the default ones.', () {
      final msgsAmount = 1;

      final expectedFee = StdFee(
        amount: [
          StdCoin(
            denom: defaultDenom,
            amount: defaultAmount.toString(),
          ),
        ],
        gas: defaultGas.toString(),
      );

      final fee = calculateDefaultFee(
        msgsAmount,
        defaultAmount,
        defaultDenom,
        defaultGas,
      );

      expect(fee.toJson(), expectedFee.toJson());
    });
  });
}
