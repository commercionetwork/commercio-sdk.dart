import 'package:commerciosdk/entities/keys/public_key.dart';
import 'package:commerciosdk/entities/keys/private_key.dart';

///An asymmetric pair of public and private asymmetric keys
class KeyPair<P extends PubKey, S extends SecretKey> {
  final P publicKey;
  final S privateKey;

  KeyPair(this.publicKey, this.privateKey);
}
