import 'package:commerciosdk/export.dart';

/// Allows to easily create a MintCcc
class MintCccHelper {
  /// Creates a MintCcc from the given wallet [wallet],
  /// deposit amount [amount] and mint [id].
  static MintCcc fromWallet({
    Wallet wallet,
    List<StdCoin> amount,
    String id,
  }) {
    return MintCcc(
      depositAmount: amount,
      signerDid: wallet.bech32Address,
      id: id,
    );
  }
}
