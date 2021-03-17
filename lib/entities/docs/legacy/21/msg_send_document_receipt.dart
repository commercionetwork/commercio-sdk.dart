import 'package:commerciosdk/export.dart';

import 'commercio_doc_receipt.dart' as legacy;

/// Message that should be used when wanting to send a document
/// receipt transaction.
class MsgSendDocumentReceipt extends StdMsg {
  final legacy.CommercioDocReceipt receipt;

  MsgSendDocumentReceipt({required this.receipt})
      : super(
            type: 'commercio/MsgSendDocumentReceipt',
            value: <String, String>{});

  @override
  Map<String, dynamic> get value => receipt.toJson();
}
