import 'package:commerciosdk/export.dart';

/// Allows to easily create an InviteUser and perform common related operations
class InviteUserHelper {
  /// Creates an InviteUser from the given [wallet] and [recipientDid].
  static InviteUser fromWallet(Wallet wallet, String recipientDid) {
    return InviteUser(
      recipientDid: recipientDid,
      senderDid: wallet.bech32Address,
    );
  }
}
