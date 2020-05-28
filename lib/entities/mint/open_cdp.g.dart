// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_cdp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenCdp _$OpenCdpFromJson(Map<String, dynamic> json) {
  return OpenCdp(
    depositAmount: (json['deposit_amount'] as List)
        ?.map((e) =>
            e == null ? null : StdCoin.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    signerDid: json['depositor'] as String,
  );
}

Map<String, dynamic> _$OpenCdpToJson(OpenCdp instance) => <String, dynamic>{
      'deposit_amount':
          instance.depositAmount?.map((e) => e?.toJson())?.toList(),
      'depositor': instance.signerDid,
    };
