import 'package:commerciosdk/entities/docs/commercio_doc_receipt.dart';

import 'commercio_doc_receipt.dart' as legacy;

class CommercioDocReceiptMapper {
  static legacy.CommercioDocReceipt toLegacy(CommercioDocReceipt docReceipt) {
    return legacy.CommercioDocReceipt(
      documentUuid: docReceipt.documentUuid,
      recipientDid: docReceipt.recipientDid,
      senderDid: docReceipt.senderDid,
      txHash: docReceipt.txHash,
      uuid: docReceipt.uuid,
      proof: docReceipt.proof ?? '',
    );
  }
}
