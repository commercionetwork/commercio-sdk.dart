import 'package:commerciosdk/export.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exchange_trade_position.g.dart';

@JsonSerializable(explicitToJson: true)
class ExchangeTradePosition extends Equatable {
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'owner')
  final String owner;

  @JsonKey(name: 'exchange_rate')
  final String exchangeRate;

  @JsonKey(name: 'collateral')
  final String collateral;

  @JsonKey(name: 'credits')
  final StdCoin credits;

  const ExchangeTradePosition({
    required this.createdAt,
    required this.id,
    required this.owner,
    required this.exchangeRate,
    required this.collateral,
    required this.credits,
  });

  @override
  List<Object> get props =>
      [createdAt, id, owner, exchangeRate, collateral, credits];

  factory ExchangeTradePosition.fromJson(Map<String, dynamic> json) =>
      _$ExchangeTradePositionFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeTradePositionToJson(this);
}
