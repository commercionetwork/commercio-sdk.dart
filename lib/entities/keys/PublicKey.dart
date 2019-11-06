import 'package:commerciosdk/crypto/export.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';

///Interface for all sdk keys
abstract class PublicKey {
  Uint8List getEncoded();
}
