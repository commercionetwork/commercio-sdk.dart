import 'package:meta/meta.dart';
import 'package:sacco/sacco.dart';

/// Represents the transaction message that must be used when wanting to open a
/// Collateralized Debt position that allows to transform the user's
/// Commercio Token into Commercio Cash Credits.
class MsgOpenCdp extends StdMsg {
  final List<StdCoin> depositAmount;
  final String signerDid;

  MsgOpenCdp({
    @required this.depositAmount,
    @required this.signerDid,
  })  : assert(depositAmount != null),
        assert(signerDid != null),
        super(type: "commercio/MsgOpenCdp", value: Map());

  @override
  Map<String, dynamic> get value => {
        'deposit_amount': depositAmount.map((coin) => coin.toJson()).toList(),
        'depositor': signerDid,
      };
}
