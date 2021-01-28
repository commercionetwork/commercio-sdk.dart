import 'package:commerciosdk/entities/docs/commercio_doc_receipt.dart';
import 'package:commerciosdk/entities/docs/msg_send_document_receipt.dart';
import 'package:test/test.dart';

void main() {
  const correctCommercioDocReceipt = CommercioDocReceipt(
    uuid: 'deeb0998-15fb-4a2f-ba47-e402b9ef0ac5',
    senderDid: 'did:com:1zfhgwfgex8rc9t00pk6jm6xj6vx5cjr4ngy32v',
    recipientDid: 'did:com:1zfhgwfgex8rc9t00pk6jm6xj6vx5cjr4ngy32v',
    txHash: '922CCEE18C8EE1652756F48494B900E3835CDC370113B46D47267FA4C7A0151B',
    documentUuid: '1196e661-bbc2-43da-8184-2ebdcf02053f',
    proof: 'proof',
  );
  final correctMsgSendDocumentReceipt =
      MsgSendDocumentReceipt(receipt: correctCommercioDocReceipt);
  test('Null should throw assert error', () {
    expect(
      () => MsgSendDocumentReceipt(receipt: null),
      throwsA(isA<AssertionError>()),
    );
  });

  test('Type should be "commercio/MsgSendDocumentReceipt"', () {
    expect(
      correctMsgSendDocumentReceipt.type,
      'commercio/MsgSendDocumentReceipt',
    );
  });

  test('Value should the CommercioDocReceipt json', () {
    expect(
      correctMsgSendDocumentReceipt.value,
      correctCommercioDocReceipt.toJson(),
    );
  });
}
