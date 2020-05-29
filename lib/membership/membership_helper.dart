import 'package:commerciosdk/export.dart';
import 'package:sacco/sacco.dart';

/// Allows to easily perform CommercioMEMBERSHIP related operations.
class MembershipHelper {
  /// Sends a new transaction in order to invite the given [userDid].
  /// Optionally [fee] and broadcasting [mode] parameters can be specified.
  static Future<TransactionResult> inviteUser(
    String userDid,
    Wallet wallet, {
    StdFee fee,
    BroadcastingMode mode,
  }) async {
    final InviteUser inviteUser = InviteUserHelper.fromWallet(
      wallet,
      userDid,
    );
    final msg = MsgInviteUser(
      inviteUser: inviteUser,
    );
    return TxHelper.createSignAndSendTx(
      [msg],
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
        .map(
          (inviteUser) => MsgInviteUser(inviteUser: inviteUser),
        )
        .toList();
    return TxHelper.createSignAndSendTx(
      msgs,
      wallet,
      fee: fee,
      mode: mode,
    );
  }

  /// Buys the membership with the given [membershipType].
  /// Optionally [fee] and broadcasting [mode] parameters can be specified.
  static Future<TransactionResult> buyMembership(
    MembershipType membershipType,
    Wallet wallet, {
    StdFee fee,
    BroadcastingMode mode,
  }) async {
    final BuyMembership buyMembership = BuyMembershipHelper.fromWallet(
      wallet,
      membershipType,
    );
    final msg = MsgBuyMembership(
      buyMembership: buyMembership,
    );
    return TxHelper.createSignAndSendTx(
      [msg],
      wallet,
      fee: fee,
      mode: mode,
    );
  }

  /// Buys the membership with the given [buyMemberships] memberships list.
  /// Optionally [fee] and broadcasting [mode] parameters can be specified.
  static Future<TransactionResult> buyMembershipsList(
    List<BuyMembership> buyMemberships,
    Wallet wallet, {
    StdFee fee,
    BroadcastingMode mode,
  }) async {
    final msgs = buyMemberships
        .map(
          (buyMembership) => MsgBuyMembership(buyMembership: buyMembership),
        )
        .toList();
    return TxHelper.createSignAndSendTx(
      msgs,
      wallet,
      fee: fee,
      mode: mode,
    );
  }
}
