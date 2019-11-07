import 'dart:convert';

import 'package:hex/hex.dart';
import 'package:test/test.dart';
import 'package:commerciosdk/crypto/export.dart';


void main() {
  var aesKey = Key.fromUtf8("Xn2r5u8x/A?D(G+KbPdSgVkYp3s6v9y\$");

  test('AES encryption works properly with string data', () async {
    var result = EncryptionHelper.encryptStringWithAes("Test", aesKey);
    expect(HEX.encode(result), "567b77516c6d96978561ee8244b01afb");
  });

  test('AES encryption works properly with byte array data', () async {
    const input = "Super long test that should be encrypted properly";
    var encoded = utf8.encode(input);
    var result = EncryptionHelper.encryptBytesWithAes(encoded, aesKey);
    expect(
      HEX.encode(result),
      "8031b6fb67ee4cf45e5bff5e6927f016675ed9c8e89b5aed8f9418c8ca04b65706c71a65039302e937342eed892be761251bb3596b64145060fd478a2fe839c7",
    );
  });

  test('AES decryption works properly', () async {
    const input =
        "8031b6fb67ee4cf45e5bff5e6927f016675ed9c8e89b5aed8f9418c8ca04b65706c71a65039302e937342eed892be761251bb3596b64145060fd478a2fe839c7";
    var encoded = HEX.decode(input);
    var result = EncryptionHelper.decryptWithAes(encoded, aesKey);
    expect(
      utf8.decode(result),
      "Super long test that should be encrypted properly",
    );
  });

  test('RSA encryption and decryption work properly with String', () async {
    var keyPair = await KeysHelper.generateRsaKeyPair();
    var input = "This is a test!";
    var encrypted = EncryptionHelper.encryptStringWithRsa(
      input,
      keyPair.publicKey,
    );
    var decrypted = EncryptionHelper.decryptBytesWithRsa(
      encrypted,
      keyPair.privateKey,
    );
    expect(utf8.decode(decrypted), input);
  });

  test('RSA encryption and decryption work properly with byte array', () async {
    var keyPair = await KeysHelper.generateRsaKeyPair();
    var input =
        "Long text for RSA encryption and decryption that should be read as a ByteArray";
    var encoded = utf8.encode(input);
    var encrypted = EncryptionHelper.encryptBytesWithRsa(
      encoded,
      keyPair.publicKey,
    );
    var decrypted = EncryptionHelper.decryptBytesWithRsa(
      encrypted,
      keyPair.privateKey,
    );
    expect(utf8.decode(decrypted), input);
  });
}

