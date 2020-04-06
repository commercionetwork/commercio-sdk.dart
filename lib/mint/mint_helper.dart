import 'package:commerciosdk/export.dart';
import 'package:sacco/sacco.dart';

/// Allows to easily perform CommercioMINT related transactions.
class MintHelper {
  /// Opens a new CDP depositing the given Commercio Token [amount].
  static Future<TransactionResult> openCdp(int amount, Wallet wallet,
      {StdFee fee}) {
    final depositAmount = fee.amount
        .map((stdCoin) => StdCoin(
            denom: stdCoin.denom,
            amount: (stdCoin.amount * 1000000).toString()))
        .toList();
    final msg = MsgOpenCdp(
      depositAmount: depositAmount,
      signerDid: wallet.bech32Address,
    );
    return TxHelper.createSignAndSendTx([msg], wallet);
  }

  /// Closes the CDP having the given [timestamp].
  static Future<TransactionResult> closeCdp(int timestamp, Wallet wallet,
      {StdFee fee}) {
    final msg = MsgCloseCdp(
      timeStamp: timestamp,
      signerDid: wallet.bech32Address,
    );
    return TxHelper.createSignAndSendTx([msg], wallet, fee: fee);
  }
}
