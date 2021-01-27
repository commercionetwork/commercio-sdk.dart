import 'package:commerciosdk/export.dart';
import 'package:commerciosdk/mint/export.dart';
import 'package:test/test.dart';

void main() {
  group('Functions of "MintCccHelper" class', () {
    final networkInfo = NetworkInfo(bech32Hrp: "did:com:", lcdUrl: "");
    final mnemonicString =
        "dash ordinary anxiety zone slot rail flavor tortoise guilt divert pet sound ostrich increase resist short ship lift town ice split payment round apology";
    final mnemonic = mnemonicString.split(" ");
    final wallet = Wallet.derive(mnemonic, networkInfo);

    test('"fromWallet() returns a well-formed "MintCcc" object', () {
      final depositAmount = [StdCoin(denom: 'uccc', amount: '10')];
      final expectedMintCcc = MintCcc(
        depositAmount: depositAmount,
        signerDid: wallet.bech32Address,
      );

      final mintCcc = MintCccHelper.fromWallet(
        wallet: wallet,
        amount: depositAmount,
      );

      expect(
        mintCcc.toJson(),
        expectedMintCcc.toJson(),
      );
    });
  });
}
