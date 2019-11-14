# Did Document Helper
Did Helper allows to easily create a Did Document.


## Provided Operations
1. Creates a [DidDocument](../glossary.md) from the given `wallet` and optional [Public keys](../glossary.md)
```dart
  static DidDocument fromWallet(Wallet wallet, List<PubKey> pubKeys)
```  

## Usage examples
You can reach the examples code [here](https://github.com/commercionetwork/sdk.dart/tree/docs/example)

```dart
import 'package:commerciosdk/export.dart';
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

  // --- Create keys and Did Document
  final rsaKeyPair = await KeysHelper.generateRsaKeyPair();
  final ecKeyPair = await KeysHelper.generateEcKeyPair();
  final didDocument =  DidDocumentHelper.fromWallet(
                          userWallet, 
                          [rsaKeyPair.publicKey, ecKeyPair.publicKey]
  );
}
```
