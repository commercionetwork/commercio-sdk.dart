import 'package:commerciosdk/crypto/export.dart';
import 'package:commerciosdk/entities/export.dart';
import 'package:commerciosdk/entities/keys/key_pair.dart' as local;
import 'package:test/test.dart';

void main() {
  test('generateRsaKeyPair generates random keys', () async {
    final keys = <local.KeyPair<RSAPublicKey, RSAPrivateKey>>[];
    for (var i = 0; i < 10; i++) {
      keys.add(await KeysHelper.generateRsaKeyPair());
    }

    final unique = keys
        .map((keypair) => keypair.publicKey.pubKey.modulus)
        .toSet()
        .toList();
    expect(unique.length, 10);
  });

  test('generateAesKey generates random keys', () async {
    final keys = <Key>[];
    for (var i = 0; i < 100; i++) {
      final key = await KeysHelper.generateAesKey();
      expect(16, key.bytes.length);
      keys.add(key);
    }

    final unique = keys.map((key) => key.base64).toSet().toList();
    expect(unique.length, 100);
  });
}
