import 'package:commerciosdk/export.dart';
import 'package:sacco/sacco.dart';

/// Allows to easily perform CommercioMINT related transactions.
class MintHelper {
  /// Performs a transaction opening a new CDP [openCdp] as being
  /// associated with the address present inside the specified [wallet].
  /// Optionally [fee] and broadcasting [mode] parameters can be specified.
  static Future<TransactionResult> openCdp(
    OpenCdp openCdp,
    Wallet wallet, {
    StdFee fee,
    BroadcastingMode mode,
  }) {
    final msg = MsgOpenCdp(openCdp: openCdp);
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
