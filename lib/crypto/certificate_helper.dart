
import 'package:pointycastle/export.dart' as pc;
import "package:x509csr/x509csr.dart";

import "package:pointycastle/export.dart";
import 'package:asn1lib/asn1lib.dart';

/// Allows to create an x509 certificate from wallet address and key pair.
class CertificateHelper {
  static ASN1Object X509CertificateFromWallet(String walletAddress, pc.RSAPublicKey publicKey, pc.RSAPrivateKey privateKey) {
    ASN1ObjectIdentifier.registerFrequentNames();
    final dn = {"CN": walletAddress};

    final encodedCSR = makeRSACSR(dn, privateKey, publicKey);

    return encodedCSR;
  }
}
