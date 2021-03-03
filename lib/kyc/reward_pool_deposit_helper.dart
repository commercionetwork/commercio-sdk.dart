import 'package:commerciosdk/export.dart';

/// Allows to easily create a DepositRewardPool and perform common related operations
class RewardPoolDepositHelper {
  /// Creates a RewardPoolDeposit from the given [wallet],
  /// and deposit [amount].
  static RewardPoolDeposit fromWallet({
    required Wallet wallet,
    required List<StdCoin> amount,
  }) {
    return RewardPoolDeposit(
      depositAmount: amount,
      depositorDid: wallet.bech32Address,
    );
  }
}
