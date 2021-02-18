import 'package:commerciosdk/export.dart';
import 'package:meta/meta.dart';

/// Allows to easily create an InviteUser and perform common related operations
class InviteUserHelper {
  /// Creates an InviteUser from the given [wallet] and [recipientDid].
  static InviteUser fromWallet({
    @required Wallet wallet,
    @required String recipientDid,
  }) {
    return InviteUser(
      recipientDid: recipientDid,
      senderDid: wallet.bech32Address,
    );
  }
}
