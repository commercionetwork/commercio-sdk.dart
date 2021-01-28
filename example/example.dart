import 'package:sacco/sacco.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:uuid/uuid.dart';
import 'package:commerciosdk/export.dart';

void main() async {
  // --------------------------------------------
  // --- Setup network info
  // --------------------------------------------

  const lcdUrl = 'http://localhost:1317';
  final networkInfo = NetworkInfo(
    bech32Hrp: 'did:com:',
    lcdUrl: lcdUrl,
  );

  // --------------------------------------------
  // --- Creating a wallet for setIdentity
  // --------------------------------------------

  final mnemonic = bip39.generateMnemonic(strength: 256).split(' ');
  final wallet = Wallet.derive(mnemonic, networkInfo);

  // --------------------------------------------
  // --- Creating setIdentity transaction
  // --------------------------------------------

  final rsaVerificationKeyPair = await KeysHelper.generateRsaKeyPair();
  final rsaVerificationPubKey = rsaVerificationKeyPair.publicKey;

  final rsaSignatureKeyPair =
      await KeysHelper.generateRsaKeyPair(type: 'RsaSignatureKey2018');
  final rsaSignaturePubKey = rsaSignatureKeyPair.publicKey;

  try {
    final didDocument = DidDocumentHelper.fromWallet(
        wallet, [rsaVerificationPubKey, rsaSignaturePubKey]);
    print('DDO:\n${didDocument.toJson()}');
    print('');

    final response = await IdHelper.setDidDocumentsList([didDocument], wallet);

    if (response.success) {
      print('TX successfully sent:\n$lcdUrl/txs/${response.hash}');
      print('----- You can retrive your did from below url -----');
      print('Endpoint:\n$lcdUrl/identities/${wallet.bech32Address}');
    } else {
      print('TX error:\n${response.error.errorMessage}');
    }
  } catch (error) {
    print('Error while testing set DDO:\n$error');
  }

  // --------------------------------------------
  // --- Creating wallets for shareDocument
  // --------------------------------------------

  final senderMnemonic = bip39.generateMnemonic(strength: 256).split(' ');
  final senderWallet = Wallet.derive(senderMnemonic, networkInfo);

  final recipientMnemonic = bip39.generateMnemonic(strength: 256).split(' ');
  final recipientWallet = Wallet.derive(recipientMnemonic, networkInfo);

  // --------------------------------------------
  // --- Creating a shareDocument transaction
  // --------------------------------------------

  final docRecipientDid = recipientWallet.bech32Address;
  final docId = Uuid().v4();

  final checksum = CommercioDocChecksum(
    value: 'a00ab326fc8a3dd93ec84f7e7773ac2499b381c4833e53110107f21c3b90509c',
    algorithm: CommercioDocChecksumAlgorithm.SHA256,
  );

  final doSign = CommercioDoSign(
    storageUri: 'http://www.commercio.network',
    signerIstance: 'did:com:1cc65t29yuwuc32ep2h9uqhnwrregfq230lf2rj',
    sdnData: const [
      CommercioSdnData.COMMON_NAME,
      CommercioSdnData.SURNAME,
    ],
    vcrId: 'xxxxx',
    certificateProfile: 'xxxxx',
  );

  try {
    final commercioDoc = await CommercioDocHelper.fromWallet(
      wallet: senderWallet,
      recipients: [docRecipientDid],
      id: docId,
      metadata: CommercioDocMetadata(
        contentUri: 'https://example.com/document/metadata',
        schema: CommercioDocMetadataSchema(
          uri: 'https://example.com/custom/metadata/schema',
          version: '7.0.0',
        ),
      ),
      contentUri: 'https://example.com/document',
      checksum: checksum,
      doSign: doSign,
      encryptedData: [CommercioEncryptedData.CONTENT_URI],
    );
    final response = await DocsHelper.shareDocumentsList(
      [commercioDoc],
      senderWallet,
    );

    if (response.success) {
      print('TX successfully sent:\n$lcdUrl/txs/${response.hash}');
      print('----- You can retrive your sent documents from url below -----');
      print('Endpoint:\n$lcdUrl/docs/${senderWallet.bech32Address}/sent');
    } else {
      print('TX error:\n${response.error.errorMessage}');
    }
  } catch (error) {
    print('Error while sharing a document:\n$error');
  }
}
