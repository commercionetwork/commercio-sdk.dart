import 'package:commerciosdk/export.dart';
import 'package:test/test.dart';

void main() {
  group('Functions of "BuyMembershipHelper" class;', () {
    final networkInfo = NetworkInfo(
      bech32Hrp: 'did:com:',
      lcdUrl: Uri.parse(''),
    );
    const mnemonicString =
        'dash ordinary anxiety zone slot rail flavor tortoise guilt divert pet sound ostrich increase resist short ship lift town ice split payment round apology';
    final mnemonic = mnemonicString.split(' ');
    final wallet = Wallet.derive(mnemonic, networkInfo);

    test('if "fromWallet()" returns a well-formed "BuyMembership" object.', () {
      final membershipType = MembershipType.BLACK.value;
      const tsp = 'did:com:id';

      final expectedBuyMembership = BuyMembership(
        membershipType: membershipType,
        buyerDid: wallet.bech32Address,
        tsp: tsp,
      );

      final buyMembership = BuyMembershipHelper.fromWallet(
        wallet: wallet,
        membershipType: MembershipType.BLACK,
        tsp: tsp,
      );

      expect(buyMembership.toJson(), expectedBuyMembership.toJson());
    });
  });
}
