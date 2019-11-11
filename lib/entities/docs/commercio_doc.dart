import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'commercio_doc.g.dart';

/// Contains all the data related to a document that is sent to the chain when
/// a user wants to share a document with another user.
@JsonSerializable()
class CommercioDoc extends Equatable {
  @JsonKey(name: "sender")
  final String senderDid;

  @JsonKey(name: "recipients")
  final List<String> recipientDids;

  @JsonKey(name: "uuid")
  final String uuid;

  @JsonKey(name: "content_uri")
  final String contentUri;

  @JsonKey(name: "metadata")
  final CommercioDocMetadata metadata;

  @JsonKey(name: "checksum")
  final CommercioDocChecksum checksum;

  @JsonKey(name: "encryption_data")
  final CommercioDocEncryptionData encryptionData;

  CommercioDoc({
    @required this.uuid,
    @required this.senderDid,
    @required this.recipientDids,
    @required this.contentUri,
    @required this.metadata,
    @required this.checksum,
    @required this.encryptionData,
  })  : assert(senderDid != null),
        assert(recipientDids != null),
        assert(recipientDids.isNotEmpty),
        assert(uuid != null),
        assert(contentUri != null),
        assert(metadata != null),
        super([
          uuid,
          senderDid,
          recipientDids,
          contentUri,
          metadata,
          checksum,
          encryptionData,
        ]);

  factory CommercioDoc.fromJson(Map<String, dynamic> json) =>
      _$CommercioDocFromJson(json);

  Map<String, dynamic> toJson() => _$CommercioDocToJson(this);
}

@JsonSerializable()
class CommercioDocMetadata extends Equatable {
  @JsonKey(name: "content_uri")
  final String contentUri;

  @JsonKey(name: "schema")
  final CommercioDocMetadataSchema schema;

  @JsonKey(name: "schema_type")
  final String schemaType;

  CommercioDocMetadata({
    @required this.contentUri,
    this.schema = null,
    this.schemaType = "",
  })  : assert(contentUri != null),
        assert(schemaType != null),
        assert(schema != null || schemaType.isNotEmpty),
        super([contentUri, schema, schemaType]);

  factory CommercioDocMetadata.fromJson(Map<String, dynamic> json) =>
      _$CommercioDocMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$CommercioDocMetadataToJson(this);
}

@JsonSerializable()
class CommercioDocMetadataSchema extends Equatable {
  @JsonKey(name: "uri")
  final String uri;

  @JsonKey(name: "version")
  final String version;

  CommercioDocMetadataSchema({
    @required this.uri,
    @required this.version,
  })  : assert(uri != null),
        assert(version != null),
        super([uri, version]);

  factory CommercioDocMetadataSchema.fromJson(Map<String, dynamic> json) =>
      _$CommercioDocMetadataSchemaFromJson(json);

  Map<String, dynamic> toJson() => _$CommercioDocMetadataSchemaToJson(this);
}

@JsonSerializable()
class CommercioDocChecksum extends Equatable {
  @JsonKey(name: "value")
  final String value;

  @JsonKey(name: "algorithm")
  final CommercioDocChecksumAlgorithm algorithm;

  CommercioDocChecksum({
    @required this.value,
    @required this.algorithm,
  })  : assert(value != null),
        assert(algorithm != null),
        super([value, algorithm]);

  factory CommercioDocChecksum.fromJson(Map<String, dynamic> json) =>
      _$CommercioDocChecksumFromJson(json);

  Map<String, dynamic> toJson() => _$CommercioDocChecksumToJson(this);
}

enum CommercioDocChecksumAlgorithm {
  @JsonValue("md5")
  MD5,

  @JsonValue("sha-1")
  SHA1,

  @JsonValue("sha-224")
  SHA224,

  @JsonValue("sha-384")
  SHA384,

  @JsonValue("sha-512")
  SHA512,
}

@JsonSerializable()
class CommercioDocEncryptionData extends Equatable {
  @JsonKey(name: "keys")
  final List<CommercioDocEncryptionDataKey> keys;

  @JsonKey(name: "encrypted_data")
  final List<String> encryptedData;

  CommercioDocEncryptionData({
    @required this.keys,
    @required this.encryptedData,
  })  : assert(keys != null),
        assert(encryptedData != null),
        super([keys, encryptedData]);

  factory CommercioDocEncryptionData.fromJson(Map<String, dynamic> json) =>
      _$CommercioDocEncryptionDataFromJson(json);

  Map<String, dynamic> toJson() => _$CommercioDocEncryptionDataToJson(this);
}

@JsonSerializable()
class CommercioDocEncryptionDataKey extends Equatable {
  @JsonKey(name: "recipient")
  final String recipientDid;

  @JsonKey(name: "value")
  final String value;

  CommercioDocEncryptionDataKey({
    @required this.recipientDid,
    @required this.value,
  })  : assert(recipientDid != null),
        assert(value != null),
        super([recipientDid, value]);

  factory CommercioDocEncryptionDataKey.fromJson(Map<String, dynamic> json) =>
      _$CommercioDocEncryptionDataKeyFromJson(json);

  Map<String, dynamic> toJson() => _$CommercioDocEncryptionDataKeyToJson(this);
}
