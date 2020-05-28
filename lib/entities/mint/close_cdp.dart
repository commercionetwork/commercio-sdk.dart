import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'close_cdp.g.dart';

/// Contains the data related to a Collateralized Debt Position
/// that is closed by a user.
@JsonSerializable(explicitToJson: true)
class CloseCdp extends Equatable {
  @JsonKey(name: 'signer')
  final String signerDid;

  @JsonKey(name: 'cdp_timestamp')
  final String timeStamp;

  CloseCdp({
    @required this.signerDid,
    @required this.timeStamp,
  })  : assert(signerDid != null),
        assert(timeStamp != null);

  @override
  List<Object> get props {
    return [
      signerDid,
      timeStamp,
    ];
  }

  factory CloseCdp.fromJson(Map<String, dynamic> json) =>
      _$CloseCdpFromJson(json);

  Map<String, dynamic> toJson() => _$CloseCdpToJson(this);
}
