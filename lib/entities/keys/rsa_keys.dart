import 'dart:convert';

import 'package:commerciosdk/entities/export.dart';
import 'package:pointycastle/export.dart';
import 'package:asn1lib/asn1lib.dart'; // Do not use pointycastle one

/// Wrapper of the pointyCastle RSAPublicKey
class CommercioRSAPublicKey implements CommercioPublicKey {
  final RSAPublicKey publicKey;
  final CommercioRSAKeyType keyType;

  CommercioRSAPublicKey(
    this.publicKey, {
    required this.keyType,
  });

  @override
  String getType() => keyType.value;

  @override
  String getEncoded() {
    final pubKeySequence = ASN1Sequence();
    pubKeySequence.add(ASN1Integer(publicKey.modulus));
    pubKeySequence.add(ASN1Integer(publicKey.exponent));
    final dataBase64 = base64Encode(pubKeySequence.encodedBytes);
    return '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A$dataBase64\n-----END PUBLIC KEY-----';
  }
}

/// Wrapper of the pointyCastle RSAPrivateKey
class CommercioRSAPrivateKey implements CommercioPrivateKey {
  final RSAPrivateKey privateKey;

  CommercioRSAPrivateKey(this.privateKey);

  String encodePrivateKeyToPemPKCS1() {
    final topLevel = ASN1Sequence();

    final version = ASN1Integer(BigInt.from(0));
    final modulus = ASN1Integer(privateKey.n);
    final publicExponent = ASN1Integer(privateKey.exponent);
    final privateExponent = ASN1Integer(privateKey.privateExponent);
    final p = ASN1Integer(privateKey.p);
    final q = ASN1Integer(privateKey.q);
    final dP = privateKey.privateExponent % (privateKey.p - BigInt.from(1));
    final exp1 = ASN1Integer(dP);
    final dQ = privateKey.privateExponent % (privateKey.q - BigInt.from(1));
    final exp2 = ASN1Integer(dQ);
    final iQ = privateKey.q.modInverse(privateKey.p);
    final co = ASN1Integer(iQ);

    topLevel.add(version);
    topLevel.add(modulus);
    topLevel.add(publicExponent);
    topLevel.add(privateExponent);
    topLevel.add(p);
    topLevel.add(q);
    topLevel.add(exp1);
    topLevel.add(exp2);
    topLevel.add(co);

    final dataBase64 = base64.encode(topLevel.encodedBytes);

    return '-----BEGIN PRIVATE KEY-----\r\n$dataBase64\r\n-----END PRIVATE KEY-----';
  }
}

/// Defines the two types of possible [CommercioRSAPublicKey] types.
enum CommercioRSAKeyType {
  verification,
  signature,
}

extension CommercioRSAKeyTypeExt on CommercioRSAKeyType {
  /// Returns the enum value as string.
  String get value {
    switch (this) {
      case CommercioRSAKeyType.verification:
        return 'RsaVerificationKey2018';
      case CommercioRSAKeyType.signature:
        return 'RsaSignatureKey2018';
    }
  }
}
