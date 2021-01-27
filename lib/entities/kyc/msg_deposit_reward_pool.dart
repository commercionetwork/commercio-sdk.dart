import 'package:commerciosdk/export.dart';
import 'package:meta/meta.dart';

class MsgDepositRewardPool extends StdMsg {
  final DepositRewardPool depositRewardPool;

  MsgDepositRewardPool({
    @required this.depositRewardPool,
  })  : assert(depositRewardPool != null),
        super(
          type: 'commercio/MsgDepositIntoLiquidityPool',
          value: <String, String>{},
        );

  @override
  Map<String, dynamic> get value => depositRewardPool.toJson();
}
