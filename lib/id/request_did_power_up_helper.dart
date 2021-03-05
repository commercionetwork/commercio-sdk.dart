import 'dart:convert';

import 'package:commerciosdk/export.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

/// Allows to easily create a RequestDidPowerUp
/// and perform common related operations
class RequestDidPowerUpHelper {
  /// Creates a RequestDidPowerUpHelper
  /// from the given [wallet], [pairwiseDid], [amount] and [privateKey]
  static Future<RequestDidPowerUp> fromWallet({
    required Wallet wallet,
    required String pairwiseDid,
    required List<StdCoin> amount,
    required CommercioRSAPrivateKey privateKey,
    http.Client? client,
  }) async {
    // Get the timestamp
    final timestamp = DateTime.now().toUtc().millisecondsSinceEpoch.toString();
    final senderDid = wallet.bech32Address;

    // Build and sign the signature
    final signedSignatureHash = SignHelper.signPowerUpSignature(
      senderDid: senderDid,
      pairwiseDid: pairwiseDid,
      timestamp: timestamp,
      rsaPrivateKey: privateKey,
    );

    // Build the payload
    final payload = DidPowerUpRequestPayload(
      senderDid: senderDid,
      pairwiseDid: pairwiseDid,
      timestamp: timestamp,
      signature: base64Encode(signedSignatureHash),
    );

    // =============
    // Encrypt proof
    // =============

    // Generate an AES-256 key
    final aesKey = await KeysHelper.generateAesKey();

    // Encrypt the payload
    final encryptedProof = EncryptionHelper.encryptStringWithAesGCM(
      jsonEncode(payload),
      aesKey,
    );

    // =================
    // Encrypt proof key
    // =================

    // Encrypt the key using the Tumbler public RSA key
    final rsaPubTkKey = await EncryptionHelper.getGovernmentRsaPubKey(
      wallet.networkInfo.lcdUrl,
      client: client,
    );
    final encryptedProofKey =
        EncryptionHelper.encryptBytesWithRsa(aesKey, rsaPubTkKey.publicKey);

    // Build the RequestDidPowerUp
    return RequestDidPowerUp(
      claimantDid: senderDid,
      amount: amount,
      powerUpProof: base64Encode(encryptedProof),
      uuid: Uuid().v4(),
      encryptionKey: base64Encode(encryptedProofKey),
    );
  }
}
