import 'dart:convert';
import 'dart:typed_data';

import 'package:commerciosdk/crypto/export.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Contains the data that is returned from the [generateProof] method.
class ProofGenerationResult extends Equatable {
  final Uint8List encryptedProof;
  final Uint8List encryptedAesKey;

  ProofGenerationResult({
    @required this.encryptedProof,
    @required this.encryptedAesKey,
  })  : assert(encryptedProof != null),
        assert(encryptedAesKey != null);

  @override
  List<Object> get props {
    return [encryptedProof, encryptedAesKey];
  }
}

/// Given a [payload], creates a new AES-256 key and uses that to encrypt
/// the payload itself.
Future<ProofGenerationResult> generateProof(
    dynamic payload, String lcdUrl) async {
  // Generate the AES key
  final aesKey = await KeysHelper.generateAesKey();

  // Encrypt the payload
  final encryptionData = jsonEncode(payload);
  final encryptedPayload = EncryptionHelper.encryptStringWithAes(
    encryptionData,
    aesKey,
  );

  // Encrypt the AES key
  final rsaKey = await EncryptionHelper.getGovernmentRsaPubKey(lcdUrl);
  final encryptedAesKey = EncryptionHelper.encryptBytesWithRsa(
    aesKey.bytes,
    rsaKey,
  );

  return ProofGenerationResult(
    encryptedProof: encryptedPayload,
    encryptedAesKey: encryptedAesKey,
  );
}
