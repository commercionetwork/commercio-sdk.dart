import 'package:commerciosdk/crypto/export.dart';

///Interface for all sdk public keys
abstract class PubKey {
  Uint8List getEncoded();
}
