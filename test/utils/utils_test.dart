import 'package:commerciosdk/export.dart';
import 'package:test/test.dart';

void main() {
  group('Function "calculateDefaultFee" returns expected values;', () {
    const defaultAmount = 100;
    const defaultDenom = "commercio";
    const defaultGas = 200;
    test('if the messages number is greater than 1, the fees are multiplied.',
        () {
      final msgsNumber = 2;

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
}
