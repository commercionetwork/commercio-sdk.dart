import 'package:commerciosdk/export.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'mint_ccc.g.dart';

// Contains the data to mint CCC
@JsonSerializable(explicitToJson: true)
class MintCcc extends Equatable {
  @JsonKey(name: 'deposit_amount')
  final List<StdCoin> depositAmount;

  @JsonKey(name: 'depositor')
  final String signerDid;

  @JsonKey(name: 'id')
  final String id;

  MintCcc({
    @required this.depositAmount,
    @required this.signerDid,
    @required this.id,
  })  : assert(depositAmount != null),
        assert(signerDid != null),
        assert(id != null);

  @override
  List<Object> get props => [depositAmount, signerDid, id];

  factory MintCcc.fromJson(Map<String, dynamic> json) =>
      _$MintCccFromJson(json);

  Map<String, dynamic> toJson() => _$MintCccToJson(this);
}
