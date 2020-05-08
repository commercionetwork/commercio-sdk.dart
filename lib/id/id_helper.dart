import 'dart:convert';

import 'package:commerciosdk/crypto/sign_helper.dart';
import 'package:commerciosdk/export.dart';
import 'package:commerciosdk/id/did_power_up_request_signature_json.dart';
import 'package:commerciosdk/id/id_utils.dart';
import 'package:hex/hex.dart';
import 'package:sacco/sacco.dart';
import 'package:steel_crypt/steel_crypt.dart';
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

    return DidDocument.fromJson(response);
  }

  /// Performs a transaction setting the specified [didDocument] as being
  /// associated with the address present inside the specified [wallet].
  static Future<TransactionResult> setDidDocument(
      DidDocument didDocument, Wallet wallet,
      {StdFee fee}) {
    final msg = MsgSetDidDocument(didDocument: didDocument);
    return TxHelper.createSignAndSendTx([msg], wallet, fee: fee);
  }

  /// Creates a new Did deposit request for the given [recipient] and of the given [amount].
  /// Signs everything that needs to be signed (i.e. the signature JSON inside the payload) with the
  /// private key contained inside the given [wallet].
  static Future<TransactionResult> requestDidDeposit(
      String recipient, List<StdCoin> amount, Wallet wallet,
      {StdFee fee}) async {
    // Get the timestamp
    var timestamp = getTimeStamp();

    // Build the signature
    var signatureJson = DidDepositRequestSignatureJson(
      recipient: recipient,
      timeStamp: timestamp,
    );
    var signedJson = SignHelper.signSorted(signatureJson.toJson(), wallet);

    // Build the payload
    var payload = DidDepositRequestPayload(
      recipient: recipient,
      timeStamp: timestamp,
      signature: HEX.encode(signedJson),
    );

    // Build the proof
    var result = await generateProof(payload);

    // Build the message and send the tx
    var msg = MsgRequestDidDeposit(
      recipientDid: recipient,
      amount: amount,
      depositProof: HEX.encode(result.encryptedProof),
      encryptionKey: HEX.encode(result.encryptedAesKey),
      senderDid: wallet.bech32Address,
    );
    return TxHelper.createSignAndSendTx([msg], wallet, fee: fee);
  }

  /// Creates a new Did power up request for the given [pairwiseDid] and of the given [amount].
  /// Signs everything that needs to be signed (i.e. the signature JSON inside the payload) with the
  /// private key contained inside the given [wallet].
  static Future<TransactionResult> requestDidPowerUp(
      String pairwiseDid, List<StdCoin> amount, Wallet wallet,
      {StdFee fee}) async {
    // Get the timestamp
    final timestamp = getTimeStamp();

    // Build the signature
    final signatureJson = DidPowerUpRequestSignatureJson(
      senderDid: wallet.bech32Address,
      pairwiseDid: pairwiseDid,
      timestamp: timestamp,
    );
    final signedSignatureHash = SignHelper.signPowerUpSignature(
        signatureJson: signatureJson, wallet: wallet);

    // Build the payload
    final payload = DidPowerUpRequestPayload(
      senderDid: wallet.bech32Address,
      pairwiseDid: pairwiseDid,
      timestamp: timestamp,
      signature: base64.encode(signedSignatureHash),
    );

    // Build proof and proof key

    // Generate the AES key
    final aesKey = CryptKey().genFortuna();

    // Encrypt the payload
    final encryptedProof = EncryptionHelper.encryptStringWithAesGCM(
      jsonEncode(payload),
      aesKey,
    );

    // Encrypt the AES key
    final rsaKey = await EncryptionHelper.getGovernmentRsaPubKey();
    final encryptedProofKey = EncryptionHelper.encryptBytesWithRsa(
      utf8.encode(aesKey),
      rsaKey,
    );

    // Build the message and send the tx
    final msg = MsgRequestDidPowerUp(
      claimantDid: wallet.bech32Address,
      amount: amount,
      powerUpProof: base64.encode(encryptedProof),
      id: Uuid().v4(),
      proofKey: base64.encode(encryptedProofKey),
    );

    return TxHelper.createSignAndSendTx([msg], wallet, fee: fee);
  }
}
