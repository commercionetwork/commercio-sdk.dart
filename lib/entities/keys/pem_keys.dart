import 'package:commerciosdk/entities/export.dart';

import 'package:pem/pem.dart';

class PEMPublicKey implements PublicKey {
  String pemKey;
  Uint8List keyData;

  PEMPublicKey({this.pemKey, this.keyData});

  @override
  Uint8List getEncoded() {
    return Uint8List.fromList(PemCodec(PemLabel.publicKey).decode(pemKey));
  }

  String getDecoded() {
    return PemCodec(PemLabel.publicKey).encode(keyData);
  }
}

class PEMPrivateKey implements PrivateKey {
  String pemKey;
  Uint8List keyData;

  PEMPrivateKey({this.pemKey, this.keyData});

  Uint8List getEncoded() {
    return Uint8List.fromList(PemCodec(PemLabel.privateKey).decode(pemKey));
  }

  String getDecoded() {
    return PemCodec(PemLabel.privateKey).encode(keyData);
  }
}
