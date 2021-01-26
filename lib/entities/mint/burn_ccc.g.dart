// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'burn_ccc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BurnCcc _$BurnCccFromJson(Map<String, dynamic> json) {
  return BurnCcc(
    signerDid: json['signer'] as String,
    amount: (json['amount'] as List)
        ?.map((e) =>
            e == null ? null : StdCoin.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$BurnCccToJson(BurnCcc instance) => <String, dynamic>{
      'signer': instance.signerDid,
      'amount': instance.amount?.map((e) => e?.toJson())?.toList(),
      'id': instance.id,
    };
