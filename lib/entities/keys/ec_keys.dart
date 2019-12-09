import 'dart:typed_data';

import 'package:commerciosdk/entities/export.dart';
import 'package:pointycastle/export.dart' as pointy_castle;

/// Wrapper of the pointyCastle ECPublicKey
class ECPublicKey implements PublicKey {
  final pointy_castle.ECPublicKey pubKey;

  ECPublicKey(this.pubKey);

  @override
  Uint8List getEncoded() {
    return this.pubKey.Q.getEncoded(false);
  }
}

/// Wrapper of the pointyCastle ECPrivateKey
class ECPrivateKey implements PrivateKey {
  final pointy_castle.ECPrivateKey secretKey;

  ECPrivateKey(this.secretKey);
}
