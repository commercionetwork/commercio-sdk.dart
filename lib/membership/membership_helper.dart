import 'package:commerciosdk/export.dart';
import 'package:sacco/sacco.dart';

/// Allows to easily perform CommercioMEMBERSHIP related operations.
class MembershipHelper {
  /// Sends a new transaction in order to invite the given [userDid].
  static Future<TransactionResult> inviteUser(
    String userDid,
    Wallet wallet,
  ) async {
    final msg = MsgInviteUser(
      recipientDid: userDid,
      senderDid: wallet.bech32Address,
    );
    return TxHelper.createSignAndSendTx([msg], wallet);
  }

  /// Buys the membership with the given [membershipType].
  static Future<TransactionResult> buyMembership(
    String membershipType,
    Wallet wallet,
  ) async {
    if (!validateMembership(membershipType)) {
      throw UnsupportedError("Unrecognized membership type: ${membershipType}");
    }

    final msg = MsgBuyMembership(
      membershipType: membershipType,
      buyerDid: wallet.bech32Address,
    );
    return TxHelper.createSignAndSendTx([msg], wallet);
  }
}
