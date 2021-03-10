import 'dart:convert';
import 'dart:typed_data';

import 'package:commerciosdk/entities/crypto/identity_response.dart';
import 'package:commerciosdk/entities/crypto/tumbler_response.dart';
import 'package:commerciosdk/export.dart';
import 'package:http/http.dart' as http;
import 'package:pointycastle/export.dart';

/// Allows to perform common encryption operations such as
/// RSA/AES encryption and decryption.
class EncryptionHelper {
  /// encrypting the data that only it should see.
  /// Returns the RSA public key associated to the government that should be used when
  static Future<CommercioRSAPublicKey> getGovernmentRsaPubKey(
    Uri lcdUrl, {
    http.Client? client,
  }) async {
    final tumblerResponse = await Network.query(
      Uri.parse('${lcdUrl.toString()}/government/tumbler'),
      client: client,
    );

    if (tumblerResponse == null) {
      throw const FormatException('Cannot get tumbler address');
    }

    final tumbler = TumblerResponse.fromJson(jsonDecode(tumblerResponse));
    final tumblerAddress = tumbler.result.tumblerAddress;
    final identityResponseRaw = await Network.query(
      Uri.parse('${lcdUrl.toString()}/identities/$tumblerAddress'),
      client: client,
    );

    if (identityResponseRaw == null) {
      throw const FormatException('Cannot get tumbler RSA public key');
    }

    final identityResponse =
        IdentityResponse.fromJson(jsonDecode(identityResponseRaw));

    final didPubKey = identityResponse.result.didDocument.publicKeys[1];

    if (didPubKey == null) {
      throw Exception('Could not find the governement public key');
    }

    final rsaPublicKey =
        RSAKeyParser.parseFromPem(didPubKey.publicKeyPem) as RSAPublicKey;

    return CommercioRSAPublicKey(
      rsaPublicKey,
      keyType: CommercioRSAKeyType.verification,
    );
  }

  /// Encrypts the given [data] with AES using the specified [key].
  static Uint8List encryptStringWithAes(String data, Uint8List key) {
    return encryptBytesWithAes(Uint8List.fromList(utf8.encode(data)), key);
  }

  static Uint8List encryptStringWithAesGCM(String data, Uint8List key) {
    // Generate a random 96-bit nonce N
    final nonce = KeysHelper.generateRandomNonce(12);

    // Create an AES-GCM crypter
    final aesGcmCrypter = GCMBlockCipher(AESFastEngine());
    final params = AEADParameters(KeyParameter(key), 128, nonce, null);
    aesGcmCrypter.init(true, params);

    // Encrypt the data with the key F and nonce N obtaining CIPHERTEXT
    final dataToEncrypt = Uint8List.fromList(utf8.encode(data));
    final chiperText = aesGcmCrypter.process(dataToEncrypt);

    // Concatenate bytes of CIPHERTEXT and N
    final chiperTextWithNonce = nonce + chiperText;

    return Uint8List.fromList(chiperTextWithNonce);
  }

  /// Encrypts the given [data] with AES using the specified [key].
  static Uint8List encryptBytesWithAes(Uint8List data, Uint8List key) {
    final ecbChiper = PaddedBlockCipher('AES/ECB/PKCS7');
    final params = PaddedBlockCipherParameters(KeyParameter(key), null);
    ecbChiper.init(true, params);

    return ecbChiper.process(data);
  }

  /// Decrypts the given [data] with AES using the specified [key].
  static Uint8List decryptWithAes(Uint8List data, Uint8List key) {
    final ecbChiper = PaddedBlockCipher('AES/ECB/PKCS7');
    final params = PaddedBlockCipherParameters(KeyParameter(key), null);
    ecbChiper.init(false, params);

    return ecbChiper.process(data);
  }

  /// Encrypts the given [data] with RSA using the specified [key].
  static Uint8List encryptStringWithRsa(String data, RSAPublicKey key) {
    return encryptBytesWithRsa(Uint8List.fromList(utf8.encode(data)), key);
  }

  /// Encrypts the given [data] with RSA using the specified [key].
  static Uint8List encryptBytesWithRsa(Uint8List data, RSAPublicKey key) {
    final rsaChiper = PKCS1Encoding(RSAEngine());
    rsaChiper.init(true, PublicKeyParameter<RSAPublicKey>(key));

    return rsaChiper.process(data);
  }

  /// Decrypts the given data using the specified private [key].
  static Uint8List decryptBytesWithRsa(Uint8List data, RSAPrivateKey key) {
    final rsaChiper = PKCS1Encoding(RSAEngine());
    rsaChiper.init(false, PrivateKeyParameter<RSAPrivateKey>(key));

    return rsaChiper.process(data);
  }
}
