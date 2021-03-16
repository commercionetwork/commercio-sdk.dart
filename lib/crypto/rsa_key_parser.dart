import 'dart:convert';
import 'dart:typed_data';

import 'package:asn1lib/asn1lib.dart';
import 'package:pointycastle/export.dart';

/// RSA PEM parser.
class RSAKeyParser {
  static const String pkcs1PublicHeader = '-----BEGIN RSA PUBLIC KEY-----';
  static const String certPublicKeyHeader = '-----BEGIN PUBLIC KEY-----';
  static const String pkcs1PublicFooter = '-----END RSA PUBLIC KEY-----';
  static const String certPublicKeyFooter = '-----END PUBLIC KEY-----';

  static const String pkcs1PrivateHeader = '-----BEGIN RSA PRIVATE KEY-----';
  static const String pkcs8PrivateHeader = '-----BEGIN PRIVATE KEY-----';
  static const String pkcs1PrivateFooter = '-----END RSA PRIVATE KEY-----';
  static const String pkcs8PrivateFooter = '-----END PRIVATE KEY-----';

  static const String pkcsStartHeader = '-----BEGIN ';
  static const String pkcsStartFooter = '-----END';

  /// Parses the PEM key no matter it is public or private, it will figure it out.
  static RSAAsymmetricKey parseFromPem(String pem) {
    final lines = pem
        .split('\n')
        .map((String line) => line.trim())
        .where((String line) => line.isNotEmpty)
        .toList();

    final headerIndex = lines.indexWhere((s) => s.contains(pkcsStartHeader));
    final footerIndex = lines.indexWhere((s) => s.contains(pkcsStartFooter));

    final body = lines.sublist(headerIndex + 1, footerIndex).join('');
    final bodyBytes = base64Decode(body);

    if (lines[0].contains(pkcs1PublicHeader)) {
      return decodePKCS1PublicKey(bodyBytes);
    } else if (lines[0].contains(pkcs1PrivateHeader)) {
      return decodePKCS1PrivateKey(bodyBytes);
    } else if (lines[0].contains(pkcs8PrivateHeader)) {
      return decodePKCS8PrivateKey(bodyBytes);
    } else if (lines[0].contains(certPublicKeyHeader)) {
      return decodeCertPublicKey(bodyBytes) as RSAPublicKey;
    }

    throw ArgumentError('Could only parse PCKS1/PKCS8 RSA PEM files');
  }

  /// Format:
  /// ```
  /// RSAPublicKey ::= SEQUENCE {
  ///     modulus           INTEGER,  -- n
  ///     publicExponent    INTEGER   -- e
  /// }
  /// ```
  ///
  ///
  /// See: https://tools.ietf.org/html/rfc8017#appendix-A
  // TODO: In fact this decodes both PKCS Public Key types
  static RSAPublicKey decodePKCS1PublicKey(Uint8List bytes) {
    final topLevelParser = ASN1Parser(bytes);
    final topLevelBitStr = topLevelParser.nextObject();

    Uint8List pubKeyBytes;
    if (topLevelBitStr is ASN1BitString) {
      final pubKeySequence =
          ASN1Sequence.fromBytes(topLevelBitStr.contentBytes());
      pubKeyBytes = pubKeySequence.encodedBytes;
    } else {
      pubKeyBytes = bytes;
    }

    final parser = ASN1Parser(pubKeyBytes);

    if (!parser.hasNext()) {
      throw ArgumentError('Not a ASN.1 sequence');
    }

    final seq = parser.nextObject() as ASN1Sequence;

    if (seq.elements.length != 2) {
      throw ArgumentError(
          'RSAPublicKey must have exacly 2 elements in sequence');
    }

    final modulus = seq.elements[0] as ASN1Integer;
    final pubExp = seq.elements[1] as ASN1Integer;

    return RSAPublicKey(modulus.valueAsBigInteger!, pubExp.valueAsBigInteger!);
  }

  /// Format:
  /// ```
  /// RSAPrivateKey ::= SEQUENCE {
  ///     version           Version,
  ///     modulus           INTEGER,  -- n
  ///     publicExponent    INTEGER,  -- e
  ///     privateExponent   INTEGER,  -- d
  ///     prime1            INTEGER,  -- p
  ///     prime2            INTEGER,  -- q
  ///     exponent1         INTEGER,  -- d mod (p-1)
  ///     exponent2         INTEGER,  -- d mod (q-1)
  ///     coefficient       INTEGER,  -- (inverse of q) mod p
  ///     otherPrimeInfos   OtherPrimeInfos OPTIONAL
  /// }
  /// ```
  ///
  /// See: https://tools.ietf.org/html/rfc8017#appendix-A
  static RSAPrivateKey decodePKCS1PrivateKey(Uint8List bytes) {
    final parser = ASN1Parser(bytes);

    if (!parser.hasNext()) {
      throw ArgumentError('Not a ASN.1 sequence');
    }

    final seq = parser.nextObject() as ASN1Sequence;

    final modulus = seq.elements[1] as ASN1Integer;
    final privExp = seq.elements[3] as ASN1Integer;
    final p = seq.elements[4] as ASN1Integer;
    final q = seq.elements[5] as ASN1Integer;

    return RSAPrivateKey(
      modulus.valueAsBigInteger!,
      privExp.valueAsBigInteger!,
      p.valueAsBigInteger,
      q.valueAsBigInteger,
    );
  }

  /// Plain PKCS8 private key format:
  /// ```
  /// PrivateKeyInfo ::= SEQUENCE {
  ///  version Version,
  ///  privateKeyAlgorithm AlgorithmIdentifier {{PrivateKeyAlgorithms}},
  ///  privateKey PrivateKey,
  ///  attributes [0] Attributes OPTIONAL
  /// }
  ///
  /// Version ::= INTEGER {v1(0)} (v1,...)
  /// PrivateKey ::= OCTET STRING
  /// ```
  static RSAPrivateKey decodePKCS8PrivateKey(Uint8List bytes) {
    final parser = ASN1Parser(bytes);

    if (!parser.hasNext()) {
      throw ArgumentError('Not a ASN.1 sequence');
    }

    // Let's assume that is always a PKCS1 key

    final seq = parser.nextObject() as ASN1Sequence;
    final privateKey = seq.elements[2] as ASN1OctetString;

    return decodePKCS1PrivateKey(privateKey.octets);
  }

  /// Format:
  /// ```
  /// SubjectPublicKeyInfo  ::=  SEQUENCE  {
  ///    algorithm            AlgorithmIdentifier,
  ///    subjectPublicKey     BIT STRING
  /// }
  ///
  /// AlgorithmIdentifier  ::=  SEQUENCE  {
  ///     algorithm           OBJECT IDENTIFIER,
  ///     parameters          ANY DEFINED BY algorithm OPTIONAL
  /// }
  /// ```
  static PublicKey decodeCertPublicKey(Uint8List bytes) {
    final parser = ASN1Parser(bytes);

    if (!parser.hasNext()) {
      throw ArgumentError('Not a ASN.1 sequence');
    }

    final pubKeyInfoSeq = parser.nextObject() as ASN1Sequence;
    final algorithmIdentifier = pubKeyInfoSeq.elements[0] as ASN1Sequence;
    final algorithm = algorithmIdentifier.elements[0] as ASN1ObjectIdentifier;

    if (algorithm.identifier!.contains('1.2.840.113549.1.1.1')) {
      final subjectPubKey = pubKeyInfoSeq.elements[1] as ASN1BitString;
      return decodePKCS1PublicKey(subjectPubKey.encodedBytes);
    }

    throw ArgumentError('Could only decode PKCS1 RSA Public Key');
  }
}
