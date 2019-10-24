import 'package:commerciosdk/export.dart';
import 'package:meta/meta.dart';
import 'package:sacco/sacco.dart';

/// Represents the transaction message that must be used when wanting to
/// share a document from one user to another one.
class MsgShareDocument extends StdMsg {
  final String senderDid;
  final List<String> recipientDids;
  final CommercioDoc document;

  MsgShareDocument({
    @required this.senderDid,
    @required this.recipientDids,
    @required this.document,
  })  : assert(senderDid != null),
        assert(recipientDids != null),
        assert(recipientDids.isNotEmpty),
        assert(document != null),
        super(type: "commercio/MsgShareDocument", value: Map());

  @override
  Map<String, dynamic> get value => {
        'sender': senderDid,
        'recipients': recipientDids,
        'document': document.toJson(),
      };
}
