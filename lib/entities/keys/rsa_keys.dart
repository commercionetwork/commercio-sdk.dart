import 'dart:convert';

import 'package:asn1lib/asn1lib.dart';
import 'package:commerciosdk/entities/export.dart';
import 'package:pointycastle/export.dart' as pointy_castle;

/// Wrapper of the pointyCastle RSAPublicKey
class RSAPublicKey implements PublicKey {
  final pointy_castle.RSAPublicKey pubKey;
  final String keyType;

  RSAPublicKey(
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
class RSAPrivateKey implements PrivateKey {
  final pointy_castle.RSAPrivateKey secretKey;

  RSAPrivateKey(this.secretKey);

  String encodePrivateKeyToPemPKCS1() {
    final topLevel = ASN1Sequence();

    final version = ASN1Integer(BigInt.from(0));
    final modulus = ASN1Integer(secretKey.n);
    final publicExponent = ASN1Integer(secretKey.exponent);
    final privateExponent = ASN1Integer(secretKey.d);
    final p = ASN1Integer(secretKey.p);
    final q = ASN1Integer(secretKey.q);
    final dP = secretKey.d % (secretKey.p - BigInt.from(1));
    final exp1 = ASN1Integer(dP);
    final dQ = secretKey.d % (secretKey.q - BigInt.from(1));
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
