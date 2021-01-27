// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_reward_pool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepositRewardPool _$DepositRewardPoolFromJson(Map<String, dynamic> json) {
  return DepositRewardPool(
    depositAmount: (json['amount'] as List)
        ?.map((e) =>
            e == null ? null : StdCoin.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    depositorDid: json['depositor'] as String,
  );
}

Map<String, dynamic> _$DepositRewardPoolToJson(DepositRewardPool instance) =>
    <String, dynamic>{
      'amount': instance.depositAmount?.map((e) => e?.toJson())?.toList(),
      'depositor': instance.depositorDid,
    };
