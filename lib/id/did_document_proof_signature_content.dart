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
}
