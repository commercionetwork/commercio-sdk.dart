import 'package:sacco/sacco.dart';

/// Allows to easily perform common transaction operations.
class TxHelper {
  static const defaultGas = "200000";
  static const defaultDenom = "ucommercio";
  static const defaultAmount = "10000";

  /// Creates a transaction having the given [msgs],
  /// signs it with the given [Wallet] and sends it to the blockchain.
  /// Optional parameters can be [fee] and broadcasting [mode],
  /// that can be of type "sync", "async" or "block".
  static Future<TransactionResult> createSignAndSendTx(
    List<StdMsg> msgs,
    Wallet wallet, {
    StdFee fee,
    String mode,
  }) async {
    fee = fee ??
        const StdFee(gas: defaultGas, amount: [
          const StdCoin(denom: defaultDenom, amount: defaultAmount)
        ]);
    mode = mode ?? "sync";

    final stdTx = TxBuilder.buildStdTx(stdMsgs: msgs, fee: fee);
    final signedTx = await TxSigner.signStdTx(wallet: wallet, stdTx: stdTx);
    return TxSender.broadcastStdTx(
      wallet: wallet,
      stdTx: signedTx,
      mode: mode,
    );
  }
}
