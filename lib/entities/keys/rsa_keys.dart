import 'dart:convert';

import "package:asn1lib/asn1lib.dart";
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
  String getType() => keyType ?? "RsaVerificationKey2018";

  @override
  String getEncoded() {
    var pubKeySequence = ASN1Sequence();
    pubKeySequence.add(ASN1Integer(pubKey.modulus));
    pubKeySequence.add(ASN1Integer(pubKey.exponent));
    var dataBase64 = base64.encode(pubKeySequence.encodedBytes);
    return """-----BEGIN PUBLIC KEY-----\r\n$dataBase64\r\n-----END PUBLIC KEY-----""";
  }
}

/// Wrapper of the pointyCastle RSAPrivateKey
class RSAPrivateKey implements PrivateKey {
  final pointy_castle.RSAPrivateKey secretKey;

  RSAPrivateKey(this.secretKey);

  String encodePrivateKeyToPemPKCS1() {
    var topLevel = ASN1Sequence();

    var version = ASN1Integer(BigInt.from(0));
    var modulus = ASN1Integer(secretKey.n);
    var publicExponent = ASN1Integer(secretKey.exponent);
    var privateExponent = ASN1Integer(secretKey.d);
    var p = ASN1Integer(secretKey.p);
    var q = ASN1Integer(secretKey.q);
    var dP = secretKey.d % (secretKey.p - BigInt.from(1));
    var exp1 = ASN1Integer(dP);
    var dQ = secretKey.d % (secretKey.q - BigInt.from(1));
    var exp2 = ASN1Integer(dQ);
    var iQ = secretKey.q.modInverse(secretKey.p);
    var co = ASN1Integer(iQ);

    topLevel.add(version);
    topLevel.add(modulus);
    topLevel.add(publicExponent);
    topLevel.add(privateExponent);
    topLevel.add(p);
    topLevel.add(q);
    topLevel.add(exp1);
    topLevel.add(exp2);
    topLevel.add(co);

    var dataBase64 = base64.encode(topLevel.encodedBytes);

    return """-----BEGIN PRIVATE KEY-----\r\n$dataBase64\r\n-----END PRIVATE KEY-----""";
  }
}
