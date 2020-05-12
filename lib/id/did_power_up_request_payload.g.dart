// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_power_up_request_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DidPowerUpRequestPayload _$DidPowerUpRequestPayloadFromJson(
    Map<String, dynamic> json) {
  return DidPowerUpRequestPayload(
    senderDid: json['sender_did'] as String,
    pairwiseDid: json['pairwise_did'] as String,
    timestamp: json['timestamp'] as int,
    signature: json['signature'] as String,
  );
}

Map<String, dynamic> _$DidPowerUpRequestPayloadToJson(
        DidPowerUpRequestPayload instance) =>
    <String, dynamic>{
      'sender_did': instance.senderDid,
      'pairwise_did': instance.pairwiseDid,
      'timestamp': instance.timestamp,
      'signature': instance.signature,
    };
