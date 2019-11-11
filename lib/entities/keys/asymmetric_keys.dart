import 'dart:typed_data';

/// Represents a generic asymmetric private key
abstract class PrivateKey {}

/// Represents a generic asymmetric public key
abstract class PublicKey {
  Uint8List getEncoded();
}
