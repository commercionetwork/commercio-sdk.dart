import 'package:commerciosdk/crypto/export.dart' as pointyCastle;
import 'package:commerciosdk/entities/keys/private_key.dart';

///Wrapper of the pointyCastle ECPrivateKey
class ECSecretKey implements SecretKey {
  final pointyCastle.ECPrivateKey secretKey;

  ECSecretKey(this.secretKey);
}
