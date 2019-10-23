import 'package:commerciosdk/export.dart';
import 'package:meta/meta.dart';
import 'package:sacco/sacco.dart';

/// Message that must be used when setting a Did document.
class MsgSetDidDocument extends StdMsg {
  final DidDocument didDocument;

  MsgSetDidDocument({
    @required this.didDocument,
  })  : assert(didDocument != null),
        super(type: "commercio/MsgSetIdentity", value: Map());

  @override
  Map<String, dynamic> get value => didDocument.toJson();
}
