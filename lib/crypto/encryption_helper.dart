import 'dart:convert';
import 'dart:typed_data';

import 'package:commerciosdk/export.dart';
import 'package:steel_crypt/steel_crypt.dart';

/// Allows to perform common encryption operations such as
/// RSA/AES encryption and decryption.
class EncryptionHelper {
  /// Returns the RSA public key associated to the government that should be used when
  /// encrypting the data that only it should see.
  static Future<RSAPublicKey> getGovernmentRsaPubKey(String lcdUrl) async {
    final tumblerResponse =
        await Network.query("$lcdUrl/government/tumbler");
    if (tumblerResponse == null) {
      throw FormatException("Cannot get tumbler address");
    }
    final tumbler = jsonDecode(tumblerResponse);
    final tumblerAddress = tumbler['result']['tumbler_address'];
    final identitiesResponse = await Network.query(
        "$lcdUrl/identities/$tumblerAddress");
    if (identitiesResponse == null) {
      throw FormatException("Cannot get government RSA public key");
    }
    final identities = jsonDecode(identitiesResponse);
    final pem = identities['result'];
    print(pem);
    final rsaPublicKey = RSAKeyParser.parsePublicKeyFromPem(pem);
    return RSAPublicKey(rsaPublicKey);
  }

  /// Encrypts the given [data] with AES using the specified [key].
  static Uint8List encryptStringWithAes(String data, Key key) {
    return AES(key, mode: AESMode.ecb).encrypt(utf8.encode(data)).bytes;
  }

  static Uint8List encryptStringWithAesGCM(String data, String plainKey) {
    final nonce = CryptKey().genDart(12);
    final aesGcmCrypter = AesCrypt(plainKey, 'gcm');

    return utf8.encode(aesGcmCrypter.encrypt(data, nonce));
  }

  /// Encrypts the given [data] with AES using the specified [key].
  static Uint8List encryptBytesWithAes(Uint8List data, Key key) {
    return AES(key, mode: AESMode.ecb).encrypt(data).bytes;
  }

  /// Decrypts the given [data] with AES using the specified [key].
  static Uint8List decryptWithAes(Uint8List data, Key key) {
    return AES(key, mode: AESMode.ecb).decrypt(Encrypted(data));
  }

  /// Encrypts the given [data] with RSA using the specified [key].
  static Uint8List encryptStringWithRsa(String data, RSAPublicKey key) {
    return RSA(publicKey: key.pubKey).encrypt(utf8.encode(data)).bytes;
  }

  /// Encrypts the given [data] with RSA using the specified [key].
  static Uint8List encryptBytesWithRsa(Uint8List data, RSAPublicKey key) {
    return RSA(publicKey: key.pubKey).encrypt(data).bytes;
  }

  /// Decrypts the given data using the specified private [key].
  static Uint8List decryptBytesWithRsa(Uint8List data, RSAPrivateKey key) {
    return RSA(privateKey: key.secretKey).decrypt(Encrypted(data));
  }
}
