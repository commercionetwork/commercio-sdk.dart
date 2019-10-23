import 'package:commerciosdk/export.dart';
import 'package:sacco/sacco.dart';

/// Allows to easily perform CommercioMINT related transactions.
class MintHelper {
  /// Opens a new CDP depositing the given [commercioTokenAmount].
  static Future<TransactionResult> openCdp(
    int commercioTokenAmount,
    Wallet wallet,
  ) {
    final msg = MsgOpenCdp(
      depositAmount: [
        StdCoin(
          denom: "ucommercio",
          amount: (commercioTokenAmount * 1000000).toString(),
        )
      ],
      signerDid: wallet.bech32Address,
      timeStamp: Utils.getTimeStamp(),
    );
    return TxHelper.createSignAndSendTx([msg], wallet);
  }

  /// Closes the CDP having the given [timestamp].
  static Future<TransactionResult> closeCdp(
    String timestamp,
    Wallet wallet,
  ) {
    final msg = MsgCloseCdp(
      timeStamp: timestamp,
      signerDid: wallet.bech32Address,
    );
    return TxHelper.createSignAndSendTx([msg], wallet);
  }
}
