import 'package:sacco/sacco.dart';

/// Allows to easily perform common transaction operations.
class TxHelper {
  static const defaultAmount = 10000;
  static const defaultDenom = "ucommercio";
  static const defaultGas = 200000;

  /// Creates a transaction having the given [msgs],
  /// signs it with the given [Wallet] and sends it to the blockchain.
  /// Optional parameters can be [fee] and broadcasting [mode],
  /// that can be of type "sync", "async" or "block".
  static Future<TransactionResult> createSignAndSendTx(
    List<StdMsg> msgs,
    Wallet wallet, {
    StdFee fee,
    BroadcastingMode mode,
  }) async {
    fee = fee ?? _calculateFee(msgs.length);
    mode = mode ?? BroadcastingMode.SYNC;

    final stdTx = TxBuilder.buildStdTx(stdMsgs: msgs, fee: fee);
    final signedTx = await TxSigner.signStdTx(wallet: wallet, stdTx: stdTx);
    return TxSender.broadcastStdTx(
      wallet: wallet,
      stdTx: signedTx,
      mode: mode.value,
    );
  }

  static StdFee _calculateFee(int msgsAmount) {
    final fee = msgsAmount > 1
        ? StdFee(
            gas: (defaultGas * msgsAmount).toString(),
            amount: [
              StdCoin(
                denom: defaultDenom,
                amount: (defaultAmount * msgsAmount).toString(),
              ),
            ],
          )
        : StdFee(
            gas: defaultGas.toString(),
            amount: [
              StdCoin(
                denom: defaultDenom,
                amount: defaultAmount.toString(),
              ),
            ],
          );

    return fee;
  }
}

enum BroadcastingMode {
  ASYNC,
  BLOCK,
  SYNC,
}

extension BroadcastingModeExt on BroadcastingMode {
  String get value {
    switch (this) {
      case BroadcastingMode.ASYNC:
        return 'async';
      case BroadcastingMode.BLOCK:
        return 'block';
      case BroadcastingMode.SYNC:
        return 'sync';
      default:
        return null;
    }
  }
}
