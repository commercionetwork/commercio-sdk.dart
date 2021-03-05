import 'package:pointycastle/export.dart';
import 'package:rsa_pkcs/rsa_pkcs.dart' as rsa_parser;

/// RSA PEM parser.
class RSAKeyParser {
  /// Parses the PEM key no matter it is public or private, it will figure it out.
  static RSAAsymmetricKey parseFromPem(String key) {
    final parser = rsa_parser.RSAPKCSParser();

    final pair = parser.parsePEM(key);

    if (pair.private != null) {
      final k = pair.private;

      return RSAPrivateKey(
        k.modulus,
        k.privateExponent,
        k.prime1,
        k.prime2,
        BigInt.from(k.publicExponent),
      );
    } else if (pair.public != null) {
      final k = pair.public;

      return RSAPublicKey(k.modulus, BigInt.from(k.publicExponent));
    }

    throw ArgumentError('Could only parse PCKS1 RSA PEM files');
  }
}
