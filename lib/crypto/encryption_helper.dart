import 'dart:convert';
import 'dart:typed_data';

import 'package:commerciosdk/crypto/export.dart';
import 'package:encrypt/encrypt.dart';
import 'package:commerciosdk/export.dart';

/// Allows to perform common encryption operations such as
/// RSA/AES encryption and decryption.
class EncryptionHelper {
  /// Returns the RSA public key associated to the government that should be used when
  /// encrypting the data that only it should see.
  static Future<RSAPubKey> getGovernmentRsaPubKey() async {
    final response = Network.query("http::localhost:8080/government/publicKey");
    if (response == null) {
      throw FormatException("Cannot get government RSA public key");
    }
    final rsaPublicKey = RSAKeyParser().parse(response.toString());
    return RSAPubKey(rsaPublicKey);
  }

  /// Encrypts the given [data] with AES using the specified [key].
  static Uint8List encryptStringWithAes(String data, Key key) {
    return AES(key, mode: AESMode.ecb).encrypt(utf8.encode(data)).bytes;
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
  static Uint8List encryptStringWithRsa(String data, RSAPubKey key) {
    return RSA(publicKey: key.pubKey).encrypt(utf8.encode(data)).bytes;
  }

  /// Encrypts the given [data] with RSA using the specified [key].
  static Uint8List encryptBytesWithRsa(Uint8List data, RSAPubKey key) {
    return RSA(publicKey: key.pubKey).encrypt(data).bytes;
  }

  /// Decrypts the given data using the specified private [key].
  static Uint8List decryptBytesWithRsa(Uint8List data, RSASecretKey key) {
    return RSA(privateKey: key.secretKey).decrypt(Encrypted(data));
  }
}
