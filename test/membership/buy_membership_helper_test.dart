import 'package:commerciosdk/export.dart';
import 'package:test/test.dart';

void main() {
  group('Functions of "BuyMembershipHelper" class;', () {
    final networkInfo = NetworkInfo(bech32Hrp: "did:com:", lcdUrl: "");
    final mnemonicString =
        "dash ordinary anxiety zone slot rail flavor tortoise guilt divert pet sound ostrich increase resist short ship lift town ice split payment round apology";
    final mnemonic = mnemonicString.split(" ");
    final wallet = Wallet.derive(mnemonic, networkInfo);
    final membershipType = MembershipType.BLACK.value;

    test('"fromWallet()" returns a well-formed "BuyMembership" object.', () {
      final expectedBuyMembership = BuyMembership(
          membershipType: membershipType, buyerDid: wallet.bech32Address);

      final buyMembership =
          BuyMembershipHelper.fromWallet(wallet, MembershipType.BLACK);

      expect(buyMembership.toJson(), expectedBuyMembership.toJson());
    });
  });
}
