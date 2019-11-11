import 'package:commerciosdk/export.dart';
import 'package:sacco/sacco.dart';

/// Allows to easily perform CommercioMINT related transactions.
class MintHelper {
  /// Opens a new CDP depositing the given Commercio Token [amount].
  static Future<TransactionResult> openCdp(int amount, Wallet wallet) {
    final msg = MsgOpenCdp(
      depositAmount: [
        StdCoin(
          denom: "ucommercio",
          amount: (amount * 1000000).toString(),
        )
      ],
      signerDid: wallet.bech32Address,
    );
    return TxHelper.createSignAndSendTx([msg], wallet);
  }

  /// Closes the CDP having the given [timestamp].
  static Future<TransactionResult> closeCdp(int timestamp, Wallet wallet) {
    final msg = MsgCloseCdp(
      timeStamp: timestamp,
      signerDid: wallet.bech32Address,
    );
    return TxHelper.createSignAndSendTx([msg], wallet);
  }
}
