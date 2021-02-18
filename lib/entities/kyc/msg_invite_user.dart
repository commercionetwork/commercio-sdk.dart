import 'package:commerciosdk/export.dart';
import 'package:meta/meta.dart';

/// Represents the transaction message that must be used when wanting to
/// invite a new user to join the system and being recognized as his invitee.
/// After doing so, if the invited user buys a membership, you will be
/// able to get a reward based on your current membership and the type
/// he has bought.
class MsgInviteUser extends StdMsg {
  final InviteUser inviteUser;

  MsgInviteUser({
    @required this.inviteUser,
  })  : assert(inviteUser != null),
        super(type: 'commercio/MsgInviteUser', value: <String, String>{});

  @override
  Map<String, dynamic> get value => inviteUser.toJson();
}
