import 'package:commerciosdk/entities/keys/asymmetric_keys.dart';

///An asymmetric pair of public and private asymmetric keys
class KeyPair<P extends PublicKey, S extends PrivateKey> {
  final P publicKey;
  final S privateKey;

  KeyPair(this.publicKey, this.privateKey);
}
