import 'package:commerciosdk/entities/docs/export.dart';
import 'package:test/test.dart';

void main() {
  final correctCommercioDoc = CommercioDoc(
    senderDid: 'did:com:1acdefg',
    recipientDids: const ['did:com:1acdefg'],
    uuid: 'c510755c-c27d-4348-bf4c-f6050fc6935c',
    metadata: CommercioDocMetadata(
      contentUri: 'content-uri',
      schemaType: 'schemaType',
      schema: CommercioDocMetadataSchema(
        uri: 'http://uri.url',
        version: '1',
      ),
    ),
    contentUri: 'content-uri',
    checksum: CommercioDocChecksum(
      value: 'value',
      algorithm: CommercioDocChecksumAlgorithm.MD5,
    ),
    doSign: CommercioDoSign(
      storageUri: 'http://do.sign',
      signerIstance: 'signer',
      vcrId: 'vcrId',
      certificateProfile: 'profile',
      sdnData: const [CommercioSdnData.COMMON_NAME],
    ),
    encryptionData: CommercioDocEncryptionData(
      keys: [
        CommercioDocEncryptionDataKey(
          recipientDid: 'did:com:1acdefg',
          value: 'value',
        ),
      ],
      encryptedData: const [CommercioEncryptedData.CONTENT_URI],
    ),
  );
  final correctMsgShareDoc = MsgShareDocument(document: correctCommercioDoc);

  test('Null should throw assert error', () {
    expect(
      () => MsgShareDocument(document: null),
      throwsA(isA<AssertionError>()),
    );
  });

  test('Type should be "commercio/MsgShareDocument"', () {
    expect(
      correctMsgShareDoc.type,
      'commercio/MsgShareDocument',
    );
  });

  test('Value should the CommercioDoc json', () {
    expect(
      correctMsgShareDoc.value,
      correctCommercioDoc.toJson(),
    );
  });
}
