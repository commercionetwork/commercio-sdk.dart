// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_document_proof_signature_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DidDocumentProofSignatureContent _$DidDocumentProofSignatureContentFromJson(
    Map<String, dynamic> json) {
  return DidDocumentProofSignatureContent(
    context: json['@context'] as String,
    did: json['id'] as String,
    publicKeys: (json['publicKey'] as List)
        ?.map((e) => e == null
            ? null
            : DidDocumentPublicKey.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DidDocumentProofSignatureContentToJson(
        DidDocumentProofSignatureContent instance) =>
    <String, dynamic>{
      '@context': instance.context,
      'id': instance.did,
      'publicKey': instance.publicKeys,
    };
