import 'package:commerciosdk/export.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'deposit_reward_pool.g.dart';

/// Contains the data related to a deposit reward pool.
@JsonSerializable(explicitToJson: true)
class DepositRewardPool extends Equatable {
  @JsonKey(name: 'amount')
  final List<StdCoin> depositAmount;

  @JsonKey(name: 'depositor')
  final String depositorDid;

  DepositRewardPool({
    @required this.depositAmount,
    @required this.depositorDid,
  })  : assert(depositAmount != null),
        assert(depositorDid != null);

  @override
  List<Object> get props => throw [depositAmount, depositorDid];

  factory DepositRewardPool.fromJson(Map<String, dynamic> json) =>
      _$DepositRewardPoolFromJson(json);

  Map<String, dynamic> toJson() => _$DepositRewardPoolToJson(this);
}
