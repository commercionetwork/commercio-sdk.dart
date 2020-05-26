import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/export.dart' as pointy_castle;

/// Allows to easily parse a PEM-encoded RSA public key.
class RSAKeyParser {
  /// Reads the given [pemString] as a PEM-encoded RSA key,
  /// returning both public and private keys.
  static pointy_castle.RSAAsymmetricKey parseKeyFromPem(String pemString) {
    final parser = encrypt.RSAKeyParser();
    return parser.parse(pemString);
  }
}
