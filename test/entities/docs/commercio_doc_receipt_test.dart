import 'package:commerciosdk/entities/docs/commercio_doc_receipt.dart';
import 'package:test/test.dart';

void main() {
  final correctCommercioDocReceipt = CommercioDocReceipt(
    uuid: 'deeb0998-15fb-4a2f-ba47-e402b9ef0ac5',
    senderDid: 'did:com:1zfhgwfgex8rc9t00pk6jm6xj6vx5cjr4ngy32v',
    recipientDid: 'did:com:1zfhgwfgex8rc9t00pk6jm6xj6vx5cjr4ngy32v',
    txHash: '922CCEE18C8EE1652756F48494B900E3835CDC370113B46D47267FA4C7A0151B',
    documentUuid: '1196e661-bbc2-43da-8184-2ebdcf02053f',
    proof: 'proof',
  );

  test('Null values should throw assert errors', () {
    expect(
      () => CommercioDocReceipt(
        uuid: null,
        senderDid: correctCommercioDocReceipt.senderDid,
        recipientDid: correctCommercioDocReceipt.recipientDid,
        txHash: correctCommercioDocReceipt.txHash,
        documentUuid: correctCommercioDocReceipt.documentUuid,
      ),
      throwsA(isA<AssertionError>()),
    );

    expect(
      () => CommercioDocReceipt(
        uuid: correctCommercioDocReceipt.uuid,
        senderDid: null,
        recipientDid: correctCommercioDocReceipt.recipientDid,
        txHash: correctCommercioDocReceipt.txHash,
        documentUuid: correctCommercioDocReceipt.documentUuid,
      ),
      throwsA(isA<AssertionError>()),
    );

    expect(
      () => CommercioDocReceipt(
        uuid: correctCommercioDocReceipt.uuid,
        senderDid: correctCommercioDocReceipt.senderDid,
        recipientDid: null,
        txHash: correctCommercioDocReceipt.txHash,
        documentUuid: correctCommercioDocReceipt.documentUuid,
      ),
      throwsA(isA<AssertionError>()),
    );

    expect(
      () => CommercioDocReceipt(
        uuid: correctCommercioDocReceipt.uuid,
        senderDid: correctCommercioDocReceipt.senderDid,
        recipientDid: correctCommercioDocReceipt.recipientDid,
        txHash: null,
        documentUuid: correctCommercioDocReceipt.documentUuid,
      ),
      throwsA(isA<AssertionError>()),
    );

    expect(
      () => CommercioDocReceipt(
        uuid: correctCommercioDocReceipt.uuid,
        senderDid: correctCommercioDocReceipt.senderDid,
        recipientDid: correctCommercioDocReceipt.recipientDid,
        txHash: correctCommercioDocReceipt.txHash,
        documentUuid: null,
      ),
      throwsA(isA<AssertionError>()),
    );
  });

  test('Props should contains all the object fields', () {
    expect(
      correctCommercioDocReceipt.props,
      [
        correctCommercioDocReceipt.uuid,
        correctCommercioDocReceipt.senderDid,
        correctCommercioDocReceipt.recipientDid,
        correctCommercioDocReceipt.txHash,
        correctCommercioDocReceipt.documentUuid,
        correctCommercioDocReceipt.proof,
      ],
    );
  });

  group('JSON serialization', () {
    final json = <String, Object>{
      'uuid': correctCommercioDocReceipt.uuid,
      'sender': correctCommercioDocReceipt.senderDid,
      'recipient': correctCommercioDocReceipt.recipientDid,
      'tx_hash': correctCommercioDocReceipt.txHash,
      'document_uuid': correctCommercioDocReceipt.documentUuid,
      'proof': correctCommercioDocReceipt.proof,
    };

    test('fromJson() shoul behave correctly', () {
      final obj = CommercioDocReceipt.fromJson(json);

      expect(
        obj.props,
        [
          correctCommercioDocReceipt.uuid,
          correctCommercioDocReceipt.senderDid,
          correctCommercioDocReceipt.recipientDid,
          correctCommercioDocReceipt.txHash,
          correctCommercioDocReceipt.documentUuid,
          correctCommercioDocReceipt.proof,
        ],
      );
    });

    group('toJson() should behave correctly', () {
      test('All fields should be correctly represented', () {
        expect(correctCommercioDocReceipt.toJson(), json);
      });

      test('Null fields should not be present in json', () {
        final docRecepit = CommercioDocReceipt(
          uuid: 'deeb0998-15fb-4a2f-ba47-e402b9ef0ac5',
          senderDid: 'did:com:1zfhgwfgex8rc9t00pk6jm6xj6vx5cjr4ngy32v',
          recipientDid: 'did:com:1zfhgwfgex8rc9t00pk6jm6xj6vx5cjr4ngy32v',
          txHash:
              '922CCEE18C8EE1652756F48494B900E3835CDC370113B46D47267FA4C7A0151B',
          documentUuid: '1196e661-bbc2-43da-8184-2ebdcf02053f',
        );

        final docReceiptJson = docRecepit.toJson();

        expect(docReceiptJson.containsKey('json'), isFalse);
      });
    });
  });
}
