import 'package:commerciosdk/export.dart';
import 'package:sacco/sacco.dart';

import 'commercio_doc.dart' as legacy;

/// Represents the transaction message that must be used when wanting to
/// share a document from one user to another one.
class MsgShareDocument extends StdMsg {
  final legacy.CommercioDoc document;

  MsgShareDocument({
    required this.document,
  }) : super(type: 'commercio/MsgShareDocument', value: <String, String>{});

  @override
  Map<String, dynamic> get value => document.toJson();
}
