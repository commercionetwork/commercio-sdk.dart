import 'package:commerciosdk/export.dart';
import 'package:x509csr/crypto.dart';
import 'commons.dart';

void main() async {
  final info = NetworkInfo(
    bech32Hrp: "did:com:",
    lcdUrl: "http://localhost:1317",
  );

  final userMnemonic = [
    "will",
    "hard",
    "topic",
    "spray",
    "beyond",
    "ostrich",
    "moral",
    "morning",
    "gas",
    "loyal",
    "couch",
    "horn",
    "boss",
    "across",
    "age",
    "post",
    "october",
    "blur",
    "piece",
    "wheel",
    "film",
    "notable",
    "word",
    "man"
  ];
  final userWallet = Wallet.derive(userMnemonic, info);

  final rsaKeyPair = await KeysHelper.generateRsaKeyPair();

  final certificate = CertificateHelper.X509CertificateFromWallet(
      userWallet.bech32Address,
      rsaKeyPair.publicKey.pubKey,
      rsaKeyPair.privateKey.secretKey);

  print(encodeCSRToPem(certificate));
}
