// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'burn_ccc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BurnCcc _$BurnCccFromJson(Map<String, dynamic> json) {
  return BurnCcc(
    signerDid: json['signer'] as String,
    amount: StdCoin.fromJson(json['amount'] as Map<String, dynamic>),
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$BurnCccToJson(BurnCcc instance) => <String, dynamic>{
      'signer': instance.signerDid,
      'amount': instance.amount.toJson(),
      'id': instance.id,
    };
