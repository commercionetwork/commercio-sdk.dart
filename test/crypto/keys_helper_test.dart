import 'package:commerciosdk/crypto/export.dart';
import 'package:commerciosdk/entities/export.dart';
import 'package:commerciosdk/entities/keys/asymmetric_key_pair.dart' as local;
import 'package:test/test.dart';

void main() {
  test('generateRsaKeyPair generates random keys', () async {
    List<local.KeyPair<RSAPubKey, RSASecretKey>> keys = [];
    for (int i = 0; i < 10; i++) {
      keys.add(await KeysHelper.generateRsaKeyPair());
    }

    var unique = keys
        .map((keypair) => keypair.publicKey.pubKey.modulus)
        .toSet()
        .toList();
    expect(unique.length, 10);
  });

  test('generateAesKey generates random keys', () async {
    List<Key> keys = [];
    for (int i = 0; i < 100; i++) {
      keys.add(await KeysHelper.generateAesKey());
    }

    var unique = keys.map((key) => key.base64).toSet().toList();
    expect(unique.length, 100);
  });
}
