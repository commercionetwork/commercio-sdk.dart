import 'package:commerciosdk/export.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'burn_ccc.g.dart';

/// Contains the data to burn previously minteted CCC.
@JsonSerializable(explicitToJson: true)
class BurnCcc extends Equatable {
  @JsonKey(name: 'signer')
  final String signerDid;

  @JsonKey(name: 'amount')
  final StdCoin amount;

  @JsonKey(name: 'id')
  final String id;

  BurnCcc({
    @required this.signerDid,
    @required this.amount,
    @required this.id,
  })  : assert(signerDid != null && matchBech32Format(signerDid)),
        assert(amount != null),
        assert(id != null && matchUuidv4(id));

  @override
  List<Object> get props => throw [signerDid, amount, id];

  factory BurnCcc.fromJson(Map<String, dynamic> json) =>
      _$BurnCccFromJson(json);

  Map<String, dynamic> toJson() => _$BurnCccToJson(this);
}
