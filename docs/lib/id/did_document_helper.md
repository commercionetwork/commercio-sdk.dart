# Did Document Helper

Did Document Helper allows to easily create a Did Document.

## Provided Operations

1. Creates a [DidDocument](../glossary.md) from the given `wallet` and the `pubKeys`. Optionally the list `service` can be specified.

    ```dart
      static DidDocument fromWallet(
        Wallet wallet,
        List<PubKey> pubKeys, {
          List<DidDocumentService> service,
        }
      )
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

  // --- Generate keys
  final rsaVerificationKeyPair = await KeysHelper.generateRsaKeyPair();
  final rsaVerificationPubKey = rsaVerificationKeyPair.publicKey;
  final rsaSignatureKeyPair =
      await KeysHelper.generateRsaKeyPair(type: "RsaSignatureKey2018");
  final rsaSignaturePubKey = rsaSignatureKeyPair.publicKey;

  // --- Create Did Document
  final didDocument =  DidDocumentHelper.fromWallet(
      wallet,
      [rsaVerificationPubKey, rsaSignaturePubKey]
  );
}
```
