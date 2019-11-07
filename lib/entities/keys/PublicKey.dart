import 'package:commerciosdk/crypto/export.dart';

///Interface for all sdk keys
abstract class LocalPublicKey {
  Uint8List getEncoded();
}
