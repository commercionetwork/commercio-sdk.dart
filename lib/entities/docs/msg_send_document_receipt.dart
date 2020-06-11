import 'package:commerciosdk/export.dart';
import 'package:meta/meta.dart';
import 'package:sacco/sacco.dart';

/// Message that should be used when wanting to send a document
/// receipt transaction.
class MsgSendDocumentReceipt extends StdMsg {
  final CommercioDocReceipt receipt;

  MsgSendDocumentReceipt({
    @required this.receipt,
  }) : super(type: "commercio/MsgSendDocumentReceipt", value: Map());

  @override
  Map<String, dynamic> get value => receipt.toJson();
}
