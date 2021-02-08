// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commercio_doc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommercioDoc _$CommercioDocFromJson(Map<String, dynamic> json) {
  return CommercioDoc(
    senderDid: json['sender'] as String,
    recipientDids:
        (json['recipients'] as List)?.map((e) => e as String)?.toList(),
    uuid: json['uuid'] as String,
    metadata: json['metadata'] == null
        ? null
        : CommercioDocMetadata.fromJson(
            json['metadata'] as Map<String, dynamic>),
    contentUri: json['content_uri'] as String,
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
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sender', instance.senderDid);
  writeNotNull('recipients', instance.recipientDids);
  writeNotNull('uuid', instance.uuid);
  writeNotNull('content_uri', instance.contentUri);
  writeNotNull('metadata', instance.metadata?.toJson());
  writeNotNull('checksum', instance.checksum?.toJson());
  writeNotNull('encryption_data', instance.encryptionData?.toJson());
  writeNotNull('do_sign', instance.doSign?.toJson());
  return val;
}

CommercioDocMetadata _$CommercioDocMetadataFromJson(Map<String, dynamic> json) {
  return CommercioDocMetadata(
    contentUri: json['content_uri'] as String,
    schemaType: json['schema_type'] as String,
    schema: json['schema'] == null
        ? null
        : CommercioDocMetadataSchema.fromJson(
            json['schema'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommercioDocMetadataToJson(
    CommercioDocMetadata instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('content_uri', instance.contentUri);
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
    CommercioDocMetadataSchema instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('version', instance.version);
  return val;
}

CommercioDocChecksum _$CommercioDocChecksumFromJson(Map<String, dynamic> json) {
  return CommercioDocChecksum(
    value: json['value'] as String,
    algorithm: _$enumDecodeNullable(
        _$CommercioDocChecksumAlgorithmEnumMap, json['algorithm']),
  );
}

Map<String, dynamic> _$CommercioDocChecksumToJson(
    CommercioDocChecksum instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('value', instance.value);
  writeNotNull(
      'algorithm', _$CommercioDocChecksumAlgorithmEnumMap[instance.algorithm]);
  return val;
}

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
    keys: (json['keys'] as List)
        ?.map((e) => e == null
            ? null
            : CommercioDocEncryptionDataKey.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    encryptedData: (json['encrypted_data'] as List)
        ?.map((e) => _$enumDecodeNullable(_$CommercioEncryptedDataEnumMap, e))
        ?.toSet(),
  );
}

Map<String, dynamic> _$CommercioDocEncryptionDataToJson(
    CommercioDocEncryptionData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('keys', instance.keys?.map((e) => e?.toJson())?.toList());
  writeNotNull(
      'encrypted_data',
      instance.encryptedData
          ?.map((e) => _$CommercioEncryptedDataEnumMap[e])
          ?.toList());
  return val;
}

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
    CommercioDocEncryptionDataKey instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('recipient', instance.recipientDid);
  writeNotNull('value', instance.value);
  return val;
}

CommercioDoSign _$CommercioDoSignFromJson(Map<String, dynamic> json) {
  return CommercioDoSign(
    storageUri: json['storage_uri'] as String,
    signerIstance: json['signer_instance'] as String,
    vcrId: json['vcr_id'] as String,
    certificateProfile: json['certificate_profile'] as String,
    sdnData: (json['sdn_data'] as List)
        ?.map((e) => _$enumDecodeNullable(_$CommercioSdnDataEnumMap, e))
        ?.toSet(),
  );
}

Map<String, dynamic> _$CommercioDoSignToJson(CommercioDoSign instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('storage_uri', instance.storageUri);
  writeNotNull('signer_instance', instance.signerIstance);
  writeNotNull('sdn_data',
      instance.sdnData?.map((e) => _$CommercioSdnDataEnumMap[e])?.toList());
  writeNotNull('vcr_id', instance.vcrId);
  writeNotNull('certificate_profile', instance.certificateProfile);
  return val;
}

const _$CommercioSdnDataEnumMap = {
  CommercioSdnData.COMMON_NAME: 'common_name',
  CommercioSdnData.SURNAME: 'surname',
  CommercioSdnData.SERIAL_NUMBER: 'serial_number',
  CommercioSdnData.GIVEN_NAME: 'given_name',
  CommercioSdnData.ORGANIZATION: 'organization',
  CommercioSdnData.COUNTRY: 'country',
};
