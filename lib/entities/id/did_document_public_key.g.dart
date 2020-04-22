// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_document_public_key.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DidDocumentPublicKey _$DidDocumentPublicKeyFromJson(Map<String, dynamic> json) {
  return DidDocumentPublicKey(
    id: json['id'] as String,
    type: _$enumDecodeNullable(_$DidDocumentPubKeyTypeEnumMap, json['type']),
    controller: json['controller'] as String,
    publicKeyPem: json['publicKeyPem'] as String,
  );
}

Map<String, dynamic> _$DidDocumentPublicKeyToJson(
        DidDocumentPublicKey instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$DidDocumentPubKeyTypeEnumMap[instance.type],
      'controller': instance.controller,
      'publicKeyPem': instance.publicKeyPem,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$DidDocumentPubKeyTypeEnumMap = {
  DidDocumentPubKeyType.RSA: 'RsaVerificationKey2018',
  DidDocumentPubKeyType.RSA_SIG: 'RsaSignature2018',
  DidDocumentPubKeyType.ED25519: 'Ed25519VerificationKey2018',
  DidDocumentPubKeyType.SECP256K1: 'Secp256k1VerificationKey2018',
};
