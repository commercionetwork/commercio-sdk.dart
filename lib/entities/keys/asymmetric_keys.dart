/// Represents a generic asymmetric private key
abstract class PrivateKey {}

/// Represents a generic asymmetric public key
abstract class PublicKey {
  String getEncoded();
  String getType();
}
