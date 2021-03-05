import 'package:commerciosdk/export.dart';
import 'package:commerciosdk/mint/export.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Functions of "BurnCccHelper" class', () {
    const networkInfo = NetworkInfo(bech32Hrp: 'did:com:', lcdUrl: '');
    const mnemonicString =
        'dash ordinary anxiety zone slot rail flavor tortoise guilt divert pet sound ostrich increase resist short ship lift town ice split payment round apology';
    final mnemonic = mnemonicString.split(' ');
    final wallet = Wallet.derive(mnemonic, networkInfo);

    test('if "fromwallet()" returns a well-formed "BurnCcc" object', () {
      const amount = StdCoin(denom: 'uccc', amount: '10');
      final id = Uuid().v4();

      final expectedBurnCcc = BurnCcc(
        signerDid: wallet.bech32Address,
        amount: amount,
        id: id,
      );

      final burnCcc = BurnCccHelper.fromWallet(
        amount: amount,
        id: id,
        wallet: wallet,
      );

      expect(
        burnCcc.toJson(),
        expectedBurnCcc.toJson(),
      );
    });
  });
}
