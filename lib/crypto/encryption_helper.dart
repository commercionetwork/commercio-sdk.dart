import 'dart:convert';
import 'dart:typed_data';

import 'package:commerciosdk/entities/crypto/identity_response.dart';
import 'package:commerciosdk/entities/crypto/tumbler_response.dart';
import 'package:commerciosdk/export.dart';
import 'package:steel_crypt/steel_crypt.dart';

/// Allows to perform common encryption operations such as
/// RSA/AES encryption and decryption.
class EncryptionHelper {
  /// Returns the RSA public key associated to the government that should be used when
  /// encrypting the data that only it should see.
  static Future<RSAPublicKey> getGovernmentRsaPubKey(String lcdUrl) async {
    final tumblerResponse = await Network.query("$lcdUrl/government/tumbler");

    if (tumblerResponse == null) {
      throw FormatException("Cannot get tumbler address");
    }

    final tumbler = TumblerResponse.fromJson(jsonDecode(tumblerResponse));
    final tumblerAddress = tumbler.result.tumblerAddress;
    final identityResponseRaw =
        await Network.query("$lcdUrl/identities/$tumblerAddress");

    if (identityResponseRaw == null) {
      throw FormatException("Cannot get government RSA public key");
    }

    final identityResponse =
        IdentityResponse.fromJson(jsonDecode(identityResponseRaw));
    final publicSignatureKeyPem =
        identityResponse.result.didDocument.publicKeys[1].publicKeyPem;
    final rsaPublicKey = RSAKeyParser.parseKeyFromPem(publicSignatureKeyPem);

    return RSAPublicKey(rsaPublicKey);
  }

  /// Encrypts the given [data] with AES using the specified [key].
  static Uint8List encryptStringWithAes(String data, Key key) {
    return AES(key, mode: AESMode.ecb).encrypt(utf8.encode(data)).bytes;
  }

  static Uint8List encryptStringWithAesGCM(String data, Key key) {
    // Generate a random 96-bit nonce N
    final nonce = KeysHelper.generateRandomNonceUtf8(12);

    // Create an AES-GCM crypter
    final aesGcmCrypter =
        AesCrypt(String.fromCharCodes(key.bytes), 'gcm', 'none');

    // Encrypt the data with the key F and nonce N obtaining CIPHERTEXT
    final base64Enc = aesGcmCrypter.encrypt(data, utf8.decode(nonce));

    // Concatenate bytes of CIPHERTEXT and N
    final chiperText = base64.decode(base64Enc);
    final chiperTextWithNonce = nonce + chiperText;

    return Uint8List.fromList(chiperTextWithNonce);
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
