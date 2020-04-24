import 'dart:typed_data';

import "package:asn1lib/asn1lib.dart";
import 'package:commerciosdk/entities/export.dart';
import 'package:pointycastle/export.dart' as pointy_castle;

/// Wrapper of the pointyCastle RSAPublicKey
class RSAPublicKey implements PublicKey {
  final pointy_castle.RSAPublicKey pubKey;
  final String type;

  RSAPublicKey(
    this.pubKey, {
    this.type = "RsaVerificationKey2018",
  });

  @override
  String get keyType => type;

  @override
  Uint8List getEncoded() {
    var pubKeySequence = ASN1Sequence();
    pubKeySequence.add(ASN1Integer(this.pubKey.modulus));
    pubKeySequence.add(ASN1Integer(this.pubKey.exponent));
    return Uint8List.fromList(pubKeySequence.encodedBytes);
  }
}

/// Wrapper of the pointyCastle RSAPrivateKey
class RSAPrivateKey implements PrivateKey {
  final pointy_castle.RSAPrivateKey secretKey;

  RSAPrivateKey(this.secretKey);
}
