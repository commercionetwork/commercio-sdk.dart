// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_deposit_request_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DidDepositRequestPayload _$DidDepositRequestPayloadFromJson(
    Map<String, dynamic> json) {
  return DidDepositRequestPayload(
    recipient: json['recipient'] as String,
    timeStamp: json['timestamp'] as String,
    signature: json['signature'] as String,
  );
}

Map<String, dynamic> _$DidDepositRequestPayloadToJson(
        DidDepositRequestPayload instance) =>
    <String, dynamic>{
      'recipient': instance.recipient,
      'timestamp': instance.timeStamp,
      'signature': instance.signature,
    };
