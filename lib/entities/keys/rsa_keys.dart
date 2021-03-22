import 'dart:convert';

import 'package:asn1lib/asn1lib.dart';
import 'package:commerciosdk/entities/export.dart';
import 'package:pointycastle/export.dart';

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

  String getPKCS1Encoded() {
    final pubKeySequence = ASN1Sequence();
    pubKeySequence.add(ASN1Integer(publicKey.modulus!));
    pubKeySequence.add(ASN1Integer(publicKey.exponent!));
    final dataBase64 = base64Encode(pubKeySequence.encodedBytes);

    return '-----BEGIN RSA PUBLIC KEY-----\n$dataBase64\n-----END RSA PUBLIC KEY-----';
  }

  @override
  Future<String> getEncoded() async {
    final pubKeySequence = ASN1Sequence();
    pubKeySequence.add(ASN1Integer(publicKey.modulus!));
    pubKeySequence.add(ASN1Integer(publicKey.exponent!));
    final dataBase64 = base64Encode(pubKeySequence.encodedBytes);

    return '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A$dataBase64\n-----END PUBLIC KEY-----';
  }
}

/// Wrapper of the pointyCastle RSAPrivateKey
class CommercioRSAPrivateKey implements CommercioPrivateKey {
  final RSAPrivateKey privateKey;

  CommercioRSAPrivateKey(this.privateKey);

  /// Plain PKCS8 private key format:
  /// ```
  /// PrivateKeyInfo ::= SEQUENCE {
  ///  version Version,
  ///  privateKeyAlgorithm AlgorithmIdentifier {{PrivateKeyAlgorithms}},
  ///  privateKey PrivateKey,
  ///  attributes [0] Attributes OPTIONAL
  /// }
  ///
  /// Version ::= INTEGER {v1(0)} (v1,...)
  /// PrivateKey ::= OCTET STRING
  /// ```
  String encodePrivateKeyToPlainPemPKCS8() {
    final pkcs1 = encodePrivateKeyToPemPKCS1();
    final lines = pkcs1.split('\n');
    final pkcs1Body = lines.sublist(1, lines.length - 1).join('');
    final pkcs1BodyBytes = base64Decode(pkcs1Body);

    final algorithmIdentifierSequence = ASN1Sequence()
      ..add(
        ASN1ObjectIdentifier('1.2.840.113549.1.1.1'
            .split('.')
            .map((e) => int.parse(e))
            .toList()),
      );

    final privateKeyInfoSequence = ASN1Sequence();
    final privateKeyInfoVersion = ASN1Integer.fromInt(0);
    final privateKeyInfoAlgorithm = algorithmIdentifierSequence;
    final pKey = ASN1OctetString(pkcs1BodyBytes);

    privateKeyInfoSequence.add(privateKeyInfoVersion);
    privateKeyInfoSequence.add(privateKeyInfoAlgorithm);
    privateKeyInfoSequence.add(pKey);

    final pkcs8Body = base64Encode(privateKeyInfoSequence.encodedBytes);

    return '-----BEGIN PRIVATE KEY-----\n$pkcs8Body\n-----END PRIVATE KEY-----';
  }

  String encodePrivateKeyToPemPKCS1() {
    final topLevel = ASN1Sequence();

    final version = ASN1Integer.fromInt(0);
    final modulus = ASN1Integer(privateKey.n!);
    final publicExponent = ASN1Integer(privateKey.exponent!);
    final privateExponent = ASN1Integer(privateKey.privateExponent!);
    final p = ASN1Integer(privateKey.p!);
    final q = ASN1Integer(privateKey.q!);
    final dP = privateKey.privateExponent! % (privateKey.p! - BigInt.from(1));
    final exp1 = ASN1Integer(dP);
    final dQ = privateKey.privateExponent! % (privateKey.q! - BigInt.from(1));
    final exp2 = ASN1Integer(dQ);
    final iQ = privateKey.q!.modInverse(privateKey.p!);
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

    final dataBase64 = base64Encode(topLevel.encodedBytes);

    return '-----BEGIN RSA PRIVATE KEY-----\n$dataBase64\n-----END RSA PRIVATE KEY-----';
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
