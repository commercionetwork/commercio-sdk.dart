// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DidDocument _$DidDocumentFromJson(Map<String, dynamic> json) {
  return DidDocument(
    context: json['@context'] as String,
    id: json['id'] as String,
    publicKeys: (json['publicKey'] as List)
        ?.map((e) => e == null
            ? null
            : DidDocumentPublicKey.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    proof: json['proof'] == null
        ? null
        : DidDocumentProof.fromJson(json['proof'] as Map<String, dynamic>),
    services: (json['service'] as List)
        ?.map((e) => e == null
            ? null
            : DidDocumentService.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DidDocumentToJson(DidDocument instance) =>
    <String, dynamic>{
      '@context': instance.context,
      'id': instance.id,
      'publicKey': instance.publicKeys?.map((e) => e?.toJson())?.toList(),
      'proof': instance.proof?.toJson(),
      'service': instance.services?.map((e) => e?.toJson())?.toList(),
    };
