import 'package:meta/meta.dart';
import 'package:sacco/sacco.dart';

/// Represents the transaction message that must be used when wanting to
/// invite a new user to join the system and being recognized as his invitee.
/// After doing so, if the invited user buys a membership, you will be
/// able to get a reward based on your current membership and the type
/// he has bought.
class MsgInviteUser extends StdMsg {
  final String recipientDid;
  final String senderDid;

  MsgInviteUser({
    @required this.recipientDid,
    @required this.senderDid,
  })  : assert(recipientDid != null),
        assert(senderDid != null),
        super(type: "commercio/MsgInviteUser", value: Map());

  @override
  Map<String, dynamic> get value => {
        'recipient': recipientDid,
        'sender': senderDid,
      };
}
