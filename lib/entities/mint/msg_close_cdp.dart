import 'package:commerciosdk/entities/mint/close_cdp.dart';
import 'package:meta/meta.dart';
import 'package:sacco/sacco.dart';

/// Represents the transaction message that must be used when wanting
/// to close a previously opened Collateralized Debt position to get
/// back the Commercio Tokens that have been locked with it.
class MsgCloseCdp extends StdMsg {
  final CloseCdp closeCdp;

  MsgCloseCdp({
    @required this.closeCdp,
  })  : assert(closeCdp != null),
        super(type: 'commercio/MsgCloseCdp', value: <String, String>{});

  @override
  Map<String, dynamic> get value => closeCdp.toJson();
}
