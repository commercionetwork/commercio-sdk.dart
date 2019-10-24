import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'did_document_proof.g.dart';

/// Contains the data of the proof that makes sure the user has properly
/// signed the Did Document contents with his authentication key so that
/// he can guarantee that he is the real controller of the Did Document itself.
@JsonSerializable(includeIfNull: false)
class DidDocumentProof extends Equatable {
  @JsonKey(name: "type")
  final String type;

  @JsonKey(name: "created")
  final String iso8601creationTimestamp;

  @JsonKey(name: "creator")
  final String creatorKeyId;

  @JsonKey(name: "signatureValue")
  final String signatureValue;

  DidDocumentProof({
    @required this.type,
    @required this.iso8601creationTimestamp,
    @required this.creatorKeyId,
    @required this.signatureValue,
  })  : assert(type != null),
        assert(iso8601creationTimestamp != null),
        assert(creatorKeyId != null),
        assert(signatureValue != null),
        super([type, iso8601creationTimestamp, creatorKeyId, signatureValue]);

  factory DidDocumentProof.fromJson(Map<String, dynamic> json) =>
      _$DidDocumentProofFromJson(json);

  Map<String, dynamic> toJson() => _$DidDocumentProofToJson(this);
}
