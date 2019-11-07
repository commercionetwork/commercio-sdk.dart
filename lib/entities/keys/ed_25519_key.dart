import 'package:commerciosdk/entities/keys/public_key.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart' as ed25519;
import 'package:commerciosdk/crypto/export.dart' as byteArray;

///Wrapper of the Ed25519_hd_key
class Ed25519PublicKey implements PubKey {
  final String Seed;

  Ed25519PublicKey(this.Seed);

  String get seed => Seed;

  @override
  byteArray.Uint8List getEncoded() {
    final masterKey = ed25519.ED25519_HD_KEY.getMasterKeyFromSeed(this.Seed);
    return ed25519.ED25519_HD_KEY.getBublickKey(masterKey.key);
  }


}
