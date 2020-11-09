import 'dart:convert';

import 'package:commerciosdk/entities/export.dart';
import 'package:pointycastle/export.dart' as pointy_castle;

/// Wrapper of the pointyCastle ECPublicKey
class ECPublicKey implements PublicKey {
  final pointy_castle.ECPublicKey pubKey;
  final String keyType;

  ECPublicKey(
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
class ECPrivateKey implements PrivateKey {
  final pointy_castle.ECPrivateKey secretKey;

  ECPrivateKey(this.secretKey);
}
