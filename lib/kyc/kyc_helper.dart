import 'package:commerciosdk/export.dart';
import 'package:sacco/sacco.dart';

/// Allows to easily perform the Commercio Kyc module related transactions.
class KycHelper {
  /// Buys the membership with the given [buyMemberships] memberships list
  /// and tsp [wallet].
  /// Optionally [fee] and broadcasting [mode] parameters can be specified.
  static Future<TransactionResult> buyMembershipsList(
    List<BuyMembership> buyMemberships,
    Wallet wallet, {
    StdFee? fee,
    BroadcastingMode? mode,
  }) async {
    final msgs = buyMemberships
        .map((buyMembership) => MsgBuyMembership(buyMembership: buyMembership))
        .toList();
    return TxHelper.createSignAndSendTx(
      msgs,
      wallet,
      fee: fee,
      mode: mode,
    );
  }

  /// Invite new users with the given [inviteUsers] users list
  /// and [wallet].
  /// Optionally [fee] and broadcasting [mode] parameters can be specified.
  static Future<TransactionResult> inviteUsersList(
    List<InviteUser> inviteUsers,
    Wallet wallet, {
    StdFee? fee,
    BroadcastingMode? mode,
  }) async {
    final msgs = inviteUsers
        .map((inviteUser) => MsgInviteUser(inviteUser: inviteUser))
        .toList();
    return TxHelper.createSignAndSendTx(
      msgs,
      wallet,
      fee: fee,
      mode: mode,
    );
  }

  /// Deposit a list of [rewardPoolDeposits] deposits into reward pool
  /// with the depositor [wallet].
  /// Optionally [fee] and broadcasting [mode] parameters can be specified.
  static Future<TransactionResult> rewardPoolDepositsList(
    List<RewardPoolDeposit> rewardPoolDeposits,
    Wallet wallet, {
    StdFee? fee,
    BroadcastingMode? mode,
  }) async {
    final msgs = rewardPoolDeposits
        .map((rewardPoolDeposit) =>
            MsgRewardPoolDeposit(rewardPoolDeposit: rewardPoolDeposit))
        .toList();
    return TxHelper.createSignAndSendTx(
      msgs,
      wallet,
      fee: fee,
      mode: mode,
    );
  }
}
