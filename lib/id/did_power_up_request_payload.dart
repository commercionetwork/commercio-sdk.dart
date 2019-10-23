import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'did_power_up_request_payload.g.dart';

/// Represents the payload that should be put inside a
/// [MsgRequestDidPowerUp] message.
@JsonSerializable()
class DidPowerUpRequestPayload extends Equatable {
  @JsonKey(name: "pairwise_did")
  final String pairwiseDid;
  @JsonKey(name: "timestamp")
  final String timestamp;
  @JsonKey(name: "signature")
  final String signature;

  DidPowerUpRequestPayload({
    @required this.pairwiseDid,
    @required this.timestamp,
    @required this.signature,
  })  : assert(pairwiseDid != null),
        assert(timestamp != null),
        assert(signature != null),
        super([pairwiseDid, timestamp, signature]);
}
