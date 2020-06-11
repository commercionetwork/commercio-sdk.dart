import 'package:commerciosdk/export.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'request_did_power_up.g.dart';

/// Contains the data related to a Did PowerUp
/// that is requested by a user.
@JsonSerializable(explicitToJson: true)
class RequestDidPowerUp extends Equatable {
  @JsonKey(name: 'claimant')
  final String claimantDid;

  @JsonKey(name: 'amount')
  final List<StdCoin> amount;

  @JsonKey(name: 'proof')
  final String powerUpProof;

  @JsonKey(name: 'id')
  final String uuid;

  @JsonKey(name: 'proof_key')
  final String encryptionKey;

  RequestDidPowerUp({
    @required this.claimantDid,
    @required this.amount,
    @required this.powerUpProof,
    @required this.uuid,
    @required this.encryptionKey,
  })  : assert(claimantDid != null),
        assert(amount != null),
        assert(amount.isNotEmpty),
        assert(powerUpProof != null),
        assert(uuid != null),
        assert(encryptionKey != null);

  @override
  List<Object> get props =>
      [claimantDid, amount, powerUpProof, uuid, encryptionKey];

  factory RequestDidPowerUp.fromJson(Map<String, dynamic> json) =>
      _$RequestDidPowerUpFromJson(json);

  Map<String, dynamic> toJson() => _$RequestDidPowerUpToJson(this);
}
