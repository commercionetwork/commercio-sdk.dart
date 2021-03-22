import 'package:commerciosdk/entities/keys/asymmetric_keys.dart';

///An asymmetric pair of public and private asymmetric keys
class CommercioKeyPair<P extends CommercioPublicKey,
    S extends CommercioPrivateKey> {
  final P publicKey;
  final S privateKey;

  CommercioKeyPair(this.publicKey, this.privateKey);
}
