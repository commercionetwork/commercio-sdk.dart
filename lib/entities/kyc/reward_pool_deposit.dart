import 'package:commerciosdk/export.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reward_pool_deposit.g.dart';

/// Contains the data related to a reward pool deposit .
@JsonSerializable(explicitToJson: true)
class RewardPoolDeposit extends Equatable {
  @JsonKey(name: 'amount')
  final List<StdCoin> depositAmount;

  @JsonKey(name: 'depositor')
  final String depositorDid;

  const RewardPoolDeposit({
    required this.depositAmount,
    required this.depositorDid,
  });

  @override
  List<Object> get props => [depositAmount, depositorDid];

  factory RewardPoolDeposit.fromJson(Map<String, dynamic> json) =>
      _$RewardPoolDepositFromJson(json);

  Map<String, dynamic> toJson() => _$RewardPoolDepositToJson(this);
}
