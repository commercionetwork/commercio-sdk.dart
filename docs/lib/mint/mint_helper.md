# Mint helper
Mint helper allows to easily perform all the operations related to the commercio.network `mint` module.

# Provided operations

1. Opens a new [CDP](../glossary.md) depositing the given `commercioTokenAmount`
```dart
static Future<TransactionResult> openCdp(
  int commercioTokenAmount,
  Wallet wallet,
) 
```
2. Closes the CDP having the given `timestamp`.
```dart
static Future<TransactionResult> closeCdp(
  String timestamp,
  Wallet wallet,
) 
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

  // --- Open CDP
  final response = await MintHelper.openCdp(100000, userWallet);
  checkResponse(response);

  // --- Close CDP
  final response = await MintHelper.closeCdp(757, userWallet);
  checkResponse(response);
}
```
