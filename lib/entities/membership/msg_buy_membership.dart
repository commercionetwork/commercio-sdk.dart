import 'package:commerciosdk/entities/membership/membership_type.dart';
import 'package:meta/meta.dart';
import 'package:sacco/models/export.dart';

/// Represents the transaction message that must be used when wanting to buy a membership.
class MsgBuyMembership extends StdMsg {
  final String membershipType;
  final String buyerDid;

  MsgBuyMembership({
    @required this.membershipType,
    @required this.buyerDid,
  })  : assert(membershipType != null),
        assert(buyerDid != null),
        assert(validateMembership(membershipType)),
        super(type: "commercio/MsgBuyMembership", value: Map());

  @override
  Map<String, dynamic> get value => {
        'membership_type': membershipType.toLowerCase(),
        'buyer': buyerDid,
      };
}
