import 'package:commerciosdk/export.dart';

/// Allows to easily create a CloseCdp and perform common related operations
class CloseCdpHelper {
  /// Creates a CloseCdp from the given [wallet] and [timeStamp].
  /// N.B.: [timeStamp] is the 'height' at which the position was opened
  static CloseCdp fromWallet(Wallet wallet, int timeStamp) {
    return CloseCdp(
      signerDid: wallet.bech32Address,
      timeStamp: timeStamp.toString(),
    );
  }
}
