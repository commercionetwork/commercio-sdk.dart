import 'package:commerciosdk/entities/export.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart' as ed25519;

///Wrapper of the Ed25519_hd_key
class Ed25519PublicKey implements PublicKey {
  final String Seed;

  Ed25519PublicKey(this.Seed);

  String get seed => Seed;

  @override
  Uint8List getEncoded() {
    final masterKey = ed25519.ED25519_HD_KEY.getMasterKeyFromSeed(this.Seed);
    return ed25519.ED25519_HD_KEY.getBublickKey(masterKey.key);
  }
}
