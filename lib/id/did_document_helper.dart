import 'package:commerciosdk/export.dart';
import 'package:hex/hex.dart';
import 'package:sacco/sacco.dart';
import 'package:sacco/utils/bech32_encoder.dart';

/// Allows to easily create a Did Document and perform common related operations
class DidDocumentHelper {
  /// Creates a Did Document from the given [wallet].
  static DidDocument fromWallet(Wallet wallet) {
    final firstKey = DidDocumentPublicKey(
      id: '${wallet.bech32Address}#keys-1',
      type: DidDocumentPubKeyType.RSA,
      controller: wallet.bech32Address,
      publicKeyPem: HEX.encode(wallet.publicKey),
    );
    final secondKey = DidDocumentPublicKey(
      id: '${wallet.bech32Address}#keys-2',
      type: DidDocumentPubKeyType.RSA_SIG,
      controller: wallet.bech32Address,
      publicKeyPem: HEX.encode(wallet.publicKey),
    );
    final publicKeys = [firstKey, secondKey];

    final prefix = "did:com:pub";
    final verificationMethod = Bech32Encoder.encode(prefix, wallet.publicKey);

    final proofContent = DidDocumentProofSignatureContent(
      context: "https://www.w3.org/ns/did/v1",
      did: wallet.bech32Address,
      publicKeys: publicKeys,
    );

    final proof =
        _computeProof(proofContent.did, verificationMethod, proofContent, wallet);

    return DidDocument(
      context: proofContent.context,
      id: proofContent.did,
      publicKeys: proofContent.publicKeys,
      proof: proof,
      services: null,
    );
  }

  /// Computes the [DidDocumentProof] based on the given [controller], [verificationMethod] and [proofSignatureContent]
  static DidDocumentProof _computeProof(
    String controller,
    String verificationMethod,
    DidDocumentProofSignatureContent proofSignatureContent,
    Wallet wallet, {
    String proofPurpose,
  }) {
    proofPurpose = proofPurpose ?? "authentication";
    
    return DidDocumentProof(
      type: "EcdsaSecp256k1VerificationKey2019",
      iso8601creationTimestamp: getTimeStamp(),
      proofPurpose: proofPurpose,
      controller: controller,
      verificationMethod: verificationMethod,
      signatureValue: HEX.encode(
        SignHelper.signSorted(proofSignatureContent.toJson(), wallet),
      ),
    );
  }
}
