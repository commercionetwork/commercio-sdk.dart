import 'package:commerciosdk/crypto/sign_helper.dart';
import 'package:commerciosdk/export.dart';
import 'package:hex/hex.dart';
import 'package:pointycastle/export.dart';
import 'package:sacco/sacco.dart';

/// Allows to easily create a Did Document and perform common related operations
class DidDocumentHelper {
  /// Creates a Did Document from the given [wallet] and optional [pubKeys].
  static DidDocument fromWallet(Wallet wallet, List<PublicKey> pubKeys) {
    final authKeyId = '${wallet.bech32Address}"#keys-1';
    final authKey = DidDocumentPublicKey(
        id: authKeyId,
        type: DidDocumentPubKeyType.SECP256K1,
        controller: wallet.bech32Address,
        publicKeyHex: HEX.encode(wallet.publicKey)
    );
    final proofContent = DidDocumentProof(
        type: null,
        iso8601creationTimestamp: null,
        creatorKeyId: null,
        signatureValue: null
    );
  }

}

