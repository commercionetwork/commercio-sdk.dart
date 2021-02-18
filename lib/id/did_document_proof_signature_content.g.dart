// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_document_proof_signature_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DidDocumentProofSignatureContent _$DidDocumentProofSignatureContentFromJson(
    Map<String, dynamic> json) {
  return DidDocumentProofSignatureContent(
    context: json['@context'] as String,
    id: json['id'] as String,
    publicKeys: (json['publicKey'] as List)
        ?.map((e) => e == null
            ? null
            : DidDocumentPublicKey.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    service: (json['service'] as List)
        ?.map((e) => e == null
            ? null
            : DidDocumentService.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DidDocumentProofSignatureContentToJson(
    DidDocumentProofSignatureContent instance) {
  final val = <String, dynamic>{
    '@context': instance.context,
    'id': instance.id,
    'publicKey': instance.publicKeys,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('service', instance.service);
  return val;
}
