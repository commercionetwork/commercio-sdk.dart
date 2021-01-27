import 'package:commerciosdk/export.dart';
import 'package:meta/meta.dart';

/// Allows to easily create a DepositRewardPool and perform common related operations
class DepositRewardPoolHelper {
  /// Creates a DepositRewardPool from the given [wallet],
  /// and deposit [amount].
  static DepositRewardPool fromWallet({
    @required Wallet wallet,
    @required List<StdCoin> amount,
  }) {
    return DepositRewardPool(
      depositAmount: amount,
      depositorDid: wallet.bech32Address,
    );
  }
}
