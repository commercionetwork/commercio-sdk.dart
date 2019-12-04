import 'dart:math';
import 'dart:typed_data';

import 'package:commerciosdk/export.dart';
import 'package:encrypt/encrypt.dart' hide SecureRandom;

/// Allows to easily generate new keys either to be used with AES or RSA key.
class KeysHelper {
  /// Generates a SecureRandom
  static SecureRandom _getSecureRandom() {
    final secureRandom = FortunaRandom();
    final random = Random.secure();
    final seed = List<int>.generate(32, (_) => random.nextInt(256));
    secureRandom.seed(KeyParameter(Uint8List.fromList(seed)));
    return secureRandom;
  }

  /// Generates a new AES key having the desired [length].
  static Future<Key> generateAesKey({int length = 256}) async {
    return Key.fromSecureRandom(length ~/ 16);
  }

  /// Generates a new RSA key pair having the given [bytes] length.
  /// If no length is specified, the default is going to be 2048.
  static Future<KeyPair<RSAPublicKey, RSAPrivateKey>> generateRsaKeyPair({
    int bytes = 2048,
  }) async {
    final rsa = RSAKeyGeneratorParameters(BigInt.from(65537), bytes, 5);
    final params = ParametersWithRandom(rsa, _getSecureRandom());
    final keyGenerator = RSAKeyGenerator();
    keyGenerator.init(params);
    final keyPair = keyGenerator.generateKeyPair();
    return KeyPair(
      RSAPublicKey(keyPair.publicKey),
      RSAPrivateKey(keyPair.privateKey),
    );
  }

  /// Generates a new random EC key pair.
  static Future<KeyPair<ECPublicKey, ECPrivateKey>> generateEcKeyPair() async {
    final keyParams = ECKeyGeneratorParameters(ECCurve_secp256k1());
    final generator = ECKeyGenerator();
    generator.init(ParametersWithRandom(keyParams, _getSecureRandom()));
    final keyPair = generator.generateKeyPair();
    return KeyPair(
      ECPublicKey(keyPair.publicKey),
      ECPrivateKey(keyPair.privateKey),
    );
  }
}
