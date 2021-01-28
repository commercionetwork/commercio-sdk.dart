import 'package:commerciosdk/export.dart';
import 'package:sacco/sacco.dart';

class KycHelper {
  /// Buys the membership with the given [buyMemberships] memberships list.
  /// Optionally [fee] and broadcasting [mode] parameters can be specified.
  static Future<TransactionResult> buyMembershipsList(
    List<BuyMembership> buyMemberships,
    Wallet wallet, {
    StdFee fee,
    BroadcastingMode mode,
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

  /// Sends a new transaction in order to invite the given [inviteUsers] users list.
  /// Optionally [fee] and broadcasting [mode] parameters can be specified.
  static Future<TransactionResult> inviteUsersList(
    List<InviteUser> inviteUsers,
    Wallet wallet, {
    StdFee fee,
    BroadcastingMode mode,
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

  /// Sends a new transaction in order to deposit
  /// into reward pool a list of [rewardPoolDeposits].
  /// Optionally [fee] and broadcasting [mode] parameters can be specified.
  static Future<TransactionResult> rewardPoolDepositsList(
    List<RewardPoolDeposit> rewardPoolDeposits,
    Wallet wallet, {
    StdFee fee,
    BroadcastingMode mode,
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
