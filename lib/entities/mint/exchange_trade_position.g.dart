// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_trade_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeTradePosition _$ExchangeTradePositionFromJson(
    Map<String, dynamic> json) {
  return ExchangeTradePosition(
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    id: json['id'] as String,
    owner: json['owner'] as String,
    exchangeRate: json['exchange_rate'] as String,
    collateral: json['collateral'] as String,
    credits: json['credits'] == null
        ? null
        : StdCoin.fromJson(json['credits'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ExchangeTradePositionToJson(
        ExchangeTradePosition instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt?.toIso8601String(),
      'id': instance.id,
      'owner': instance.owner,
      'exchange_rate': instance.exchangeRate,
      'collateral': instance.collateral,
      'credits': instance.credits?.toJson(),
    };
