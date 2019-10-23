import 'dart:convert';

import 'package:commerciosdk/crypto/export.dart';
import 'package:meta/meta.dart';

class ProofGenerationResult {
  final Uint8List encryptedProof;
  final Uint8List encryptedAesKey;

  ProofGenerationResult({
    @required this.encryptedProof,
    @required this.encryptedAesKey,
  })  : assert(encryptedProof != null),
        assert(encryptedAesKey != null);
}

Future<ProofGenerationResult> generateProof(dynamic payload) async {
  // Generate the AES key
  final aesKey = await KeysHelper.generateAesKey();

  // Encrypt the payload
  final encryptionData = jsonEncode(payload);
  final encryptedPayload = EncryptionHelper.encryptStringWithAes(
    encryptionData,
    aesKey,
  );

  // Encrypt the AES key
  final rsaKey = await EncryptionHelper.getGovernmentRsaPubKey();
  final encryptedAesKey = EncryptionHelper.encryptBytesWithRsa(
    aesKey.bytes,
    rsaKey,
  );

  return ProofGenerationResult(
    encryptedProof: encryptedPayload,
    encryptedAesKey: encryptedAesKey,
  );
}
