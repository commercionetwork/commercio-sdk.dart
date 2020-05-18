// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_document_public_key.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DidDocumentPublicKey _$DidDocumentPublicKeyFromJson(Map<String, dynamic> json) {
  return DidDocumentPublicKey(
    id: json['id'] as String,
    type: json['type'] as String,
    controller: json['controller'] as String,
    publicKeyPem: json['publicKeyPem'] as String,
  );
}

Map<String, dynamic> _$DidDocumentPublicKeyToJson(
        DidDocumentPublicKey instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'controller': instance.controller,
      'publicKeyPem': instance.publicKeyPem,
    };
