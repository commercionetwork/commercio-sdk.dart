import 'package:commerciosdk/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:sacco/sacco.dart';

/// Allows to easily perform common transaction operations.
class TxHelper {
  static const defaultAmount = 10000;
  static const defaultDenom = 'ucommercio';
  static const defaultGas = 200000;

  /// Creates a transaction having the given [msgs],
  /// signs it with the given [Wallet] and sends it to the blockchain.
  /// Optional parameters can be [fee] and broadcasting [mode],
  /// that can be of type "sync", "async" or "block".
  static Future<TransactionResult> createSignAndSendTx(
    List<StdMsg> msgs,
    Wallet wallet, {
    StdFee? fee,
    BroadcastingMode? mode,
    http.Client? client,
  }) async {
    // Set values for optional parameters

    final msgsNumber = msgs.isNotEmpty ? msgs.length : 1;
    fee = fee ??
        calculateDefaultFee(
          msgsNumber: msgsNumber,
          fee: defaultAmount,
          denom: defaultDenom,
          gas: defaultGas,
        );
    mode = mode ?? BroadcastingMode.SYNC;

    final stdTx = TxBuilder.buildStdTx(stdMsgs: msgs, fee: fee);
    final signedTx = await TxSigner.signStdTx(
      wallet: wallet,
      stdTx: stdTx,
      client: client,
    );
    return TxSender.broadcastStdTx(
      wallet: wallet,
      stdTx: signedTx,
      mode: mode.value,
    );
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
    }
  }
}
