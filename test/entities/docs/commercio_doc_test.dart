import 'package:commerciosdk/entities/docs/commercio_doc.dart';
import 'package:test/test.dart';

void main() {
  final correctMetadata = CommercioDocMetadata(
    contentUri: 'content-uri',
    schemaType: 'schemaType',
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

  group('CommercioDoc', () {
    test('Null values in requirements should throw assert error', () {
      expect(
        () => CommercioDoc(
          senderDid: null,
          recipientDids: [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoc(
          senderDid: correctDid,
          recipientDids: null,
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoc(
          senderDid: correctDid,
          recipientDids: [],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoc(
          senderDid: correctDid,
          recipientDids: [correctDid],
          uuid: null,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoc(
          senderDid: correctDid,
          recipientDids: [correctDid],
          uuid: correctUuid,
          metadata: null,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('Bech32 addresses should have a valid format', () {
      // Empty did string

      expect(
        () => CommercioDoc(
          senderDid: '',
          recipientDids: [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoc(
          senderDid: correctDid,
          recipientDids: [''],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      // Malformed strings

      expect(
        () => CommercioDoc(
          senderDid: 'did:com',
          recipientDids: [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoc(
          senderDid: correctDid,
          recipientDids: ['did:com'],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      // Missing 1 as separator

      expect(
        () => CommercioDoc(
          senderDid: 'did:com:abcdefg',
          recipientDids: [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoc(
          senderDid: correctDid,
          recipientDids: ['did:com:abcdefg'],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      // Too short strings

      expect(
        () => CommercioDoc(
          senderDid: 'a1c',
          recipientDids: [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoc(
          senderDid: correctDid,
          recipientDids: ['a1c'],
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
          recipientDids: [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoc(
          senderDid: correctDid,
          recipientDids: [
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
          recipientDids: [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoc(
          senderDid: correctDid,
          recipientDids: ['did:com:1abcdef'],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      // The character i must not be contained

      expect(
        () => CommercioDoc(
          senderDid: 'did:com:1aicdefg',
          recipientDids: [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoc(
          senderDid: correctDid,
          recipientDids: ['did:com:1aicdefg'],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      // The character o must not be contained

      expect(
        () => CommercioDoc(
          senderDid: 'did:com:1aocdefg',
          recipientDids: [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoc(
          senderDid: correctDid,
          recipientDids: ['did:com:1aocdefg'],
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
          recipientDids: [correctDid],
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
          recipientDids: [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
          contentUri: invalid520CharactersString,
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('CommercioDocMetadata', () {
    test('contentUri should not be null', () {
      expect(
        () => CommercioDocMetadata(contentUri: null),
        throwsA(isA<AssertionError>()),
      );
    });

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
  });

  group('CommercioDocMetadataSchema', () {
    test('Null required parameters should throw an assert error', () {
      expect(
        () => CommercioDocMetadataSchema(
          uri: null,
          version: '1',
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDocMetadataSchema(
          uri: 'http://example.com/',
          version: null,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

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
  });

  group('CommercioDocChecksum', () {
    test('Null arguments should throw assertion erorr', () {
      expect(
        () => CommercioDocChecksum(algorithm: null, value: 'value'),
        throwsA(isA<AssertionError>()),
      );

      // Empty value also should throw
      expect(
        () => CommercioDocChecksum(algorithm: null, value: ''),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDocChecksum(
          algorithm: CommercioDocChecksumAlgorithm.MD5,
          value: null,
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('CommercioDocEncryptionData', () {
    test('Null arguments should throw assertion erorr', () {
      expect(
        () => CommercioDocEncryptionData(
          encryptedData: null,
          keys: [correctCommercioDocEncryptionDataKey],
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDocEncryptionData(
          encryptedData: [CommercioEncryptedData.CONTENT_URI],
          keys: null,
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('CommercioDocEncryptionDataKey', () {
    test('Null arguments should throw assertion erorr', () {
      expect(
        () => CommercioDocEncryptionDataKey(recipientDid: null, value: 'value'),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDocEncryptionDataKey(
          recipientDid: correctDid,
          value: null,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('value lenght should be <= 512 bytes', () {
      expect(
        () => CommercioDocEncryptionDataKey(
          recipientDid: correctDid,
          value: invalid520CharactersString,
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('CommercioDoSign', () {
    test('Null arguments should throw assertion erorr', () {
      expect(
        () => CommercioDoSign(
          certificateProfile: null,
          signerIstance: '',
          storageUri: '',
          vcrId: '',
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoSign(
          certificateProfile: '',
          signerIstance: null,
          storageUri: '',
          vcrId: '',
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoSign(
          certificateProfile: '',
          signerIstance: '',
          storageUri: null,
          vcrId: '',
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => CommercioDoSign(
          certificateProfile: '',
          signerIstance: '',
          storageUri: '',
          vcrId: null,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

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
