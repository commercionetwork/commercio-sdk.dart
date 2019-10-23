import 'package:test/test.dart';
import 'package:commerciosdk/crypto/export.dart';

void main () {

  test('generateRsaKeyPair generates random keys', () async {
    List<AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>> keys = [];
    for (int i = 0; i < 10; i++) {
      keys.add(await KeysHelper.generateRsaKeyPair());
    }

    var unique = keys.map((keypair) => keypair.publicKey.modulus).toSet().toList();
    expect(unique.length, 10);
  });

  test('generateAesKey generates random keys', () async {
    List<Key> keys = [];
    for (int i = 0; i < 100; i ++) {
      keys.add(await KeysHelper.generateAesKey());
    }

    var unique = keys.map((key) => key.base64).toSet().toList();
    expect(unique.length, 100);
  });
}