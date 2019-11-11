import 'package:commerciosdk/export.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'did_document_proof_signature_content.g.dart';

@JsonSerializable(includeIfNull: false)
class DidDocumentProofSignatureContent extends Equatable {
  @JsonKey(name: "@context")
  final String context;

  @JsonKey(name: "id")
  final String did;

  @JsonKey(name: "publicKey")
  final List<DidDocumentPublicKey> publicKeys;

  @JsonKey(name: "authentication")
  final List<String> authentication;

  DidDocumentProofSignatureContent({
    @required this.context,
    @required this.did,
    @required this.publicKeys,
    @required this.authentication,
  })  : assert(context != null),
        assert(did != null),
        assert(publicKeys != null),
        assert(authentication != null),
        super([context, did, publicKeys, authentication]);

  factory DidDocumentProofSignatureContent.fromJson(
          Map<String, dynamic> json) =>
      _$DidDocumentProofSignatureContentFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DidDocumentProofSignatureContentToJson(this);
}
