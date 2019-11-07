import 'package:commerciosdk/crypto/export.dart' as pointyCastle;
import 'package:commerciosdk/entities/keys/public_key.dart';
import "package:asn1lib/asn1lib.dart";

///Wrapper of the pointyCastle RSAPublicKey
class RSAPubKey implements PubKey {
  final pointyCastle.RSAPublicKey pubKey;

  RSAPubKey(this.pubKey);

  @override
  pointyCastle.Uint8List getEncoded() {
    var pubKeySequence = ASN1Sequence();
    pubKeySequence.add(ASN1Integer(this.pubKey.modulus));
    pubKeySequence.add(ASN1Integer(this.pubKey.exponent));
    return pointyCastle.Uint8List.fromList(pubKeySequence.encodedBytes);
  }
}
