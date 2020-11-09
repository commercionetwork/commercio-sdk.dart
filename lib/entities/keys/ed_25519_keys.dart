import 'dart:convert';

import 'package:commerciosdk/entities/export.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart' as ed25519;

///Wrapper of the Ed25519_hd_key
class Ed25519PublicKey implements PublicKey {
  final String Seed;
  final String keyType;

  Ed25519PublicKey(
    this.Seed, {
    this.keyType,
  });

  String get seed => Seed;

  @override
  String getType() => keyType ?? 'Ed25519VerificationKey2018';

  @override
  String getEncoded() {
    final masterKey = ed25519.ED25519_HD_KEY.getMasterKeyFromSeed(Seed);
    return base64.encode(ed25519.ED25519_HD_KEY.getBublickKey(masterKey.key));
  }
}
