import 'package:commerciosdk/export.dart';
import 'package:sacco/sacco.dart';

/// Allows to easily perform CommercioMINT related transactions.
class MintHelper {
  /// Opens a new CDP depositing the given Commercio Token [amount].
  /// Optionally [fee] and broadcasting [mode] parameters can be specified.
  static Future<TransactionResult> openCdp(
    int amount,
    Wallet wallet, {
    StdFee fee,
    BroadcastingMode mode,
  }) {
    final msg = MsgOpenCdp(
      depositAmount: [
        StdCoin(
          denom: "ucommercio",
          amount: amount.toString(),
        )
      ],
      signerDid: wallet.bech32Address,
    );
    return TxHelper.createSignAndSendTx(
      [msg],
      wallet,
      fee: fee,
      mode: mode,
    );
  }

  /// Closes the CDP having the given [timestamp].
  /// Optionally [fee] and broadcasting [mode] parameters can be specified.
  static Future<TransactionResult> closeCdp(
    int timestamp,
    Wallet wallet, {
    StdFee fee,
    BroadcastingMode mode,
  }) {
    final msg = MsgCloseCdp(
      timeStamp: timestamp,
      signerDid: wallet.bech32Address,
    );
    return TxHelper.createSignAndSendTx(
      [msg],
      wallet,
      fee: fee,
      mode: mode,
    );
  }
}
