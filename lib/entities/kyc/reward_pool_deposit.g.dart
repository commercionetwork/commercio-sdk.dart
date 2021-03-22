// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_pool_deposit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RewardPoolDeposit _$RewardPoolDepositFromJson(Map<String, dynamic> json) {
  return RewardPoolDeposit(
    depositAmount: (json['amount'] as List<dynamic>)
        .map((e) => StdCoin.fromJson(e as Map<String, dynamic>))
        .toList(),
    depositorDid: json['depositor'] as String,
  );
}

Map<String, dynamic> _$RewardPoolDepositToJson(RewardPoolDeposit instance) =>
    <String, dynamic>{
      'amount': instance.depositAmount.map((e) => e.toJson()).toList(),
      'depositor': instance.depositorDid,
    };
