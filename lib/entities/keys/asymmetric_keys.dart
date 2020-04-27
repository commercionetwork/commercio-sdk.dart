import 'dart:typed_data';

import 'package:commerciosdk/entities/export.dart';

/// Represents a generic asymmetric private key
abstract class PrivateKey {}

/// Represents a generic asymmetric public key
abstract class PublicKey {
  final String _type;

  PublicKey(String type) : _type = type;

  String get type => _type;

  Uint8List getEncoded();
}
