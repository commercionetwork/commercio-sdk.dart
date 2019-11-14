import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'did_deposit_request_signature_json.g.dart';

/// Represents the JSON object that should be created, signed and put
/// inside a [DidDepositRequestPayload] as the signature value.
@JsonSerializable()
class DidDepositRequestSignatureJson extends Equatable {
  @JsonKey(name: "recipient")
  final String recipient;
  @JsonKey(name: "timestamp")
  final String timeStamp;

  DidDepositRequestSignatureJson({
    @required this.recipient,
    @required this.timeStamp,
  })  : assert(recipient != null),
        assert(timeStamp != null),
        super([recipient, timeStamp]);

  factory DidDepositRequestSignatureJson.fromJson(Map<String, dynamic> json) =>
      _$DidDepositRequestSignatureJsonFromJson(json);

  Map<String, dynamic> toJson() => _$DidDepositRequestSignatureJsonToJson(this);
}
