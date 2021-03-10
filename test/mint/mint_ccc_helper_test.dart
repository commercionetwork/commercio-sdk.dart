import 'package:commerciosdk/export.dart';
import 'package:commerciosdk/mint/export.dart';
import 'package:test/test.dart';

void main() {
  group('Functions of "MintCccHelper" class', () {
    final networkInfo = NetworkInfo(
      bech32Hrp: 'did:com:',
      lcdUrl: Uri.parse(''),
    );
    const mnemonicString =
        'dash ordinary anxiety zone slot rail flavor tortoise guilt divert pet sound ostrich increase resist short ship lift town ice split payment round apology';
    final mnemonic = mnemonicString.split(' ');
    final wallet = Wallet.derive(mnemonic, networkInfo);

    test('if "fromWallet()" returns a well-formed "MintCcc" object', () {
      const depositAmount = [StdCoin(denom: 'uccc', amount: '10')];
      final expectedMintCcc = MintCcc(
        depositAmount: depositAmount,
        signerDid: wallet.bech32Address,
        id: 'f18e7aac-6659-43bd-be26-9842b80d3c29',
      );

      final mintCcc = MintCccHelper.fromWallet(
        wallet: wallet,
        amount: depositAmount,
        id: 'f18e7aac-6659-43bd-be26-9842b80d3c29',
      );

      expect(
        mintCcc.toJson(),
        expectedMintCcc.toJson(),
      );
    });
  });
}
