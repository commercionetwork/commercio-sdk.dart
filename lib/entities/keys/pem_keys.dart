import 'package:commerciosdk/entities/export.dart';

import 'package:pem/pem.dart';

class PEMPublicKey {
  static Uint8List getDecoded(String pemKey) {
    return Uint8List.fromList(PemCodec(PemLabel.publicKey).decode(pemKey));
  }

  static String getEncoded(Uint8List keyData) {
    return PemCodec(PemLabel.publicKey).encode(keyData);
  }
}

class PEMPrivateKey {
  Uint8List getDecoded(String pemKey) {
    return Uint8List.fromList(PemCodec(PemLabel.privateKey).decode(pemKey));
  }

  static String getEncoded(Uint8List keyData) {
    return PemCodec(PemLabel.privateKey).encode(keyData);
  }
}
