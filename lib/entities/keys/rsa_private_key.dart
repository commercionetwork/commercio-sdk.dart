import 'package:commerciosdk/crypto/export.dart' as pointyCastle;
import 'package:commerciosdk/entities/keys/private_key.dart';

///Wrapper of the pointyCastle RSAPrivateKey
class RSASecretKey implements SecretKey {
  final pointyCastle.RSAPrivateKey secretKey;

  RSASecretKey(this.secretKey);
}
