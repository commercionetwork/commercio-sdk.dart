import 'dart:convert';
import 'dart:typed_data';

import 'package:commerciosdk/entities/keys/rsa_keys.dart' as comm;
import 'package:commerciosdk/id/export.dart';
import 'package:crypto/crypto.dart';
import 'package:meta/meta.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/signers/rsa_signer.dart';
import 'package:sacco/sacco.dart';
import 'package:sacco/utils/export.dart';

/// Allows to easily perform signature-related operations.
class SignHelper {
  /// Takes the given [data], converts it to an alphabetically sorted
  /// JSON object and signs its content using the given [wallet].
  static Uint8List signSorted(dynamic data, Wallet wallet) {
    var sorted = data;
    if (data is Map<String, dynamic>) {
      sorted = MapSorter.sort(data);
    }

    return wallet.sign(utf8.encode(json.encode(sorted)));
  }

  /// Takes the [signatureJson] and:
  /// 1. Concatenate senderDid, pairwiseDid and timestamp as payload
  /// 2. Calcolate the SHA256 hash of the payload
  /// 3. Returns the RSA PKCS1v15 sign using the [rsaPrivateKey]
  static Uint8List signPowerUpSignature(
      {@required DidPowerUpRequestSignatureJson signatureJson,
      @required Wallet wallet,
      @required comm.RSAPrivateKey rsaPrivateKey}) {
    final concat = signatureJson.senderDid +
        signatureJson.pairwiseDid +
        signatureJson.timestamp;
    final hash = sha256.convert(utf8.encode(concat));

    final rsaSigner = RSASigner(SHA256Digest(), '0609608648016503040201');
    final privateKey = rsaPrivateKey.secretKey;
    rsaSigner.init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));

    final sig = rsaSigner.generateSignature(hash.bytes);

    return sig.bytes;
  }
}
