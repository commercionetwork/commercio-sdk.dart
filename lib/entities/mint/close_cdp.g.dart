// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'close_cdp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CloseCdp _$CloseCdpFromJson(Map<String, dynamic> json) {
  return CloseCdp(
    signerDid: json['signer'] as String,
    timeStamp: json['cdp_timestamp'] as String,
  );
}

Map<String, dynamic> _$CloseCdpToJson(CloseCdp instance) => <String, dynamic>{
      'signer': instance.signerDid,
      'cdp_timestamp': instance.timeStamp,
    };
