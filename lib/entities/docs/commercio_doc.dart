import 'package:commerciosdk/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'commercio_doc.g.dart';

/// Contains all the data related to a document that is sent to the chain when
/// a user wants to share a document with another user.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
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
  })  : assert(senderDid != null && matchBech32Format(senderDid)),
        assert(recipientDids != null &&
            recipientDids.isNotEmpty &&
            recipientDids.every((e) => matchBech32Format(e))),
        assert(uuid != null && matchUuidv4(uuid)),
        assert(metadata != null),
        assert(contentUri == null ||
            (contentUri != null && checkStringBytesLen(contentUri, 512)));

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CommercioDocMetadata extends Equatable {
  @JsonKey(name: 'content_uri')
  final String contentUri;

  @JsonKey(name: 'schema_type')
  final String schemaType;

  @JsonKey(name: 'schema')
  final CommercioDocMetadataSchema schema;

  CommercioDocMetadata({
    @required this.contentUri,
    this.schemaType,
    this.schema,
  })  : assert(contentUri != null && checkStringBytesLen(contentUri, 512)),
        assert((schemaType != null &&
                schemaType.isNotEmpty &&
                checkStringBytesLen(schemaType, 512)) ||
            schema != null);

  @override
  List<Object> get props {
    return [contentUri, schema, schemaType];
  }

  factory CommercioDocMetadata.fromJson(Map<String, dynamic> json) =>
      _$CommercioDocMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$CommercioDocMetadataToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CommercioDocMetadataSchema extends Equatable {
  @JsonKey(name: 'uri')
  final String uri;

  @JsonKey(name: 'version')
  final String version;

  CommercioDocMetadataSchema({
    @required this.uri,
    @required this.version,
  })  : assert(uri != null && uri.isNotEmpty && checkStringBytesLen(uri, 512)),
        assert(version != null &&
            uri.isNotEmpty &&
            checkStringBytesLen(version, 32));

  @override
  List<Object> get props {
    return [uri, version];
  }

  factory CommercioDocMetadataSchema.fromJson(Map<String, dynamic> json) =>
      _$CommercioDocMetadataSchemaFromJson(json);

  Map<String, dynamic> toJson() => _$CommercioDocMetadataSchemaToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CommercioDocChecksum extends Equatable {
  @JsonKey(name: 'value')
  final String value;

  @JsonKey(name: 'algorithm')
  final CommercioDocChecksumAlgorithm algorithm;

  CommercioDocChecksum({
    @required this.value,
    @required this.algorithm,
  })  : assert(value != null && value.isNotEmpty),
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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CommercioDocEncryptionData extends Equatable {
  @JsonKey(name: 'keys')
  final List<CommercioDocEncryptionDataKey> keys;

  @JsonKey(name: 'encrypted_data')
  final Set<CommercioEncryptedData> encryptedData;

  const CommercioDocEncryptionData({
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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CommercioDocEncryptionDataKey extends Equatable {
  @JsonKey(name: 'recipient')
  final String recipientDid;

  @JsonKey(name: 'value')
  final String value;

  CommercioDocEncryptionDataKey({
    @required this.recipientDid,
    @required this.value,
  })  : assert(recipientDid != null),
        assert(value != null && checkStringBytesLen(value, 512));

  @override
  List<Object> get props {
    return [recipientDid, value];
  }

  factory CommercioDocEncryptionDataKey.fromJson(Map<String, dynamic> json) =>
      _$CommercioDocEncryptionDataKeyFromJson(json);

  Map<String, dynamic> toJson() => _$CommercioDocEncryptionDataKeyToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CommercioDoSign extends Equatable {
  @JsonKey(name: 'storage_uri')
  final String storageUri;

  @JsonKey(name: 'signer_instance')
  final String signerIstance;

  @JsonKey(name: 'sdn_data')
  final Set<CommercioSdnData> sdnData;

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
        assert(vcrId != null && checkStringBytesLen(vcrId, 64)),
        assert(certificateProfile != null &&
            checkStringBytesLen(certificateProfile, 32));

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

// For more information see:
/// https://docs.commercio.network/x/docs/#supported-encrypted-data
enum CommercioEncryptedData {
  /// Special identifier, references the document's file contents. Means that
  /// the `aes_key` has been used to encrypt a file exchanged by other means of
  /// communication.
  @JsonValue('content')
  CONTENT,

  /// The value of the field `content_uri` must be encrypted.
  @JsonValue('content_uri')
  CONTENT_URI,

  /// The value of the field `content_uri` inside the `metadata` must be
  /// encrypted.
  @JsonValue('metadata.content_uri')
  METADATA_CONTENT_URI,

  /// The value of the field `uri` inside the `schema` inside `metadata` must be
  /// encrypted.
  @JsonValue('metadata.schema.uri')
  METADATA_SCHEMA_URI,
}

extension CommercioEncryptedDataExt on CommercioEncryptedData {
  /// Returns the string representation of the [EncryptedData] enum.
  String get value {
    switch (this) {
      case CommercioEncryptedData.CONTENT:
        return 'content';
      case CommercioEncryptedData.CONTENT_URI:
        return 'content_uri';
      case CommercioEncryptedData.METADATA_CONTENT_URI:
        return 'metadata.content_uri';
      case CommercioEncryptedData.METADATA_SCHEMA_URI:
        return 'metadata.schema.uri';
      default:
        return null;
    }
  }

  /// Returns the [EncryptedData] that corresponds to the [value] or [null] if
  /// the [value] is not valid.
  static CommercioEncryptedData fromValue(String value) {
    switch (value) {
      case 'content':
        return CommercioEncryptedData.CONTENT;
      case 'content_uri':
        return CommercioEncryptedData.CONTENT_URI;
      case 'metadata.content_uri':
        return CommercioEncryptedData.METADATA_CONTENT_URI;
      case 'metadata.schema.uri':
        return CommercioEncryptedData.METADATA_SCHEMA_URI;
      default:
        return null;
    }
  }
}
