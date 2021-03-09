import 'package:commerciosdk/export.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'did_document_proof_signature_content.g.dart';

@JsonSerializable()
class DidDocumentProofSignatureContent extends Equatable {
  @JsonKey(name: '@context')
  final String context;

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'publicKey')
  final List<DidDocumentPublicKey> publicKeys;

  @JsonKey(name: 'service', includeIfNull: false)
  final List<DidDocumentService>? service;

  const DidDocumentProofSignatureContent({
    required this.context,
    required this.id,
    required this.publicKeys,
    this.service,
  });

  @override
  List<Object?> get props {
    return [context, id, publicKeys, service];
  }

  factory DidDocumentProofSignatureContent.fromJson(
          Map<String, dynamic> json) =>
      _$DidDocumentProofSignatureContentFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DidDocumentProofSignatureContentToJson(this);
}
