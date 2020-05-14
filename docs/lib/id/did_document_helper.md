# Did Document Helper

Did Helper allows to easily create a Did Document.

## Provided Operations

1. Creates a [DidDocument](../glossary.md) from the given `wallet` and optional [Public keys](../glossary.md)

    ```dart
      static DidDocument fromWallet(Wallet wallet, List<PubKey> pubKeys)
    ```  

## Usage examples

```dart
import 'package:commerciosdk/export.dart';
import 'commons.dart';

void main() async {
  final info = NetworkInfo(
    bech32Hrp: "did:com:",
    lcdUrl: "http://localhost:1317",
  );

  final userMnemonic = ["will", "hard", ..., "man"];
  final wallet = Wallet.derive(userMnemonic, info);

  // --- Create keys and Did Document
  final rsaVerificationKeyPair = await KeysHelper.generateRsaKeyPair();
  final rsaVerificationPubKey = rsaVerificationKeyPair.publicKey;
  final rsaSignatureKeyPair =
      await KeysHelper.generateRsaKeyPair(type: "RsaSignatureKey2018");
  final rsaSignaturePubKey = rsaSignatureKeyPair.publicKey;

  final didDocument =  DidDocumentHelper.fromWallet(
      wallet,
      [rsaVerificationPubKey, rsaSignaturePubKey]
  );
}
```
