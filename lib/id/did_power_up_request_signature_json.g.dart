// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_power_up_request_signature_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DidPowerUpRequestSignatureJson _$DidPowerUpRequestSignatureJsonFromJson(
    Map<String, dynamic> json) {
  return DidPowerUpRequestSignatureJson(
    pairwiseDid: json['pairwise_did'] as String,
    timestamp: json['timestamp'] as String,
  );
}

Map<String, dynamic> _$DidPowerUpRequestSignatureJsonToJson(
        DidPowerUpRequestSignatureJson instance) =>
    <String, dynamic>{
      'pairwise_did': instance.pairwiseDid,
      'timestamp': instance.timestamp,
    };
