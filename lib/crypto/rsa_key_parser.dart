import 'dart:convert';

import 'package:asn1lib/asn1lib.dart';
import 'package:pointycastle/export.dart' as pointyCastle;

/// Allows to easily parse a PEM-encoded RSA public key.
class RSAKeyParser {
  /// Reads the given [pemString] as a PEM-encoded RSA public key, returning
  /// the object representing the key itself.
  static pointyCastle.RSAPublicKey parsePublicKeyFromPem(String pemString) {
    List<int> publicKeyDER = _decodePEM(pemString);
    var asn1Parser = new ASN1Parser(publicKeyDER);
    var topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;
    var publicKeyBitString = topLevelSeq.elements[1];

    var publicKeyAsn = new ASN1Parser(publicKeyBitString.contentBytes());
    ASN1Sequence publicKeySeq = publicKeyAsn.nextObject();
    var modulus = publicKeySeq.elements[0] as ASN1Integer;
    var exponent = publicKeySeq.elements[1] as ASN1Integer;

    return pointyCastle.RSAPublicKey(
      modulus.valueAsBigInteger,
      exponent.valueAsBigInteger,
    );
  }

  /// Decodes the given [pem] string returning the represented bytes.
  static List<int> _decodePEM(String pem) {
    pem = pem.replaceAll('\n', '');
    pem = pem.replaceAll('\r', '');

    var startsWith = [
      "-----BEGIN PUBLIC KEY-----",
      "-----BEGIN RSA PUBLIC KEY-----"
    ];
    var endsWith = ["-----END PUBLIC KEY-----", "-----END RSA PUBLIC KEY-----"];
    bool isOpenPgp = pem.indexOf('BEGIN PGP') != -1;

    for (var s in startsWith) {
      if (pem.startsWith(s)) {
        pem = pem.substring(s.length);
      }
    }

    for (var s in endsWith) {
      if (pem.endsWith(s)) {
        pem = pem.substring(0, pem.length - s.length);
      }
    }

    if (isOpenPgp) {
      var index = pem.indexOf('\r\n');
      pem = pem.substring(0, index);
    }

    return base64.decode(pem);
  }
}
