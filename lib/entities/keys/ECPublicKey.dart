import 'package:commerciosdk/crypto/export.dart' as byteArray;
import 'package:commerciosdk/entities/keys/PublicKey.dart';

class ECPublicKey implements PublicKey, byteArray.ECPublicKey {
  final byteArray.ECPoint q;
  final byteArray.ECDomainParameters param;

  ECPublicKey(this.q, this.param);

  @override
  byteArray.Uint8List getEncoded() {
    return this.Q.getEncoded(false);
  }

  @override
  byteArray.ECPoint get Q => q;

  @override
  byteArray.ECDomainParameters get parameters => param;
}
