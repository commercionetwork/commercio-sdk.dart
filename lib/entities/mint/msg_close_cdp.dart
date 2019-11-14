import 'package:meta/meta.dart';
import 'package:sacco/sacco.dart';

/// Represents the transaction message that must be used when wanting
/// to close a previously opened Collateralized Debt position to get
/// back the Commercio Tokens that have been locked with it.
class MsgCloseCdp extends StdMsg {
  final String signerDid;
  final int timeStamp;

  MsgCloseCdp({
    @required this.signerDid,
    @required this.timeStamp,
  })  : assert(signerDid != null),
        assert(timeStamp != null),
        super(type: "commercio/MsgCloseCdp", value: Map());

  @override
  Map<String, dynamic> get value => {
        'signer': this.signerDid,
        'cdp_timestamp': this.timeStamp.toString(),
      };
}
