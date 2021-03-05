import 'dart:convert';

import 'package:commerciosdk/export.dart';
import 'package:sacco/sacco.dart';

/// Allows to easily create a Did Document and perform common related operations
class DidDocumentHelper {
  /// Creates a Did Document from the given [wallet], [pubKeys] and optional [service].
  static DidDocument fromWallet({
    required Wallet wallet,
    required List<CommercioPublicKey> pubKeys,
    List<DidDocumentService>? service,
  }) {
    if (pubKeys.length < 2) {
      throw ArgumentError('At least two keys are required');
    }

    final keys = mapIndexed<DidDocumentPublicKey, CommercioPublicKey>(
      pubKeys,
      (index, item) => _convertKey(item, index + 1, wallet),
    ).toList();

    final proofContent = DidDocumentProofSignatureContent(
      context: 'https://www.w3.org/ns/did/v1',
      id: wallet.bech32Address,
      publicKeys: keys,
      service: service,
    );

    final verificationMethod = wallet.bech32PublicKey;

    final proof = _computeProof(
      controller: proofContent.id,
      verificationMethod: verificationMethod,
      proofSignatureContent: proofContent,
      wallet: wallet,
    );

    return DidDocument(
      context: proofContent.context,
      id: proofContent.id,
      publicKeys: proofContent.publicKeys,
      proof: proof,
      service: service,
    );
  }

  /// Converts the given [pubKey] into a [DidDocumentPublicKey] placed at position [index],
  /// [wallet] used to get the controller field of each [DidDocumentPublicKey].
  static DidDocumentPublicKey _convertKey(
    CommercioPublicKey pubKey,
    int index,
    Wallet wallet,
  ) {
    return DidDocumentPublicKey(
      id: '${wallet.bech32Address}#keys-$index',
      type: pubKey.getType(),
      controller: wallet.bech32Address,
      publicKeyPem: pubKey.getEncoded(),
    );
  }

  /// Computes the [DidDocumentProof] based on the given [controller], [verificationMethod] and [proofSignatureContent]
  static DidDocumentProof _computeProof({
    required String controller,
    required String verificationMethod,
    required DidDocumentProofSignatureContent proofSignatureContent,
    required Wallet wallet,
    String? proofPurpose,
  }) {
    proofPurpose = proofPurpose ?? 'authentication';

    return DidDocumentProof(
      type: 'EcdsaSecp256k1VerificationKey2019',
      timestamp: getTimeStamp(),
      proofPurpose: proofPurpose,
      controller: controller,
      verificationMethod: verificationMethod,
      signatureValue: base64Encode(
        SignHelper.signSorted(proofSignatureContent.toJson(), wallet),
      ),
    );
  }
}
