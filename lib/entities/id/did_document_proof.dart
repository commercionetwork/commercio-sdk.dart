import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'did_document_proof.g.dart';

/// Contains the data of the proof that makes sure the user has properly
/// signed the Did Document contents with his authentication key so that
/// he can guarantee that he is the real controller of the Did Document itself.
@JsonSerializable(explicitToJson: true)
class DidDocumentProof extends Equatable {
  @JsonKey(name: "type")
  final String type;

  @JsonKey(name: "created")
  final String iso8601creationTimestamp;

  @JsonKey(name: "proofPurpose")
  final String proofPurpose;

  @JsonKey(name: "controller")
  final String controller;

  @JsonKey(name: "verificationMethod")
  final String verificationMethod;

  @JsonKey(name: "signatureValue")
  final String signatureValue;

  DidDocumentProof({
    @required this.type,
    @required this.iso8601creationTimestamp,
    @required this.proofPurpose,
    @required this.controller,
    @required this.verificationMethod,
    @required this.signatureValue,
  })  : assert(type != null),
        assert(iso8601creationTimestamp != null),
        assert(proofPurpose != null),
        assert(controller != null),
        assert(verificationMethod != null),
        assert(signatureValue != null);

  @override
  List<Object> get props {
    return [type, iso8601creationTimestamp, proofPurpose, controller, verificationMethod, signatureValue];
  }

  factory DidDocumentProof.fromJson(Map<String, dynamic> json) =>
      _$DidDocumentProofFromJson(json);

  Map<String, dynamic> toJson() => _$DidDocumentProofToJson(this);
}
