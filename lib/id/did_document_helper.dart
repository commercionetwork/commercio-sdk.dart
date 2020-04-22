import 'package:commerciosdk/export.dart';
import 'package:hex/hex.dart';
import 'package:sacco/sacco.dart';
import 'package:sacco/utils/bech32_encoder.dart';

/// Allows to easily create a Did Document and perform common related operations
class DidDocumentHelper {
  /// Creates a Did Document from the given [wallet] and optional [pubKeys].
  static DidDocument fromWallet(Wallet wallet, List<PublicKey> pubKeys) {
    final authKeyId = '${wallet.bech32Address}#keys-1';
    final authKey = DidDocumentPublicKey(
      id: authKeyId,
      type: DidDocumentPubKeyType.SECP256K1,
      controller: wallet.bech32Address,
      publicKeyPem: HEX.encode(wallet.publicKey),
    );

    final otherKeys = mapIndexed(
            pubKeys, (index, item) => _convertKey(item, index + 2, wallet))
        .toList();

    final bech32Hrp = "did:com:";
    final data = Uint8List.fromList(wallet.publicKey);
    final verificationMethod = Bech32Encoder.encode(bech32Hrp, data);

    final proofContent = DidDocumentProofSignatureContent(
      context: "https://www.w3.org/ns/did/v1",
      did: wallet.bech32Address,
      publicKeys: [authKey] + otherKeys,
      authentication: [authKeyId],
    );

    final proof =
        _computeProof(authKeyId, verificationMethod, proofContent, wallet);

    return DidDocument(
      context: proofContent.context,
      id: proofContent.did,
      publicKeys: proofContent.publicKeys,
      authentication: proofContent.authentication,
      proof: proof,
      services: null,
    );
  }

  /// Converts the given [pubKey] into a [DidDocumentPublicKey] placed at position [index],
  /// [wallet] used to get the controller field of each [DidDocumentPublicKey].
  static DidDocumentPublicKey _convertKey(
      PublicKey pubKey, int index, Wallet wallet) {
    var keyType;
    if (pubKey is RSAPublicKey) {
      keyType = DidDocumentPubKeyType.RSA;
    } else if (pubKey is ECPublicKey) {
      keyType = DidDocumentPubKeyType.SECP256K1;
    } else if (pubKey is Ed25519PublicKey) {
      keyType = DidDocumentPubKeyType.ED25519;
    }

    return DidDocumentPublicKey(
      id: '${wallet.bech32Address}#keys-$index',
      type: keyType,
      controller: wallet.bech32Address,
      publicKeyPem: HEX.encode(pubKey.getEncoded()),
    );
  }

  /// Computes the [DidDocumentProof] based on the given [authKeyId] and [proofSignatureContent]
  static DidDocumentProof _computeProof(
    String authKeyId,
    String verificationMethod,
    DidDocumentProofSignatureContent proofSignatureContent,
    Wallet wallet,
  ) {
    return DidDocumentProof(
      type: "LinkedDataSignature2015",
      iso8601creationTimestamp: getTimeStamp(),
      proofPurpose: "authentication",
      controller: authKeyId,
      verificationMethod: verificationMethod,
      signatureValue: HEX.encode(
        SignHelper.signSorted(proofSignatureContent.toJson(), wallet),
      ),
    );
  }
}
