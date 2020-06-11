import 'package:commerciosdk/export.dart';

/// Allows to easily create a OpenCdp and perform common related operations
class OpenCdpHelper {
  /// Creates an OpenCdp from the given [wallet] and deposit [amount].
  static OpenCdp fromWallet(Wallet wallet, List<StdCoin> amount) {
    return OpenCdp(
      depositAmount: amount,
      signerDid: wallet.bech32Address,
    );
  }
}
