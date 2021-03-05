import 'dart:convert';

import 'package:commerciosdk/crypto/export.dart';
import 'package:equatable/equatable.dart';

/// Contains the data that is returned from the [generateProof] method.
class ProofGenerationResult extends Equatable {
  final String encodedProof;
  final String encodedAesKey;

  const ProofGenerationResult({
    required this.encodedProof,
    required this.encodedAesKey,
  });

  @override
  List<Object> get props {
    return [encodedProof, encodedAesKey];
  }
}

/// Given a [payload], creates a new AES-256 key and uses that to encrypt
/// the payload itself.
Future<ProofGenerationResult> generateProof(
  Object payload,
  String lcdUrl,
) async {
  // Generate the AES key
  final aesKey = await KeysHelper.generateAesKey();

  // Encrypt the payload
  final encryptionData = jsonEncode(payload);
  final encryptedPayload = EncryptionHelper.encryptStringWithAes(
    encryptionData,
    aesKey,
  );

  // Generate nonce, concatenate with payload and encode
  final nonce = KeysHelper.generateRandomNonce(12);
  final encodedProof = base64.encode(encryptedPayload + nonce);

  // Encrypt the AES key
  final rsaKey = await EncryptionHelper.getGovernmentRsaPubKey(lcdUrl);
  final encryptedAesKey = EncryptionHelper.encryptBytesWithRsa(
    aesKey,
    rsaKey.publicKey,
  );
  final encodedAesKey = base64.encode(encryptedAesKey);

  return ProofGenerationResult(
    encodedProof: encodedProof,
    encodedAesKey: encodedAesKey,
  );
}
