// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_document_proof.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DidDocumentProof _$DidDocumentProofFromJson(Map<String, dynamic> json) {
  return DidDocumentProof(
    type: json['type'] as String,
    iso8601creationTimestamp: json['created'] as String,
    creatorKeyId: json['creator'] as String,
    signatureValue: json['signatureValue'] as String,
  );
}

Map<String, dynamic> _$DidDocumentProofToJson(DidDocumentProof instance) =>
    <String, dynamic>{
      'type': instance.type,
      'created': instance.iso8601creationTimestamp,
      'creator': instance.creatorKeyId,
      'signatureValue': instance.signatureValue,
    };
