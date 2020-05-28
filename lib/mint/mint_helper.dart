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
      openCdp: OpenCdp(
        depositAmount: [
          StdCoin(
            denom: "ucommercio",
            amount: amount.toString(),
          )
        ],
        signerDid: wallet.bech32Address,
      ),
    );
    return TxHelper.createSignAndSendTx(
      [msg],
      wallet,
      fee: fee,
      mode: mode,
    );
  }

  /// Performs a transaction opening a new CDP [openCdp] as being
  /// associated with the address present inside the specified [wallet].
  /// Optionally [fee] and broadcasting [mode] parameters can be specified.
  static Future<TransactionResult> openCdpsList(
    List<OpenCdp> openCdps,
    Wallet wallet, {
    StdFee fee,
    BroadcastingMode mode,
  }) {
    if (openCdps.length > 1) {
      throw Exception(
        'Transactions only support one "OpenCdp" message at once.',
      );
    }
    final msg = MsgOpenCdp(openCdp: openCdps.first);
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
      closeCdp: CloseCdp(
        signerDid: wallet.bech32Address,
        timeStamp: timestamp.toString(),
      ),
    );
    return TxHelper.createSignAndSendTx(
      [msg],
      wallet,
      fee: fee,
      mode: mode,
    );
  }

  /// Closes the open CDPs having the given [closeCdps] list as being
  /// associated with the address present inside the specified [wallet].
  /// Optionally [fee] and broadcasting [mode] parameters can be specified.
  static Future<TransactionResult> closeCdpsList(
    List<CloseCdp> closeCdps,
    Wallet wallet, {
    StdFee fee,
    BroadcastingMode mode,
  }) {
    final msgs = closeCdps
        .map(
          (closeCdp) => MsgCloseCdp(closeCdp: closeCdp),
        )
        .toList();
    return TxHelper.createSignAndSendTx(
      msgs,
      wallet,
      fee: fee,
      mode: mode,
    );
  }
}
