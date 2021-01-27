import 'package:commerciosdk/export.dart';

/// Allows to easily create a BurnCcc
class BurnCccHelper {
  /// Creates a BurnCcc from the given [wallet],
  /// [amount] to be burned and mint [id].
  static BurnCcc fromWallet({
    Wallet wallet,
    StdCoin amount,
    String id,
  }) {
    return BurnCcc(
      signerDid: wallet.bech32Address,
      amount: amount,
      id: id,
    );
  }
}
