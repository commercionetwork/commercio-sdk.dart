import 'dart:convert';

import 'package:commerciosdk/entities/export.dart';
import 'package:cryptography/cryptography.dart';

///Wrapper of the Ed25519_hd_key
class Ed25519PublicKey implements CommercioPublicKey {
  final Uint8List seed;
  final String? keyType;

  Ed25519PublicKey(
    this.seed, {
    this.keyType,
  });

  @override
  String getType() => keyType ?? 'Ed25519VerificationKey2018';

  @override
  Future<String> getEncoded() async {
    const ed25519Key = Ed25519HdKey();
    final masterKey = await ed25519Key.getMasterKeyFromSeed(seed);
    final key = Uint8List.fromList(masterKey.key);
    final pubKey = await ed25519Key.getPublicKey(key);

    return base64.encode(pubKey);
  }
}

/// Implementation of ED25519 private key derivation from master private key
class Ed25519HdKey {
  static const String _ED25519_CURVE = 'ed25519 seed';
  static const int _HARDENED_OFFSET = 0x80000000;

  static final _curveBytes = Uint8List.fromList(utf8.encode(_ED25519_CURVE));
  static final _pathRegex = RegExp(r"^(m\/)?(\d+'?\/)*\d+'?$");

  const Ed25519HdKey();

  Future<_KeyData> derivePath(
    String path,
    Uint8List seedBytes, {
    int offset = _HARDENED_OFFSET,
  }) async {
    if (!_pathRegex.hasMatch(path)) {
      throw ArgumentError(
          'Invalid derivation path. Expected BIP32 path format');
    }

    final master = getMasterKeyFromSeed(seedBytes);
    final segments = path.split('/').sublist(1);

    return segments.fold<Future<_KeyData>>(master,
        (prevKeyData, indexStr) async {
      final index = int.parse(indexStr.substring(0, indexStr.length - 1));
      final prev = await prevKeyData;
      final priv = await _getCKDPriv(prev, index + offset);

      return priv;
    });
  }

  Future<Uint8List> getPublicKey(
    Uint8List privateKey, {
    bool withZeroByte = true,
  }) async {
    final ed25519 = Ed25519();
    final signature = await ed25519.newKeyPairFromSeed(privateKey);
    final publicKey = await signature.extractPublicKey();

    if (withZeroByte == true) {
      final dataBytes = Uint8List(33);
      dataBytes[0] = 0x00;
      dataBytes.setRange(1, 33, publicKey.bytes);
      return dataBytes;
    } else {
      return Uint8List.fromList(publicKey.bytes);
    }
  }

  Future<_KeyData> getMasterKeyFromSeed(Uint8List seedBytes) =>
      _getKeys(seedBytes, _curveBytes);

  Future<_KeyData> _getCKDPriv(_KeyData data, int index) {
    final dataBytes = Uint8List(37);
    dataBytes[0] = 0x00;
    dataBytes.setRange(1, 33, data.key);
    dataBytes.buffer.asByteData().setUint32(33, index);

    return _getKeys(dataBytes, data.chainCode);
  }

  Future<_KeyData> _getKeys(Uint8List data, Uint8List keyParameter) async {
    final hmac =
        await Hmac.sha512().newMacSink(secretKey: SecretKey(keyParameter));
    hmac
      ..add(data)
      ..close();

    final mac = await hmac.mac();
    final i = mac.bytes;
    final iL = Uint8List.fromList(i.sublist(0, 32));
    final iR = Uint8List.fromList(i.sublist(32));

    return _KeyData(key: iL, chainCode: iR);
  }
}

class _KeyData {
  const _KeyData({required this.key, required this.chainCode});

  final Uint8List key;
  final Uint8List chainCode;
}
