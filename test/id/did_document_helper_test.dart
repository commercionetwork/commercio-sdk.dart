import 'package:commerciosdk/crypto/export.dart' as local;
import 'package:commerciosdk/entities/export.dart';
import 'package:commerciosdk/export.dart';
import 'package:commerciosdk/id/did_document_helper.dart';
import 'package:sacco/sacco.dart';
import 'package:test/test.dart';

void main() {
  final networkInfo = NetworkInfo(bech32Hrp: "did:com:", lcdUrl: "");
  final mnemonicString = "dash ordinary anxiety zone slot rail flavor tortoise guilt divert pet "
      "sound ostrich increase resist short ship lift town ice split payment round apology";
  final mnemonic = mnemonicString.split(" ");
  final wallet = Wallet.derive(mnemonic, networkInfo);

  final modulus = BigInt.from(125);
  final exponent = BigInt.from(126);
  final rsaPubKey = RSAPubKey(local.RSAPublicKey(modulus, exponent));

  final expectedPubKey = DidDocumentPublicKey(id: '${wallet.bech32Address}#keys-2',
      type: DidDocumentPubKeyType.RSA, controller: wallet.bech32Address, publicKeyHex: "300602017d02017e");
  final expectedAuthKey = DidDocumentPublicKey(
    id: '${wallet.bech32Address}#keys-1',
    type: DidDocumentPubKeyType.SECP256K1,
    controller: wallet.bech32Address,
    publicKeyHex: "0261789822ac69c632dcbab267bf3ff544fdd8ea55a373ef0c320bef9f55f8611e"
  );

  final expectedComputedProof = DidDocumentProof(
    type: "LinkedDataSignature2015",
    iso8601creationTimestamp: getTimeStamp(),
    creatorKeyId: expectedPubKey.id,
    signatureValue: "625ec032c14affec8f1e4d78b55f7eeb225c4ef98daed5f601d0f436e0bb8bd27bbf3f208af28af9fe59b6beed364765f14423e0ebcd675e2a9dead77d73d892",
  );

  final expectedDidDocument = DidDocument(
      context: "https://www.w3.org/2019/did/v1",
      id: wallet.bech32Address,
      publicKeys: [expectedAuthKey, expectedPubKey],
      authentication: [expectedAuthKey.id],
      proof: expectedComputedProof,
      services: List()
  );

  test("fromWallet return a well-formed, ready to be send to blockchain, did document", (){
    final didDocument = DidDocumentHelper.fromWallet(wallet, [rsaPubKey]);
    expect(didDocument.context, expectedDidDocument.context);
    expect(didDocument.id, expectedDidDocument.id);
    expect(didDocument.publicKeys, expectedDidDocument.publicKeys);
    expect(didDocument.authentication, expectedDidDocument.authentication);
  });

  /*
  group("Private functions tests, runs only when _ is removed from functions name", (){
    test("_convertKey converts the LocalPublicKey given into the correct DidDocumentPublicKey", (){
      final ddoPublicKey = DidDocumentHelper.convertKey(rsaPubKey, 2, wallet);
      expect(ddoPublicKey, expectedPubKey);
    });
    test("_computeProof create the did document proof correctly", () {
      final ddoProofSignatureContent = DidDocumentProofSignatureContent(
        context: "https://www.w3.org/2019/did/v1",
        did: wallet.bech32Address,
        publicKeys: [expectedPubKey],
        authentication: [expectedPubKey.id],
      );
      final computedProof = DidDocumentHelper.computeProof(expectedPubKey.id, ddoProofSignatureContent, wallet);
      expect(computedProof.type, expectedComputedProof.type);
      expect(computedProof.creatorKeyId, expectedComputedProof.creatorKeyId);
      expect(computedProof.signatureValue, expectedComputedProof.signatureValue);
      expect(computedProof.iso8601creationTimestamp, isNot(expectedComputedProof.iso8601creationTimestamp));
    });
  });
  */
}
