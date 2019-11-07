import 'package:commerciosdk/crypto/sign_helper.dart';
import 'package:commerciosdk/entities/export.dart';
import 'package:commerciosdk/export.dart';
import 'package:commerciosdk/id/did_document_proof_signature_content.dart';
import 'package:hex/hex.dart';
import 'package:meta/meta.dart';
import 'package:sacco/sacco.dart';

/// Allows to easily create a Did Document and perform common related operations
class DidDocumentHelper {
  /// Creates a Did Document from the given [wallet] and optional [pubKeys].
  static DidDocument fromWallet(Wallet wallet, List<LocalPublicKey> pubKeys) {
    final authKeyId = '${wallet.bech32Address}#keys-1';
    final authKey = DidDocumentPublicKey(
        id: authKeyId,
        type: DidDocumentPubKeyType.SECP256K1,
        controller: wallet.bech32Address,
        publicKeyHex: HEX.encode(wallet.publicKey)
    );

    var didKeys = [authKey];
    didKeys = didKeys + mapIndexed(pubKeys, (index, item) => _convertKey(item, index + 2, wallet)
    ).toList();

    final proofContent = DidDocumentProofSignatureContent(
        context: "https://www.w3.org/2019/did/v1",
        did: wallet.bech32Address,
        publicKeys: didKeys,
        authentication: [authKeyId]
    );

    final proof = _computeProof(authKeyId, proofContent, wallet);

    return DidDocument(
        context: proofContent.context,
        id: proofContent.did,
        publicKeys: proofContent.publicKeys,
        authentication: proofContent.authentication,
        proof: proof,
        services: List()
    );

  }

  /// Converts the given [pubKey] into a [DidDocumentPublicKey] placed at position [index],
  /// [wallet] used to get the controller field of each [DidDocumentPublicKey].
  static DidDocumentPublicKey _convertKey(LocalPublicKey pubKey, int index, Wallet wallet) {
    var keyType;
    if (pubKey is LocalRSAPublicKey) {
      keyType = DidDocumentPubKeyType.RSA;
    } else if (pubKey is LocalECPublicKey) {
      keyType = DidDocumentPubKeyType.SECP256K1;
    } else if(pubKey is Ed25519Key) {
      keyType = DidDocumentPubKeyType.ED25519;
    }


    return DidDocumentPublicKey(
        id: '${wallet.bech32Address}#keys-$index',
        type: keyType,
        controller: wallet.bech32Address,
        publicKeyHex: HEX.encode(pubKey.getEncoded())
    );
  }

  /// Computes the [DidDocumentProof] based on the given [authKeyId] and [proofSignatureContent]
  static DidDocumentProof _computeProof(String authKeyId, DidDocumentProofSignatureContent proofSignatureContent, Wallet wallet) {
    return DidDocumentProof(
        type: "LinkedDataSignature2015",
        iso8601creationTimestamp: getTimeStamp(),
        creatorKeyId: authKeyId,
        signatureValue: HEX.encode(SignHelper.signSorted(proofSignatureContent.toJson(), wallet))
    );
  }


}

