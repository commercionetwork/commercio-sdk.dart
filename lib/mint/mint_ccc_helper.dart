import 'package:commerciosdk/export.dart';
import 'package:meta/meta.dart';

/// Allows to easily create a MintCcc
class MintCccHelper {
  /// Creates a MintCcc from the given wallet [wallet],
  /// deposit amount [amount] and mint [id].
  static MintCcc fromWallet({
    @required Wallet wallet,
    @required List<StdCoin> amount,
    @required String id,
  }) {
    return MintCcc(
      depositAmount: amount,
      signerDid: wallet.bech32Address,
      id: id,
    );
  }
}
