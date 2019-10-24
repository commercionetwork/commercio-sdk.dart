import 'package:commerciosdk/export.dart';
import 'package:sacco/sacco.dart';

/// Message that should be used when wanting to send a document
/// receipt transaction.
class MsgSendDocumentReceipt extends StdMsg {
  final CommercioDocReceipt receipt;

  MsgSendDocumentReceipt(this.receipt)
      : super(type: "commercio/MsgSendDocumentReceipt", value: Map());

  @override
  Map<String, dynamic> get value => receipt.toJson();
}
