import 'package:commerciosdk/crypto/export.dart' as pointyCastle;
import 'package:commerciosdk/entities/keys/public_key.dart';

///Wrapper of the pointyCastle ECPublicKey
class ECPubKey implements PubKey{
  final pointyCastle.ECPublicKey pubKey;

  ECPubKey(this.pubKey);

  @override
  pointyCastle.Uint8List getEncoded() {
    return this.pubKey.Q.getEncoded(false);
  }
}
