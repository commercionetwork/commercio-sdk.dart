// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_did_power_up.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestDidPowerUp _$RequestDidPowerUpFromJson(Map<String, dynamic> json) {
  return RequestDidPowerUp(
    claimantDid: json['claimant'] as String,
    amount: (json['amount'] as List<dynamic>)
        .map((e) => StdCoin.fromJson(e as Map<String, dynamic>))
        .toList(),
    powerUpProof: json['proof'] as String,
    uuid: json['id'] as String,
    encryptionKey: json['proof_key'] as String,
  );
}

Map<String, dynamic> _$RequestDidPowerUpToJson(RequestDidPowerUp instance) =>
    <String, dynamic>{
      'claimant': instance.claimantDid,
      'amount': instance.amount.map((e) => e.toJson()).toList(),
      'proof': instance.powerUpProof,
      'id': instance.uuid,
      'proof_key': instance.encryptionKey,
    };
