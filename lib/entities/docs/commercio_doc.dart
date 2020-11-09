import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'commercio_doc.g.dart';

/// Contains all the data related to a document that is sent to the chain when
/// a user wants to share a document with another user.
@JsonSerializable(explicitToJson: true)
class CommercioDoc extends Equatable {
  @JsonKey(name: 'sender')
  final String senderDid;

  @JsonKey(name: 'recipients')
  final List<String> recipientDids;

  @JsonKey(name: 'uuid')
  final String uuid;

  @JsonKey(name: 'content_uri')
  final String contentUri;

  @JsonKey(name: 'metadata')
  final CommercioDocMetadata metadata;

  @JsonKey(name: 'checksum')
  final CommercioDocChecksum checksum;

  @JsonKey(name: 'encryption_data')
  final CommercioDocEncryptionData encryptionData;

  @JsonKey(name: 'do_sign')
  final CommercioDoSign doSign;

  CommercioDoc({
    @required this.senderDid,
    @required this.recipientDids,
    @required this.uuid,
    @required this.metadata,
    this.contentUri,
    this.checksum,
    this.encryptionData,
    this.doSign,
  })  : assert(senderDid != null),
        assert(recipientDids != null && recipientDids.isNotEmpty),
        assert(uuid != null),
        assert(metadata != null);

  @override
  List<Object> get props {
    return [
      uuid,
      senderDid,
      recipientDids,
      contentUri,
      metadata,
      checksum,
      encryptionData,
      doSign,
    ];
  }

  factory CommercioDoc.fromJson(Map<String, dynamic> json) =>
      _$CommercioDocFromJson(json);

  Map<String, dynamic> toJson() => _$CommercioDocToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CommercioDocMetadata extends Equatable {
  @JsonKey(name: 'content_uri')
  final String contentUri;

  @JsonKey(name: 'schema_type')
  final String schemaType;

  @JsonKey(name: 'schema')
  final CommercioDocMetadataSchema schema;

  CommercioDocMetadata({
    @required this.contentUri,
    this.schemaType = '',
    this.schema,
  })  : assert(contentUri != null),
        assert(schemaType.isNotEmpty || schema != null);

  @override
  List<Object> get props {
    return [contentUri, schema, schemaType];
  }

  factory CommercioDocMetadata.fromJson(Map<String, dynamic> json) =>
      _$CommercioDocMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$CommercioDocMetadataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CommercioDocMetadataSchema extends Equatable {
  @JsonKey(name: 'uri')
  final String uri;

  @JsonKey(name: 'version')
  final String version;

  CommercioDocMetadataSchema({
    @required this.uri,
    @required this.version,
  })  : assert(uri != null),
        assert(version != null);

  @override
  List<Object> get props {
    return [uri, version];
  }

  factory CommercioDocMetadataSchema.fromJson(Map<String, dynamic> json) =>
      _$CommercioDocMetadataSchemaFromJson(json);

  Map<String, dynamic> toJson() => _$CommercioDocMetadataSchemaToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CommercioDocChecksum extends Equatable {
  @JsonKey(name: 'value')
  final String value;

  @JsonKey(name: 'algorithm')
  final CommercioDocChecksumAlgorithm algorithm;

  CommercioDocChecksum({
    @required this.value,
    @required this.algorithm,
  })  : assert(value != null),
        assert(algorithm != null);

  @override
  List<Object> get props {
    return [value, algorithm];
  }

  factory CommercioDocChecksum.fromJson(Map<String, dynamic> json) =>
      _$CommercioDocChecksumFromJson(json);

  Map<String, dynamic> toJson() => _$CommercioDocChecksumToJson(this);
}

enum CommercioDocChecksumAlgorithm {
  @JsonValue('md5')
  MD5,

  @JsonValue('sha-1')
  SHA1,

  @JsonValue('sha-224')
  SHA224,

  @JsonValue('sha-256')
  SHA256,

  @JsonValue('sha-384')
  SHA384,

  @JsonValue('sha-512')
  SHA512,
}

@JsonSerializable(explicitToJson: true)
class CommercioDocEncryptionData extends Equatable {
  @JsonKey(name: 'keys')
  final List<CommercioDocEncryptionDataKey> keys;

  @JsonKey(name: 'encrypted_data')
  final List<String> encryptedData;

  CommercioDocEncryptionData({
    @required this.keys,
    @required this.encryptedData,
  })  : assert(keys != null),
        assert(encryptedData != null);

  @override
  List<Object> get props {
    return [keys, encryptedData];
  }

  factory CommercioDocEncryptionData.fromJson(Map<String, dynamic> json) =>
      _$CommercioDocEncryptionDataFromJson(json);

  Map<String, dynamic> toJson() => _$CommercioDocEncryptionDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CommercioDocEncryptionDataKey extends Equatable {
  @JsonKey(name: 'recipient')
  final String recipientDid;

  @JsonKey(name: 'value')
  final String value;

  CommercioDocEncryptionDataKey({
    @required this.recipientDid,
    @required this.value,
  })  : assert(recipientDid != null),
        assert(value != null);

  @override
  List<Object> get props {
    return [recipientDid, value];
  }

  factory CommercioDocEncryptionDataKey.fromJson(Map<String, dynamic> json) =>
      _$CommercioDocEncryptionDataKeyFromJson(json);

  Map<String, dynamic> toJson() => _$CommercioDocEncryptionDataKeyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CommercioDoSign extends Equatable {
  @JsonKey(name: 'storage_uri')
  final String storageUri;

  @JsonKey(name: 'signer_instance')
  final String signerIstance;

  @JsonKey(name: 'sdn_data')
  final List<CommercioSdnData> sdnData;

  @JsonKey(name: 'vcr_id')
  final String vcrId;

  @JsonKey(name: 'certificate_profile')
  final String certificateProfile;

  CommercioDoSign({
    @required this.storageUri,
    @required this.signerIstance,
    @required this.vcrId,
    @required this.certificateProfile,
    this.sdnData,
  })  : assert(storageUri != null),
        assert(signerIstance != null),
        assert(vcrId != null),
        assert(certificateProfile != null);

  @override
  List<Object> get props {
    return [storageUri, signerIstance, sdnData, vcrId, certificateProfile];
  }

  factory CommercioDoSign.fromJson(Map<String, dynamic> json) =>
      _$CommercioDoSignFromJson(json);

  Map<String, dynamic> toJson() => _$CommercioDoSignToJson(this);
}

enum CommercioSdnData {
  @JsonValue('common_name')
  COMMON_NAME,

  @JsonValue('surname')
  SURNAME,

  @JsonValue('serial_number')
  SERIAL_NUMBER,

  @JsonValue('given_name')
  GIVEN_NAME,

  @JsonValue('organization')
  ORGANIZATION,

  @JsonValue('country')
  COUNTRY,
}
