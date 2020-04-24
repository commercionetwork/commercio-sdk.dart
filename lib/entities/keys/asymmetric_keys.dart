import 'dart:typed_data';

import 'package:commerciosdk/entities/export.dart';

/// Represents a generic asymmetric private key
abstract class PrivateKey {}

/// Represents a generic asymmetric public key
abstract class PublicKey {
  final String type;

  PublicKey(this.type);

  String get keyType => type;

  Uint8List getEncoded();
}
