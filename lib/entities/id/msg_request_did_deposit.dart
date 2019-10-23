import 'package:meta/meta.dart';
import 'package:sacco/sacco.dart';

/// Represents the message that should be included into a transaction
/// when wanting to deposit a specific amount of tokens that can later
/// be used to power up private DIDs.
class MsgRequestDidDeposit extends StdMsg {
  final String recipientDid;
  final List<StdCoin> amount;
  final String depositProof;
  final String encryptionKey;
  final String senderDid;

  MsgRequestDidDeposit({
    @required this.recipientDid,
    @required this.amount,
    @required this.depositProof,
    @required this.encryptionKey,
    @required this.senderDid,
  })  : assert(recipientDid != null),
        assert(recipientDid != null),
        assert(amount != null),
        assert(amount.isNotEmpty),
        assert(depositProof != null),
        assert(encryptionKey != null),
        assert(senderDid != null),
        super(type: "commercio/MsgRequestDidDeposit", value: Map());

  @override
  Map<String, dynamic> get value => {
        'recipient': recipientDid,
        'amount': amount.map((coin) => coin.toJson()).toList(),
        'proof': depositProof,
        'encryption_key': encryptionKey,
        'from_address': senderDid,
      };
}
