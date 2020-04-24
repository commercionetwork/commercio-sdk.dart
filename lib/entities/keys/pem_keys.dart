import 'package:commerciosdk/entities/export.dart';

import 'package:pem/pem.dart';

class PEMPublicKey implements PublicKey {
  String pemKey;

  PEMPublicKey([this.pemKey]);

  @override
  Uint8List getEncoded() {
    return Uint8List.fromList(PemCodec(PemLabel.publicKey).decode(pemKey));
  }

  static String getDecoded(Uint8List keyData) {
    return PemCodec(PemLabel.publicKey).encode(keyData);
  }
}

class PEMPrivateKey implements PrivateKey {
  String pemKey;

  PEMPrivateKey([this.pemKey]);

  Uint8List getEncoded() {
    return Uint8List.fromList(PemCodec(PemLabel.privateKey).decode(pemKey));
  }

  static String getDecoded(Uint8List keyData) {
    return PemCodec(PemLabel.privateKey).encode(keyData);
  }
}
