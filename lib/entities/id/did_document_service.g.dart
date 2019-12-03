// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_document_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DidDocumentService _$DidDocumentServiceFromJson(Map<String, dynamic> json) {
  return DidDocumentService(
    id: json['id'] as String,
    type: json['type'] as String,
    endpoint: json['serviceEndpoint'] as String,
  );
}

Map<String, dynamic> _$DidDocumentServiceToJson(DidDocumentService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'serviceEndpoint': instance.endpoint,
    };
