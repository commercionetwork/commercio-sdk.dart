import 'package:commerciosdk/entities/keys/PublicKey.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart' as ed25519;
import 'package:commerciosdk/crypto/export.dart' as byteArray;

class Ed25519Key implements LocalPublicKey {
  final String Seed;

  Ed25519Key(this.Seed);

  @override
  byteArray.Uint8List getEncoded() {
    final masterKey = ed25519.ED25519_HD_KEY.getMasterKeyFromSeed(this.Seed);
    return ed25519.ED25519_HD_KEY.getBublickKey(masterKey.key);
  }
}
