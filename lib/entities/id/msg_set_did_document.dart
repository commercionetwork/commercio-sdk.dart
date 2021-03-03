import 'package:commerciosdk/export.dart';
import 'package:sacco/sacco.dart';

/// Message that must be used when setting a Did document.
class MsgSetDidDocument extends StdMsg {
  final DidDocument didDocument;

  MsgSetDidDocument({
    required this.didDocument,
  }) : super(type: 'commercio/MsgSetIdentity', value: <String, String>{});

  @override
  Map<String, dynamic> get value => didDocument.toJson();
}
