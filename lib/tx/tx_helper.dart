import 'package:sacco/sacco.dart';

/// Allows to easily perform common transaction operations.
class TxHelper {
  /// Creates a transaction having the given [msgs] and [fee] inside,
  /// signs it with the given [Wallet] and sends it to the blockchain.
  static Future<TransactionResult> createSignAndSendTx(
    List<StdMsg> msgs,
    Wallet wallet, {
    StdFee fee = const StdFee(
        gas: "200000",
        amount: [const StdCoin(denom: "ucommercio", amount: "100")]),
  }) async {
    final stdTx = TxBuilder.buildStdTx(stdMsgs: msgs, fee: fee);
    final signedTx = await TxSigner.signStdTx(wallet: wallet, stdTx: stdTx);
    return TxSender.broadcastStdTx(wallet: wallet, stdTx: signedTx);
  }
}
