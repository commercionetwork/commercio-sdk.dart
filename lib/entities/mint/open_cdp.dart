import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'package:commerciosdk/export.dart';

part 'open_cdp.g.dart';

/// Contains the data related to a Collateralized Debt Position
/// that is opened by a user.
@JsonSerializable(explicitToJson: true)
class OpenCdp extends Equatable {
  @JsonKey(name: 'deposit_amount')
  final List<StdCoin> depositAmount;

  @JsonKey(name: 'depositor')
  final String signerDid;

  OpenCdp({
    @required this.depositAmount,
    @required this.signerDid,
  })  : assert(depositAmount != null),
        assert(signerDid != null);

  @override
  List<Object> get props => [depositAmount, signerDid];

  factory OpenCdp.fromJson(Map<String, dynamic> json) =>
      _$OpenCdpFromJson(json);

  Map<String, dynamic> toJson() => _$OpenCdpToJson(this);
}
