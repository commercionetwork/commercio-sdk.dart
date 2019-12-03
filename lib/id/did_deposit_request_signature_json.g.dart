// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_deposit_request_signature_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DidDepositRequestSignatureJson _$DidDepositRequestSignatureJsonFromJson(
    Map<String, dynamic> json) {
  return DidDepositRequestSignatureJson(
    recipient: json['recipient'] as String,
    timeStamp: json['timestamp'] as String,
  );
}

Map<String, dynamic> _$DidDepositRequestSignatureJsonToJson(
        DidDepositRequestSignatureJson instance) =>
    <String, dynamic>{
      'recipient': instance.recipient,
      'timestamp': instance.timeStamp,
    };
