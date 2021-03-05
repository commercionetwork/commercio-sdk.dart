// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DidDocument _$DidDocumentFromJson(Map<String, dynamic> json) {
  return DidDocument(
    context: json['@context'] as String,
    id: json['id'] as String,
    publicKeys: (json['publicKey'] as List<dynamic>)
        .map((e) => e == null
            ? null
            : DidDocumentPublicKey.fromJson(e as Map<String, dynamic>))
        .toList(),
    proof: DidDocumentProof.fromJson(json['proof'] as Map<String, dynamic>),
    service: (json['service'] as List<dynamic>?)
        ?.map((e) => DidDocumentService.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DidDocumentToJson(DidDocument instance) {
  final val = <String, dynamic>{
    '@context': instance.context,
    'id': instance.id,
    'publicKey': instance.publicKeys.map((e) => e?.toJson()).toList(),
    'proof': instance.proof.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('service', instance.service?.map((e) => e.toJson()).toList());
  return val;
}
