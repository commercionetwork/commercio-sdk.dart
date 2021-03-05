import 'dart:convert';

import 'package:commerciosdk/crypto/export.dart';
import 'package:commerciosdk/export.dart';
import 'package:test/test.dart';

void main() {
  test('generateRsaKeyPair generates random keys', () async {
    final keys =
        <CommercioKeyPair<CommercioRSAPublicKey, CommercioRSAPrivateKey>>[];
    for (var i = 0; i < 10; i++) {
      keys.add(await KeysHelper.generateRsaKeyPair(
        keyType: CommercioRSAKeyType.verification,
      ));
    }

    final unique = keys
        .map((keypair) => keypair.publicKey.publicKey.modulus)
        .toSet()
        .toList();
    expect(unique.length, 10);
  });

  test('generateAesKey generates random keys', () async {
    final keys = <Uint8List>[];
    for (var i = 0; i < 100; i++) {
      final key = await KeysHelper.generateAesKey();
      expect(16, key.length);
      keys.add(key);
    }

    final unique = keys.map((key) => base64Encode(key)).toSet().toList();
    expect(unique.length, 100);
  });
}
