import 'package:commerciosdk/export.dart';

/// Allows to easily create a MintCcc
class MintCccHelper {
  /// Creates a MintCcc from the given [wallet] and deposit [amount].
  static MintCcc fromWallet({
    Wallet wallet,
    List<StdCoin> amount,
  }) {
    return MintCcc(
      depositAmount: amount,
      signerDid: wallet.bech32Address,
    );
  }
}
