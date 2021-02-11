import 'package:commerciosdk/export.dart';
import 'package:test/test.dart';

void main() {
  group('Functions of "InviteUserHelper" class;', () {
    final networkInfo = NetworkInfo(bech32Hrp: "did:com:", lcdUrl: "");
    final mnemonicString =
        "dash ordinary anxiety zone slot rail flavor tortoise guilt divert pet sound ostrich increase resist short ship lift town ice split payment round apology";
    final mnemonic = mnemonicString.split(" ");
    final wallet = Wallet.derive(mnemonic, networkInfo);

    test('if "fromWallet()" returns a well-formed "InviteUser" object.', () {
      final recipientDid = 'did:com:id';

      final expectedInviteUser = InviteUser(
        recipientDid: recipientDid,
        senderDid: wallet.bech32Address,
      );

      final inviteUser = InviteUserHelper.fromWallet(
        wallet: wallet,
        recipientDid: recipientDid,
      );

      expect(inviteUser.toJson(), expectedInviteUser.toJson());
    });
  });
}
