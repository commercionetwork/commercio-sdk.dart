/// Represents a generic asymmetric private key
abstract class CommercioPrivateKey {}

/// Represents a generic asymmetric public key
abstract class CommercioPublicKey {
  Future<String> getEncoded();
  String getType();
}
