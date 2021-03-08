import 'package:commerciosdk/entities/docs/commercio_doc.dart';
import 'package:test/test.dart';

void main() {
  final correctCommercioDocMetadataSchema = CommercioDocMetadataSchema(
    uri: 'http://uri.url',
    version: '1',
  );
  final correctMetadata = CommercioDocMetadata(
    contentUri: 'content-uri',
    schemaType: 'schemaType',
    schema: correctCommercioDocMetadataSchema,
  );
  const correctDid = 'did:com:1acdefg';
  const correctUuid = 'c510755c-c27d-4348-bf4c-f6050fc6935c';
  const invalid520CharactersString =
      'qYxEIgza4dfuLGka6ULnNLv8PArpjjuLoipUyoi2xon3sHAcufys3o89jRYUuGlDs68qd1NsJKAxC11InzFJBXYMaOYHFniELo2OfRN52SQReR1sShgwX5oQboUc38yITigc6pw4oBOMlz895pChLfXDAHDQSon9D11hc7AX4QkGqWxH5gdvZgrkRxTDckMJCC0mhxWi9brwwgLeTqH3sjwmVPDB5KDGMw1inp8oRSn563TEKPqd1Pp1pb06N81pI2ACkPKnLpDvYVE75vCITq8FhBBlV3neuSg5ktfAjaZ3byev0MsnPv2gwakpSgNWbVAumEA0OJuzsYDytBhUIyAM9zTpKVoVOYzks4W7jRHdiiqXs7OiyXCrgQwVyKDW1eAM9NYexYf9dUfnYja4RxVP0GSIhefun39LgrgpNDjvq2Cbrx296WGt6GLUKDxhqScPmVkvmSzT7ULklJztrA3oE3ooNVSWbq5ir772lKiuhhtFZEaPWSGeeHdmWodQoOWFFWfC';
  const invalid33CharsString = 'bKWAUWc2oBRIxFjIJrGFrT9RohFC4hXLe';
  const invalid65CharsString =
      '9S9BRIhrhaGcUvoothkdkvcil1a1Kn9AROHh4hLRCxSmZbDbfYy2NP5NjpaAQH1iX';
  final correctCommercioDocEncryptionDataKey = CommercioDocEncryptionDataKey(
    recipientDid: correctDid,
    value: 'value',
  );
  final correctCommercioDocChecksum = CommercioDocChecksum(
    value: 'value',
    algorithm: CommercioDocChecksumAlgorithm.MD5,
  );
  final correctCommercioDoSign = CommercioDoSign(
    storageUri: 'http://do.sign',
    signerIstance: 'signer',
    vcrId: 'vcrId',
    certificateProfile: 'profile',
    sdnData: const {CommercioSdnData.COMMON_NAME},
  );
  final correctCommercioEncryptionData = CommercioDocEncryptionData(
    keys: [correctCommercioDocEncryptionDataKey],
    encryptedData: const {CommercioEncryptedData.CONTENT_URI},
  );
  final correctCommercioDoc = CommercioDoc(
    senderDid: correctDid,
    recipientDids: const [correctDid],
    uuid: correctUuid,
    metadata: correctMetadata,
    contentUri: 'content-uri',
    checksum: correctCommercioDocChecksum,
    doSign: correctCommercioDoSign,
    encryptionData: correctCommercioEncryptionData,
  );

  group('CommercioDoc', () {
    test('Bech32 addresses should have a valid format', () {
      // Empty did string

      expect(
        () => CommercioDoc(
          senderDid: '',
          recipientDids: const [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoc(
          senderDid: correctDid,
          recipientDids: const [''],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      // Malformed strings

      expect(
        () => CommercioDoc(
          senderDid: 'did:com',
          recipientDids: const [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoc(
          senderDid: correctDid,
          recipientDids: const ['did:com'],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      // Missing 1 as separator

      expect(
        () => CommercioDoc(
          senderDid: 'did:com:abcdefg',
          recipientDids: const [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoc(
          senderDid: correctDid,
          recipientDids: const ['did:com:abcdefg'],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      // Too short strings

      expect(
        () => CommercioDoc(
          senderDid: 'a1c',
          recipientDids: const [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoc(
          senderDid: correctDid,
          recipientDids: const ['a1c'],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      // Too long strings

      expect(
        () => CommercioDoc(
          senderDid:
              'Y3UexQW1ZC6uXcM0ux58mnR3x4zvYaHAEA05DaC03CTcw0mmE0CaK89YD6CHmEUa05k57Dh0506CMUdNzn7QVvgYS80a5Q75lzQK',
          recipientDids: const [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoc(
          senderDid: correctDid,
          recipientDids: const [
            'Y3UexQW1ZC6uXcM0ux58mnR3x4zvYaHAEA05DaC03CTcw0mmE0CaK89YD6CHmEUa05k57Dh0506CMUdNzn7QVvgYS80a5Q75lzQK'
          ],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      // The character b must not be contained

      expect(
        () => CommercioDoc(
          senderDid: 'did:com:1abcdef',
          recipientDids: const [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoc(
          senderDid: correctDid,
          recipientDids: const ['did:com:1abcdef'],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      // The character i must not be contained

      expect(
        () => CommercioDoc(
          senderDid: 'did:com:1aicdefg',
          recipientDids: const [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoc(
          senderDid: correctDid,
          recipientDids: const ['did:com:1aicdefg'],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      // The character o must not be contained

      expect(
        () => CommercioDoc(
          senderDid: 'did:com:1aocdefg',
          recipientDids: const [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoc(
          senderDid: correctDid,
          recipientDids: const ['did:com:1aocdefg'],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('UUID must have a valid UUID v4 format', () {
      expect(
        () => CommercioDoc(
          senderDid: correctDid,
          recipientDids: const [correctDid],
          uuid: 'a1b2c3d4',
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('If contentUri is provided it should be < 512 bytes len', () {
      expect(
        () => CommercioDoc(
          senderDid: correctDid,
          recipientDids: const [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
          contentUri: invalid520CharactersString,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('Props should contains all the object fields', () {
      expect(
        correctCommercioDoc.props,
        [
          correctCommercioDoc.uuid,
          correctCommercioDoc.senderDid,
          correctCommercioDoc.recipientDids,
          correctCommercioDoc.contentUri,
          correctCommercioDoc.metadata,
          correctCommercioDoc.checksum,
          correctCommercioDoc.encryptionData,
          correctCommercioDoc.doSign,
        ],
      );
    });

    group('JSON serialization', () {
      final jsonMinimal = <String, Object>{
        'sender': correctCommercioDoc.senderDid,
        'recipients': correctCommercioDoc.recipientDids,
        'uuid': correctCommercioDoc.uuid,
        'metadata': correctCommercioDoc.metadata.toJson(),
      };

      final jsonWithContentUri = Map<String, Object>.from(jsonMinimal)
        ..addAll({'content_uri': correctCommercioDoc.contentUri!});

      final jsonWithChecksum = Map<String, Object>.from(jsonMinimal)
        ..addAll({'checksum': correctCommercioDoc.checksum!.toJson()});

      final jsonWithEncryptionData = Map<String, Object>.from(jsonMinimal)
        ..addAll({
          'encryption_data': correctCommercioDoc.encryptionData!.toJson(),
        });

      final jsonWithDoSign = Map<String, Object>.from(jsonMinimal)
        ..addAll({'do_sign': correctCommercioDoc.doSign!.toJson()})
        ..addAll({'checksum': correctCommercioDocChecksum.toJson()});

      test('fromJson() shoul behave correctly', () {
        final obj = CommercioDoc.fromJson(jsonMinimal);
        expect(
          obj.props,
          [
            correctCommercioDoc.uuid,
            correctCommercioDoc.senderDid,
            correctCommercioDoc.recipientDids,
            null,
            correctCommercioDoc.metadata,
            null,
            null,
            null,
          ],
        );

        final obj2 = CommercioDoc.fromJson(jsonWithContentUri);
        expect(
          obj2.props,
          [
            correctCommercioDoc.uuid,
            correctCommercioDoc.senderDid,
            correctCommercioDoc.recipientDids,
            correctCommercioDoc.contentUri,
            correctCommercioDoc.metadata,
            null,
            null,
            null,
          ],
        );

        final obj3 = CommercioDoc.fromJson(jsonWithChecksum);
        expect(
          obj3.props,
          [
            correctCommercioDoc.uuid,
            correctCommercioDoc.senderDid,
            correctCommercioDoc.recipientDids,
            null,
            correctCommercioDoc.metadata,
            correctCommercioDoc.checksum,
            null,
            null,
          ],
        );

        final obj4 = CommercioDoc.fromJson(jsonWithEncryptionData);
        expect(
          obj4.props,
          [
            correctCommercioDoc.uuid,
            correctCommercioDoc.senderDid,
            correctCommercioDoc.recipientDids,
            null,
            correctCommercioDoc.metadata,
            null,
            correctCommercioDoc.encryptionData,
            null,
          ],
        );

        final obj5 = CommercioDoc.fromJson(jsonWithDoSign);
        expect(
          obj5.props,
          [
            correctCommercioDoc.uuid,
            correctCommercioDoc.senderDid,
            correctCommercioDoc.recipientDids,
            null,
            correctCommercioDoc.metadata,
            correctCommercioDocChecksum,
            null,
            correctCommercioDoc.doSign,
          ],
        );
      });

      test('toJson() should behave correctly', () {
        final minimalDoc = CommercioDoc(
          uuid: correctCommercioDoc.uuid,
          senderDid: correctCommercioDoc.senderDid,
          recipientDids: correctCommercioDoc.recipientDids,
          metadata: correctCommercioDoc.metadata,
        );
        expect(minimalDoc.toJson(), jsonMinimal);

        final docWithContentUri = CommercioDoc(
          uuid: correctCommercioDoc.uuid,
          senderDid: correctCommercioDoc.senderDid,
          recipientDids: correctCommercioDoc.recipientDids,
          metadata: correctCommercioDoc.metadata,
          contentUri: correctCommercioDoc.contentUri,
        );
        expect(docWithContentUri.toJson(), jsonWithContentUri);

        final docWithChecksum = CommercioDoc(
          uuid: correctCommercioDoc.uuid,
          senderDid: correctCommercioDoc.senderDid,
          recipientDids: correctCommercioDoc.recipientDids,
          metadata: correctCommercioDoc.metadata,
          checksum: correctCommercioDoc.checksum,
        );
        expect(docWithChecksum.toJson(), jsonWithChecksum);

        final docWithEncryptionData = CommercioDoc(
          uuid: correctCommercioDoc.uuid,
          senderDid: correctCommercioDoc.senderDid,
          recipientDids: correctCommercioDoc.recipientDids,
          metadata: correctCommercioDoc.metadata,
          encryptionData: correctCommercioDoc.encryptionData,
        );
        expect(docWithEncryptionData.toJson(), jsonWithEncryptionData);

        final docWithDoSign = CommercioDoc(
          uuid: correctCommercioDoc.uuid,
          senderDid: correctCommercioDoc.senderDid,
          recipientDids: correctCommercioDoc.recipientDids,
          metadata: correctCommercioDoc.metadata,
          doSign: correctCommercioDoc.doSign,
          checksum: correctCommercioDoc.checksum,
        );
        expect(docWithDoSign.toJson(), jsonWithDoSign);
      });
    });
  });

  group('CommercioDocMetadata', () {
    test('contentUri should be < 512 bytes len', () {
      expect(
        () => CommercioDocMetadata(contentUri: invalid520CharactersString),
        throwsA(isA<AssertionError>()),
      );
    });

    test('At least one of schemaType or schema should not be null', () {
      expect(
        () => CommercioDocMetadata(contentUri: 'content-uri', schema: null),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => CommercioDocMetadata(contentUri: 'content-uri', schemaType: null),
        throwsA(isA<AssertionError>()),
      );
    });

    test('schemaType should not be empty', () {
      expect(
        () => CommercioDocMetadata(contentUri: 'content-uri', schemaType: ''),
        throwsA(isA<AssertionError>()),
      );
    });

    test('schemaType should be < 512 bytes len', () {
      expect(
        () => CommercioDocMetadata(
          contentUri: 'content-uri',
          schemaType: invalid520CharactersString,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('Props should contains all the object fields', () {
      expect(
        correctMetadata.props,
        [
          correctMetadata.contentUri,
          correctMetadata.schema,
          correctMetadata.schemaType,
        ],
      );
    });

    group('JSON serialization', () {
      final jsonWithSchemaType = <String, Object>{
        'content_uri': correctMetadata.contentUri,
        'schema_type': correctMetadata.schemaType!,
      };

      final jsonWithSchema = <String, Object>{
        'content_uri': correctMetadata.contentUri,
        'schema': {
          'uri': correctMetadata.schema!.uri,
          'version': correctMetadata.schema!.version,
        },
      };

      test('fromJson() shoul behave correctly', () {
        final obj = CommercioDocMetadata.fromJson(jsonWithSchemaType);
        expect(
          obj.props,
          [
            correctMetadata.contentUri,
            null,
            correctMetadata.schemaType,
          ],
        );

        final obj2 = CommercioDocMetadata.fromJson(jsonWithSchema);
        expect(
          obj2.props,
          [
            correctMetadata.contentUri,
            correctMetadata.schema,
            null,
          ],
        );
      });

      test('toJson() should behave correctly', () {
        final metadataWithSchemaType = CommercioDocMetadata(
          contentUri: correctMetadata.contentUri,
          schemaType: correctMetadata.schemaType,
        );
        expect(metadataWithSchemaType.toJson(), jsonWithSchemaType);

        final metadataWithSchema = CommercioDocMetadata(
          contentUri: correctMetadata.contentUri,
          schema: correctMetadata.schema,
        );
        expect(metadataWithSchema.toJson(), jsonWithSchema);
      });
    });
  });

  group('CommercioDocMetadataSchema', () {
    test('uri should be <= 512 bytes len', () {
      expect(
        () => CommercioDocMetadataSchema(
          uri: invalid520CharactersString,
          version: '1',
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('version should be <= 32 bytes len', () {
      expect(
        () => CommercioDocMetadataSchema(
          uri: 'http://example.com/',
          version: invalid33CharsString,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('Props should contains all the object fields', () {
      expect(
        correctCommercioDocMetadataSchema.props,
        [
          correctCommercioDocMetadataSchema.uri,
          correctCommercioDocMetadataSchema.version,
        ],
      );
    });

    group('JSON serialization', () {
      final json = <String, Object>{
        'uri': correctCommercioDocMetadataSchema.uri,
        'version': correctCommercioDocMetadataSchema.version,
      };

      test('fromJson() shoul behave correctly', () {
        final obj = CommercioDocMetadataSchema.fromJson(json);

        expect(
          obj.props,
          [
            correctCommercioDocMetadataSchema.uri,
            correctCommercioDocMetadataSchema.version,
          ],
        );
      });

      test('toJson() should behave correctly', () {
        expect(correctCommercioDocMetadataSchema.toJson(), json);
      });
    });
  });

  group('CommercioDocChecksum', () {
    test('Props should contains all the object fields', () {
      expect(
        correctCommercioDocChecksum.props,
        [
          correctCommercioDocChecksum.value,
          correctCommercioDocChecksum.algorithm,
        ],
      );
    });

    group('JSON serialization', () {
      final json = <String, Object>{
        'value': correctCommercioDocChecksum.value,
        'algorithm': 'md5',
      };

      test('fromJson() shoul behave correctly', () {
        final obj = CommercioDocChecksum.fromJson(json);

        expect(
          obj.props,
          [
            correctCommercioDocChecksum.value,
            correctCommercioDocChecksum.algorithm,
          ],
        );
      });

      test('toJson() should behave correctly', () {
        expect(correctCommercioDocChecksum.toJson(), json);
      });
    });
  });

  group('CommercioDocEncryptionData', () {
    test('Props should contains all the object fields', () {
      expect(
        correctCommercioEncryptionData.props,
        [
          correctCommercioEncryptionData.keys,
          correctCommercioEncryptionData.encryptedData,
        ],
      );
    });

    group('JSON serialization', () {
      final json = <String, Object>{
        'recipient': correctCommercioDocEncryptionDataKey.recipientDid,
        'value': correctCommercioDocEncryptionDataKey.value,
      };

      test('fromJson() shoul behave correctly', () {
        final obj = CommercioDocEncryptionDataKey.fromJson(json);

        expect(
          obj.props,
          [
            correctCommercioDocEncryptionDataKey.recipientDid,
            correctCommercioDocEncryptionDataKey.value,
          ],
        );
      });

      test('toJson() should behave correctly', () {
        expect(correctCommercioDocEncryptionDataKey.toJson(), json);
      });
    });
  });

  group('CommercioDocEncryptionDataKey', () {
    test('value lenght should be <= 512 bytes', () {
      expect(
        () => CommercioDocEncryptionDataKey(
          recipientDid: correctDid,
          value: invalid520CharactersString,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('Props should contains all the object fields', () {
      expect(
        correctCommercioDocEncryptionDataKey.props,
        [
          correctCommercioDocEncryptionDataKey.recipientDid,
          correctCommercioDocEncryptionDataKey.value,
        ],
      );
    });

    group('JSON serialization', () {
      final json = <String, Object>{
        'recipient': correctCommercioDocEncryptionDataKey.recipientDid,
        'value': correctCommercioDocEncryptionDataKey.value,
      };

      test('fromJson() shoul behave correctly', () {
        final obj = CommercioDocEncryptionDataKey.fromJson(json);

        expect(
          obj.props,
          [
            correctCommercioDocEncryptionDataKey.recipientDid,
            correctCommercioDocEncryptionDataKey.value,
          ],
        );
      });

      test('toJson() should behave correctly', () {
        expect(correctCommercioDocEncryptionDataKey.toJson(), json);
      });
    });
  });

  group('CommercioDoSign', () {
    test('vcrId length should be <= 64 bytes', () {
      expect(
        () => CommercioDoSign(
          certificateProfile: '',
          signerIstance: '',
          storageUri: '',
          vcrId: invalid65CharsString,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('certificateProfile length should be <= 32 bytes', () {
      expect(
        () => CommercioDoSign(
          certificateProfile: invalid33CharsString,
          signerIstance: '',
          storageUri: '',
          vcrId: '',
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('Props should contains all the object fields', () {
      expect(
        correctCommercioDoSign.props,
        [
          correctCommercioDoSign.storageUri,
          correctCommercioDoSign.signerIstance,
          correctCommercioDoSign.sdnData,
          correctCommercioDoSign.vcrId,
          correctCommercioDoSign.certificateProfile,
        ],
      );
    });

    group('JSON serialization', () {
      final minimalJson = <String, Object?>{
        'storage_uri': correctCommercioDoSign.storageUri,
        'signer_instance': correctCommercioDoSign.signerIstance,
        'vcr_id': correctCommercioDoSign.vcrId,
        'certificate_profile': correctCommercioDoSign.certificateProfile,
        'sdn_data': null,
      };

      final json2 = Map<String, Object>.from(minimalJson);
      json2['sdn_data'] = ['common_name'];

      test('fromJson() shoul behave correctly', () {
        final minimalDoSign = CommercioDoSign.fromJson(minimalJson);

        expect(
          minimalDoSign.props,
          [
            correctCommercioDoSign.storageUri,
            correctCommercioDoSign.signerIstance,
            null,
            correctCommercioDoSign.vcrId,
            correctCommercioDoSign.certificateProfile,
          ],
        );

        final doSign2 = CommercioDoSign.fromJson(json2);

        expect(
          doSign2.props,
          [
            correctCommercioDoSign.storageUri,
            correctCommercioDoSign.signerIstance,
            correctCommercioDoSign.sdnData,
            correctCommercioDoSign.vcrId,
            correctCommercioDoSign.certificateProfile,
          ],
        );
      });

      test('toJson() should behave correctly', () {
        final minDoSign = CommercioDoSign(
          storageUri: correctCommercioDoSign.storageUri,
          signerIstance: correctCommercioDoSign.signerIstance,
          vcrId: correctCommercioDoSign.vcrId,
          certificateProfile: correctCommercioDoSign.certificateProfile,
        );

        expect(minDoSign.toJson(), minimalJson);

        final doSign2 = CommercioDoSign(
          storageUri: correctCommercioDoSign.storageUri,
          signerIstance: correctCommercioDoSign.signerIstance,
          vcrId: correctCommercioDoSign.vcrId,
          certificateProfile: correctCommercioDoSign.certificateProfile,
          sdnData: correctCommercioDoSign.sdnData,
        );

        expect(doSign2.toJson(), json2);
      });
    });
  });

  group('CommercioEncryptedData should have correct extension', () {
    test('Value should return the correct string representation', () {
      expect(
        CommercioEncryptedData.values.map((v) => v.value).toList()..sort(),
        [
          'content',
          'content_uri',
          'metadata.content_uri',
          'metadata.schema.uri',
        ]..sort(),
      );
    });

    test('fromValue() should return the correct enum', () {
      expect(
        CommercioEncryptedDataExt.fromValue('content'),
        CommercioEncryptedData.CONTENT,
      );

      expect(
        CommercioEncryptedDataExt.fromValue('content_uri'),
        CommercioEncryptedData.CONTENT_URI,
      );

      expect(
        CommercioEncryptedDataExt.fromValue('metadata.content_uri'),
        CommercioEncryptedData.METADATA_CONTENT_URI,
      );

      expect(
        CommercioEncryptedDataExt.fromValue('metadata.schema.uri'),
        CommercioEncryptedData.METADATA_SCHEMA_URI,
      );
    });
  });
}
