import 'package:meta/meta.dart';
import 'package:sacco/sacco.dart';

/// Represents the transaction message that should be used when asking
/// for a private Did power up.
class MsgRequestDidPowerUp extends StdMsg {
  final String claimantDid;
  final List<StdCoin> amount;
  final String powerUpProof;
  final String encryptionKey;

  MsgRequestDidPowerUp({
    @required this.claimantDid,
    @required this.amount,
    @required this.powerUpProof,
    @required this.encryptionKey,
  })  : assert(claimantDid != null),
        assert(amount != null),
        assert(amount.isNotEmpty),
        assert(powerUpProof != null),
        assert(encryptionKey != null),
        super(type: "commercio/MsgRequestDidPowerUp", value: Map());

  @override
  Map<String, dynamic> get value => {
        'claimant': claimantDid,
        'amount': amount.map((coin) => coin.toJson()).toList(),
        'proof': powerUpProof,
        'encryption_key': encryptionKey,
      };
}
