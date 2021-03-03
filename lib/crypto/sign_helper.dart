import 'dart:convert';
import 'dart:typed_data';

import 'package:commerciosdk/entities/keys/rsa_keys.dart';
import 'package:encrypt/encrypt.dart';
import 'package:sacco/sacco.dart';
import 'package:sacco/utils/export.dart';

/// Allows to easily perform signature-related operations.
class SignHelper {
  /// Takes the given [data], converts it to an alphabetically sorted
  /// JSON object and signs its content using the given [wallet].
  static Uint8List signSorted(Map<String, dynamic> data, Wallet wallet) {
    final sorted = MapSorter.sort(data);
    final dataToSign = Uint8List.fromList(utf8.encode(json.encode(sorted)));

    return wallet.sign(dataToSign);
  }

  /// Takes [senderDid], [pairwiseDid], [timestamp] and:
  /// 1. Concatenate senderDid, pairwiseDid and timestamp as payload
  /// 2. Returns the RSA PKCS1v15 (the SHA256 digest is calculated inside the
  ///    signer) and sign using the [rsaPrivateKey]
  static Uint8List signPowerUpSignature(
      {required String senderDid,
      required String pairwiseDid,
      required String timestamp,
      required RSAPrivateKey rsaPrivateKey}) {
    final concat = senderDid + pairwiseDid + timestamp;

    final signer = Signer(
        RSASigner(RSASignDigest.SHA256, privateKey: rsaPrivateKey.secretKey));

    return signer.signBytes(utf8.encode(concat)).bytes;
  }
}
