import 'package:commerciosdk/crypto/export.dart' as byteArray;
import 'package:commerciosdk/entities/keys/PublicKey.dart';
import "package:asn1lib/asn1lib.dart";

class RSAPublicKey implements PublicKey {
  final BigInt modulus;
  final BigInt exponent;

  RSAPublicKey(this.modulus, this.exponent);

  BigInt get m => modulus;
  BigInt get e => exponent;

  @override
  byteArray.Uint8List getEncoded() {
    var pubKeySequence = ASN1Sequence();
    pubKeySequence.add(ASN1Integer(this.modulus));
    pubKeySequence.add(ASN1Integer(this.exponent));
    return byteArray.Uint8List.fromList(pubKeySequence.encodedBytes);
  }
}
