import 'package:commerciosdk/export.dart';

/// Represents the transaction message that must be used
/// when wanting to deposit into reward pool.
class MsgRewardPoolDeposit extends StdMsg {
  final RewardPoolDeposit rewardPoolDeposit;

  MsgRewardPoolDeposit({
    required this.rewardPoolDeposit,
  }) : super(
          type: 'commercio/MsgDepositIntoLiquidityPool',
          value: <String, String>{},
        );

  @override
  Map<String, dynamic> get value => rewardPoolDeposit.toJson();
}
