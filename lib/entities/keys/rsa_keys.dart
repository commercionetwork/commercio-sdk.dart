import 'dart:convert';

import 'package:commerciosdk/entities/export.dart';
import 'package:pointycastle/asn1.dart';
import 'package:pointycastle/export.dart';

/// Wrapper of the pointyCastle RSAPublicKey
class CommercioRSAPublicKey implements CommercioPublicKey {
  final RSAPublicKey pubKey;
  final String keyType;

  CommercioRSAPublicKey(
    this.pubKey, {
    this.keyType,
  });

  @override
  String getType() => keyType ?? 'RsaVerificationKey2018';

  @override
  String getEncoded() {
    final pubKeySequence = ASN1Sequence();
    pubKeySequence.add(ASN1Integer(pubKey.modulus));
    pubKeySequence.add(ASN1Integer(pubKey.exponent));
    final dataBase64 = base64.encode(pubKeySequence.encodedBytes);
    return '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A$dataBase64\n-----END PUBLIC KEY-----';
  }
}

/// Wrapper of the pointyCastle RSAPrivateKey
class CommercioRSAPrivateKey implements CommercioPrivateKey {
  final RSAPrivateKey secretKey;

  CommercioRSAPrivateKey(this.secretKey);

  String encodePrivateKeyToPemPKCS1() {
    final topLevel = ASN1Sequence();

    final version = ASN1Integer(BigInt.from(0));
    final modulus = ASN1Integer(secretKey.n);
    final publicExponent = ASN1Integer(secretKey.exponent);
    final privateExponent = ASN1Integer(secretKey.privateExponent);
    final p = ASN1Integer(secretKey.p);
    final q = ASN1Integer(secretKey.q);
    final dP = secretKey.privateExponent % (secretKey.p - BigInt.from(1));
    final exp1 = ASN1Integer(dP);
    final dQ = secretKey.privateExponent % (secretKey.q - BigInt.from(1));
    final exp2 = ASN1Integer(dQ);
    final iQ = secretKey.q.modInverse(secretKey.p);
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
