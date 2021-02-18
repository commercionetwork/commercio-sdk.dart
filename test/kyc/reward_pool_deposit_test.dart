import 'package:commerciosdk/export.dart';
import 'package:test/test.dart';

void main() {
  group('Functions of "RewardPoolDepositHelper" class', () {
    final networkInfo = NetworkInfo(bech32Hrp: 'did:com:', lcdUrl: '');
    const mnemonicString =
        'dash ordinary anxiety zone slot rail flavor tortoise guilt divert pet sound ostrich increase resist short ship lift town ice split payment round apology';
    final mnemonic = mnemonicString.split(' ');
    final wallet = Wallet.derive(mnemonic, networkInfo);

    test('if "fromWallet()" retruns a well-formed "RewardPoolDeposit" object',
        () {
      const depositAmount = [StdCoin(denom: 'uccc', amount: '10')];

      final expectedRewardPoolDeposit = RewardPoolDeposit(
        depositAmount: depositAmount,
        depositorDid: wallet.bech32Address,
      );

      final rewardPoolDeposit = RewardPoolDepositHelper.fromWallet(
          wallet: wallet, amount: depositAmount);

      expect(
        rewardPoolDeposit.toJson(),
        expectedRewardPoolDeposit.toJson(),
      );
    });
  });
}
