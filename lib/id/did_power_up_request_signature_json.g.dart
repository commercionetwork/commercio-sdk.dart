// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_power_up_request_signature_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DidPowerUpRequestSignatureJson _$DidPowerUpRequestSignatureJsonFromJson(
    Map<String, dynamic> json) {
  return DidPowerUpRequestSignatureJson(
    senderDid: json['sender_did'] as String,
    pairwiseDid: json['pairwise_did'] as String,
    timestamp: json['timestamp'] as String,
  );
}

Map<String, dynamic> _$DidPowerUpRequestSignatureJsonToJson(
        DidPowerUpRequestSignatureJson instance) =>
    <String, dynamic>{
      'sender_did': instance.senderDid,
      'pairwise_did': instance.pairwiseDid,
      'timestamp': instance.timestamp,
    };
