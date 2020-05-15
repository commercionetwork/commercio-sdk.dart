import 'dart:convert';

import 'package:commerciosdk/export.dart';
import 'package:sacco/sacco.dart';
import 'package:uuid/uuid.dart';

/// Allows to perform common operations related to CommercioID.
class IdHelper {
  /// Returns the Did Document associated with the given [did],
  /// or `null` if no Did Document was found.
  static Future<DidDocument> getDidDocument(String did, Wallet wallet) async {
    final url = "${wallet.networkInfo.lcdUrl}/identities/${did}";
    final response = await Network.queryChain(url);
    if (response == null) {
      return null;
    }

    return DidDocument.fromJson(response["did_document"]);
  }

  /// Performs a transaction setting the specified [didDocument] as being
  /// associated with the address present inside the specified [wallet].
  static Future<TransactionResult> setDidDocument(
      DidDocument didDocument, Wallet wallet,
      {StdFee fee}) {
    final msg = MsgSetDidDocument(didDocument: didDocument);
    return TxHelper.createSignAndSendTx([msg], wallet, fee: fee);
  }

  /// Creates a new Did power up request for the given [pairwiseDid] and of the given [amount].
  /// Signs everything that needs to be signed (i.e. the signature JSON inside the payload) with the
  /// private key contained inside the given [wallet].
  static Future<TransactionResult> requestDidPowerUp(String pairwiseDid,
      List<StdCoin> amount, Wallet wallet, RSAPrivateKey privateKey,
      {StdFee fee}) async {
    // Get the timestamp
    final timestamp = DateTime.now().toUtc().millisecondsSinceEpoch.toString();

    // Build the signature
    final signatureJson = DidPowerUpRequestSignatureJson(
      senderDid: wallet.bech32Address,
      pairwiseDid: pairwiseDid,
      timestamp: timestamp,
    );

    // Sign the signature
    final signedSignatureHash = SignHelper.signPowerUpSignature(
        signatureJson: signatureJson,
        wallet: wallet,
        rsaPrivateKey: privateKey);

    // Build the payload
    final payload = DidPowerUpRequestPayload(
      senderDid: wallet.bech32Address,
      pairwiseDid: pairwiseDid,
      timestamp: timestamp,
      signature: base64.encode(signedSignatureHash),
    );

    // =============
    // Encrypt proof
    // =============

    // Generate an AES-256 key called F
    final aesKey = await KeysHelper.generateAesKey();

    // Encrypt the payload
    final encryptedProof = EncryptionHelper.encryptStringWithAesGCM(
      jsonEncode(payload),
      aesKey,
    );

    // =================
    // Encrypt proof key
    // =================

    final rsaPubTkKey = await EncryptionHelper.getGovernmentRsaPubKey(
        wallet.networkInfo.lcdUrl);
    final encryptedProofKey =
        EncryptionHelper.encryptBytesWithRsa(aesKey.bytes, rsaPubTkKey);

    // Build the message and send the tx
    final msg = MsgRequestDidPowerUp(
      claimantDid: wallet.bech32Address,
      amount: amount,
      powerUpProof: base64.encode(encryptedProof),
      uuid: Uuid().v4(),
      encryptionKey: base64.encode(encryptedProofKey),
    );

    return TxHelper.createSignAndSendTx([msg], wallet, fee: fee);
  }
}
