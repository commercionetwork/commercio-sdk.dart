import 'package:commerciosdk/export.dart';
import 'package:commerciosdk/mint/export.dart';
import 'package:commerciosdk/mint/open_cdp_helper.dart';
import 'package:sacco/sacco.dart';

/// Allows to easily perform CommercioMINT related transactions.
class MintHelper {
  /// Mints the CCCs having the given [mintCccs] list as being
  /// associated with the address present inside the specified [wallet].
  /// Optionally [fee] and broadcasting [mode] parameters can be specified.
  static Future<TransactionResult> mintCccsList(
    List<MintCcc> mintCccs,
    Wallet wallet, {
    StdFee fee,
    BroadcastingMode mode,
  }) {
    final msgs =
        mintCccs.map((mintCcc) => MsgMintCcc(mintCcc: mintCcc)).toList();

    return TxHelper.createSignAndSendTx(
      msgs,
      wallet,
      fee: fee,
      mode: mode,
    );
  }

  /// Burns the CCCs having the given [burnCccs] list as being
  /// associated with the address present inside the specified [wallet].
  /// Optionally [fee] and broadcasting [mode] parameters can be specified.
  static Future<TransactionResult> burnCccsList(
    List<BurnCcc> burnCccs,
    Wallet wallet, {
    StdFee fee,
    BroadcastingMode mode,
  }) {
    final msgs =
        burnCccs.map((burnCcc) => MsgBurnCcc(burnCcc: burnCcc)).toList();

    return TxHelper.createSignAndSendTx(
      msgs,
      wallet,
      fee: fee,
      mode: mode,
    );
  }

  /// Opens a new CDP depositing the given Commercio Token [amount].
  /// Optionally [fee] and broadcasting [mode] parameters can be specified.
  static Future<TransactionResult> openCdp(
    int amount,
    Wallet wallet, {
    StdFee fee,
    BroadcastingMode mode,
  }) {
    final depositAmount = [
      StdCoin(
        denom: 'ucommercio',
        amount: amount.toString(),
      )
    ];
    final openCdp = OpenCdpHelper.fromWallet(wallet, depositAmount);
    final msg = MsgOpenCdp(
      openCdp: openCdp,
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
  static Future<TransactionResult> openCdpSingle(
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
    final closeCdp = CloseCdpHelper.fromWallet(wallet, timestamp);
    final msg = MsgCloseCdp(
      closeCdp: closeCdp,
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
