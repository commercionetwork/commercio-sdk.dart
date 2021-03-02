import 'dart:convert';
import 'dart:typed_data';

import 'package:commerciosdk/entities/crypto/identity_response.dart';
import 'package:commerciosdk/entities/crypto/tumbler_response.dart';
import 'package:commerciosdk/export.dart';
import 'package:http/http.dart' as http;

/// Allows to perform common encryption operations such as
/// RSA/AES encryption and decryption.
class EncryptionHelper {
  /// encrypting the data that only it should see.
  /// Returns the RSA public key associated to the government that should be used when
  static Future<RSAPublicKey> getGovernmentRsaPubKey(
    String lcdUrl, {
    http.Client client,
  }) async {
    final tumblerResponse = await Network.query(
      Uri.parse('$lcdUrl/government/tumbler'),
      client: client,
    );

    if (tumblerResponse == null) {
      throw const FormatException('Cannot get tumbler address');
    }

    final tumbler = TumblerResponse.fromJson(jsonDecode(tumblerResponse));
    final tumblerAddress = tumbler.result.tumblerAddress;
    final identityResponseRaw = await Network.query(
      Uri.parse('$lcdUrl/identities/$tumblerAddress'),
      client: client,
    );

    if (identityResponseRaw == null) {
      throw const FormatException('Cannot get tumbler RSA public key');
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
    final aesGcmCrypter = PaddedBlockCipher('AES/GCM/None');
    final params = AEADParameters(KeyParameter(key.bytes), 128, nonce, null);
    aesGcmCrypter.init(true, params);

    // Encrypt the data with the key F and nonce N obtaining CIPHERTEXT
    final chiperText = aesGcmCrypter.process(utf8.encode(data));

    // Concatenate bytes of CIPHERTEXT and N
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
