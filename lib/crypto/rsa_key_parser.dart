import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/export.dart' as pointy_castle;

/// Allows to easily parse a PEM-encoded RSA public key.
class RSAKeyParser {
  /// Reads the given [pemString] as a PEM-encoded RSA public key, returning
  /// the object representing the key itself.
  static pointy_castle.RSAPublicKey parsePublicKeyFromPem(String pemString) {
    final parser =  encrypt.RSAKeyParser();
    final rsaPublicKey = parser.parse(pemString);

    return pointy_castle.RSAPublicKey(
      rsaPublicKey.modulus,
      rsaPublicKey.exponent,
    );
  }
}
