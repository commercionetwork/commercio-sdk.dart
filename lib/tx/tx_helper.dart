import 'package:sacco/sacco.dart';

/// Allows to easily perform common transaction operations.
class TxHelper {
  static const defaultGas = "200000";
  static const defaultDenom = "ucommercio";
  static const defaultAmount = "10000";

  /// Creates a transaction having the given [msgs] and [fee] inside,
  /// signs it with the given [Wallet] and sends it to the blockchain.
  static Future<TransactionResult> createSignAndSendTx(
    List<StdMsg> msgs,
    Wallet wallet, {
    StdFee fee,
  }) async {
    fee = fee ??
        const StdFee(gas: defaultGas, amount: [
          const StdCoin(denom: defaultDenom, amount: defaultAmount)
        ]);

    final stdTx = TxBuilder.buildStdTx(stdMsgs: msgs, fee: fee);
    final signedTx = await TxSigner.signStdTx(wallet: wallet, stdTx: stdTx);
    return TxSender.broadcastStdTx(wallet: wallet, stdTx: signedTx);
  }
}
