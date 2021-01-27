import 'package:commerciosdk/export.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'reward_pool_deposit.g.dart';

/// Contains the data related to a reward pool deposit .
@JsonSerializable(explicitToJson: true)
class RewardPoolDeposit extends Equatable {
  @JsonKey(name: 'amount')
  final List<StdCoin> depositAmount;

  @JsonKey(name: 'depositor')
  final String depositorDid;

  RewardPoolDeposit({
    @required this.depositAmount,
    @required this.depositorDid,
  })  : assert(depositAmount != null),
        assert(depositorDid != null);

  @override
  List<Object> get props => throw [depositAmount, depositorDid];

  factory RewardPoolDeposit.fromJson(Map<String, dynamic> json) =>
      _$RewardPoolDepositFromJson(json);

  Map<String, dynamic> toJson() => _$RewardPoolDepositToJson(this);
}
