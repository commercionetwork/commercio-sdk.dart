import 'dart:convert';
import 'dart:typed_data';

import 'package:commerciosdk/entities/export.dart';
import 'package:commerciosdk/entities/keys/rsa_keys.dart';
import 'package:pointycastle/export.dart';
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
  /// 2. Returns the RSA PKCS1v1.5 (the SHA256 digest is calculated inside the
  ///    signer) and sign using the [rsaPrivateKey]
  static Uint8List signPowerUpSignature({
    required String senderDid,
    required String pairwiseDid,
    required String timestamp,
    required CommercioRSAPrivateKey rsaPrivateKey,
  }) {
    final concat = senderDid + pairwiseDid + timestamp;

    final rsaSigner = RSASigner(SHA256Digest(), '0609608648016503040201');
    rsaSigner.init(
      true,
      PrivateKeyParameter<RSAPrivateKey>(rsaPrivateKey.privateKey),
    );

    final sig =
        rsaSigner.generateSignature(Uint8List.fromList(utf8.encode(concat)));

    return sig.bytes;
  }
}
