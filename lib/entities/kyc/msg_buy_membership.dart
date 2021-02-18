import 'package:commerciosdk/export.dart';
import 'package:meta/meta.dart';

/// Represents the transaction message that must be used when wanting to buy a membership.
class MsgBuyMembership extends StdMsg {
  final BuyMembership buyMembership;

  MsgBuyMembership({
    @required this.buyMembership,
  })  : assert(buyMembership != null),
        super(type: 'commercio/MsgBuyMembership', value: <String, String>{});

  @override
  Map<String, dynamic> get value => buyMembership.toJson();
}
