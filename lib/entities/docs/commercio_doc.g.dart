// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commercio_doc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommercioDoc _$CommercioDocFromJson(Map<String, dynamic> json) {
  return CommercioDoc(
    senderDid: json['sender'] as String,
    recipientDids:
        (json['recipients'] as List<dynamic>).map((e) => e as String).toList(),
    uuid: json['uuid'] as String,
    metadata:
        CommercioDocMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
    contentUri: json['content_uri'] as String?,
    checksum: json['checksum'] == null
        ? null
        : CommercioDocChecksum.fromJson(
            json['checksum'] as Map<String, dynamic>),
    encryptionData: json['encryption_data'] == null
        ? null
        : CommercioDocEncryptionData.fromJson(
            json['encryption_data'] as Map<String, dynamic>),
    doSign: json['do_sign'] == null
        ? null
        : CommercioDoSign.fromJson(json['do_sign'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommercioDocToJson(CommercioDoc instance) {
  final val = <String, dynamic>{
    'sender': instance.senderDid,
    'recipients': instance.recipientDids,
    'uuid': instance.uuid,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('content_uri', instance.contentUri);
  val['metadata'] = instance.metadata.toJson();
  writeNotNull('checksum', instance.checksum?.toJson());
  writeNotNull('encryption_data', instance.encryptionData?.toJson());
  writeNotNull('do_sign', instance.doSign?.toJson());
  return val;
}

CommercioDocMetadata _$CommercioDocMetadataFromJson(Map<String, dynamic> json) {
  return CommercioDocMetadata(
    contentUri: json['content_uri'] as String,
    schemaType: json['schema_type'] as String?,
    schema: json['schema'] == null
        ? null
        : CommercioDocMetadataSchema.fromJson(
            json['schema'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommercioDocMetadataToJson(
    CommercioDocMetadata instance) {
  final val = <String, dynamic>{
    'content_uri': instance.contentUri,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('schema_type', instance.schemaType);
  writeNotNull('schema', instance.schema?.toJson());
  return val;
}

CommercioDocMetadataSchema _$CommercioDocMetadataSchemaFromJson(
    Map<String, dynamic> json) {
  return CommercioDocMetadataSchema(
    uri: json['uri'] as String,
    version: json['version'] as String,
  );
}

Map<String, dynamic> _$CommercioDocMetadataSchemaToJson(
        CommercioDocMetadataSchema instance) =>
    <String, dynamic>{
      'uri': instance.uri,
      'version': instance.version,
    };

CommercioDocChecksum _$CommercioDocChecksumFromJson(Map<String, dynamic> json) {
  return CommercioDocChecksum(
    value: json['value'] as String,
    algorithm:
        _$enumDecode(_$CommercioDocChecksumAlgorithmEnumMap, json['algorithm']),
  );
}

Map<String, dynamic> _$CommercioDocChecksumToJson(
        CommercioDocChecksum instance) =>
    <String, dynamic>{
      'value': instance.value,
      'algorithm': _$CommercioDocChecksumAlgorithmEnumMap[instance.algorithm],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$CommercioDocChecksumAlgorithmEnumMap = {
  CommercioDocChecksumAlgorithm.MD5: 'md5',
  CommercioDocChecksumAlgorithm.SHA1: 'sha-1',
  CommercioDocChecksumAlgorithm.SHA224: 'sha-224',
  CommercioDocChecksumAlgorithm.SHA256: 'sha-256',
  CommercioDocChecksumAlgorithm.SHA384: 'sha-384',
  CommercioDocChecksumAlgorithm.SHA512: 'sha-512',
};

CommercioDocEncryptionData _$CommercioDocEncryptionDataFromJson(
    Map<String, dynamic> json) {
  return CommercioDocEncryptionData(
    keys: (json['keys'] as List<dynamic>)
        .map((e) =>
            CommercioDocEncryptionDataKey.fromJson(e as Map<String, dynamic>))
        .toList(),
    encryptedData: (json['encrypted_data'] as List<dynamic>)
        .map((e) => _$enumDecode(_$CommercioEncryptedDataEnumMap, e))
        .toSet(),
  );
}

Map<String, dynamic> _$CommercioDocEncryptionDataToJson(
        CommercioDocEncryptionData instance) =>
    <String, dynamic>{
      'keys': instance.keys.map((e) => e.toJson()).toList(),
      'encrypted_data': instance.encryptedData
          .map((e) => _$CommercioEncryptedDataEnumMap[e])
          .toList(),
    };

const _$CommercioEncryptedDataEnumMap = {
  CommercioEncryptedData.CONTENT: 'content',
  CommercioEncryptedData.CONTENT_URI: 'content_uri',
  CommercioEncryptedData.METADATA_CONTENT_URI: 'metadata.content_uri',
  CommercioEncryptedData.METADATA_SCHEMA_URI: 'metadata.schema.uri',
};

CommercioDocEncryptionDataKey _$CommercioDocEncryptionDataKeyFromJson(
    Map<String, dynamic> json) {
  return CommercioDocEncryptionDataKey(
    recipientDid: json['recipient'] as String,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$CommercioDocEncryptionDataKeyToJson(
        CommercioDocEncryptionDataKey instance) =>
    <String, dynamic>{
      'recipient': instance.recipientDid,
      'value': instance.value,
    };

CommercioDoSign _$CommercioDoSignFromJson(Map<String, dynamic> json) {
  return CommercioDoSign(
    storageUri: json['storage_uri'] as String,
    signerIstance: json['signer_instance'] as String,
    vcrId: json['vcr_id'] as String,
    certificateProfile: json['certificate_profile'] as String,
    sdnData: (json['sdn_data'] as List<dynamic>?)
        ?.map((e) => _$enumDecode(_$CommercioSdnDataEnumMap, e))
        .toSet(),
  );
}

Map<String, dynamic> _$CommercioDoSignToJson(CommercioDoSign instance) =>
    <String, dynamic>{
      'storage_uri': instance.storageUri,
      'signer_instance': instance.signerIstance,
      'sdn_data':
          instance.sdnData?.map((e) => _$CommercioSdnDataEnumMap[e]).toList(),
      'vcr_id': instance.vcrId,
      'certificate_profile': instance.certificateProfile,
    };

const _$CommercioSdnDataEnumMap = {
  CommercioSdnData.COMMON_NAME: 'common_name',
  CommercioSdnData.SURNAME: 'surname',
  CommercioSdnData.SERIAL_NUMBER: 'serial_number',
  CommercioSdnData.GIVEN_NAME: 'given_name',
  CommercioSdnData.ORGANIZATION: 'organization',
  CommercioSdnData.COUNTRY: 'country',
};
