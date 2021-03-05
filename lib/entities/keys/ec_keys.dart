import 'dart:convert';

import 'package:commerciosdk/entities/export.dart';
import 'package:pointycastle/export.dart' as pointy_castle;

/// Wrapper of the pointyCastle ECPublicKey
class CommercioECPublicKey implements CommercioPublicKey {
  final pointy_castle.ECPublicKey pubKey;
  final String? keyType;

  CommercioECPublicKey(
    this.pubKey, {
    this.keyType,
  });

  @override
  String getType() => keyType ?? 'Secp256k1VerificationKey2018';

  @override
  String getEncoded() {
    return base64.encode(pubKey.Q.getEncoded(false));
  }
}

/// Wrapper of the pointyCastle ECPrivateKey
class CommercioECPrivateKey implements CommercioPrivateKey {
  final pointy_castle.ECPrivateKey secretKey;

  CommercioECPrivateKey(this.secretKey);
}
