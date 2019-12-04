import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'did_deposit_request_payload.g.dart';

/// Represents the JSON object that should be encrypted and put
/// inside a [MsgRequestDidDeposit] as its payload.
@JsonSerializable()
class DidDepositRequestPayload extends Equatable {
  @JsonKey(name: "recipient")
  final String recipient;
  @JsonKey(name: "timestamp")
  final String timeStamp;
  @JsonKey(name: "signature")
  final String signature;

  DidDepositRequestPayload({
    @required this.recipient,
    @required this.timeStamp,
    @required this.signature,
  })  : assert(recipient != null),
        assert(timeStamp != null),
        assert(signature != null);

  @override
  List<Object> get props {
    return [recipient, timeStamp, signature];
  }

  factory DidDepositRequestPayload.fromJson(Map<String, dynamic> json) =>
      _$DidDepositRequestPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$DidDepositRequestPayloadToJson(this);
}
