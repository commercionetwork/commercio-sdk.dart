import 'dart:math';
import 'dart:typed_data';

import 'package:commerciosdk/crypto/export.dart';
import 'package:commerciosdk/export.dart';
import 'package:encrypt/encrypt.dart' hide SecureRandom;
import 'package:pointycastle/export.dart';

/// Allows to easily generate new keys either to be used with AES or RSA key.
class KeysHelper {
  /// Generates a SecureRandom
  static SecureRandom _getSecureRandom() {
    var secureRandom = FortunaRandom();
    var random = Random.secure();
    List<int> seeds = [];
    for (int i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }
    secureRandom.seed(new KeyParameter(new Uint8List.fromList(seeds)));
    return secureRandom;
  }

  /// Generates a new RSA key pair having the given [bytes] length.
  /// If no length is specified, the default is going to be 2048.
  static Future<KeyPair<RSAPubKey, RSASecretKey>> generateRsaKeyPair({
    int bytes = 2048,
  }) async {
    var rsa = new RSAKeyGeneratorParameters(BigInt.from(65537), bytes, 5);
    var params = new ParametersWithRandom(rsa, _getSecureRandom());
    var keyGenerator = new RSAKeyGenerator();
    keyGenerator.init(params);
    var keyPair = keyGenerator.generateKeyPair();
    return KeyPair(
        RSAPubKey(keyPair.publicKey), RSASecretKey(keyPair.privateKey));
  }

  /// Generates a new AES key having the desired [length].
  static Future<Key> generateAesKey({int length = 356}) async {
    return Key.fromSecureRandom(length);
  }
}
