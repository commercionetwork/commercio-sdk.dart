import 'package:commerciosdk/export.dart';
import 'package:meta/meta.dart';
import 'package:sacco/sacco.dart';

/// Represents the transaction message that must be used when wanting to
/// share a document from one user to another one.
class MsgShareDocument extends StdMsg {
  final CommercioDoc document;

  MsgShareDocument({
    @required this.document,
  })  : assert(document != null),
        super(type: 'commercio/MsgShareDocument', value: <String, String>{});

  @override
  Map<String, dynamic> get value => document.toJson();
}
