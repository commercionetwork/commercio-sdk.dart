import 'package:commerciosdk/export.dart';
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
}
