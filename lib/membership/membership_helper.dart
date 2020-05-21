import 'package:commerciosdk/export.dart';
import 'package:sacco/sacco.dart';

/// Allows to easily perform CommercioMEMBERSHIP related operations.
class MembershipHelper {
  /// Sends a new transaction in order to invite the given [userDid].
  static Future<TransactionResult> inviteUser(
    String userDid,
    Wallet wallet, {
    StdFee fee,
    String mode,
  }) async {
    final msg = MsgInviteUser(
      recipientDid: userDid,
      senderDid: wallet.bech32Address,
    );
    return TxHelper.createSignAndSendTx(
      [msg],
      wallet,
      fee: fee,
      mode: mode,
    );
  }

  /// Buys the membership with the given [membershipType].
  static Future<TransactionResult> buyMembership(
    MembershipType membershipType,
    Wallet wallet, {
    StdFee fee,
    String mode,
  }) async {
    final msg = MsgBuyMembership(
      membershipType: membershipType,
      buyerDid: wallet.bech32Address,
    );
    return TxHelper.createSignAndSendTx(
      [msg],
      wallet,
      fee: fee,
      mode: mode,
    );
  }
}
