// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_document_proof.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DidDocumentProof _$DidDocumentProofFromJson(Map<String, dynamic> json) {
  return DidDocumentProof(
    type: json['type'] as String,
    timestamp: json['created'] as String,
    proofPurpose: json['proofPurpose'] as String,
    controller: json['controller'] as String,
    verificationMethod: json['verificationMethod'] as String,
    signatureValue: json['signatureValue'] as String,
  );
}

Map<String, dynamic> _$DidDocumentProofToJson(DidDocumentProof instance) =>
    <String, dynamic>{
      'type': instance.type,
      'created': instance.timestamp,
      'proofPurpose': instance.proofPurpose,
      'controller': instance.controller,
      'verificationMethod': instance.verificationMethod,
      'signatureValue': instance.signatureValue,
    };
