# Mint helper

Mint helper allows to easily perform all the operations related to the commercio.network `mint` module.

## Provided operations

1. Opens a new CDP depositing the given `commercioTokenAmount`. Optionally custom `fee` and `mode` fields can be specified.

    ```dart
    static Future<TransactionResult> openCdp(
      int amount,
      Wallet wallet, {
      StdFee fee,
      String mode,
    })
    ```

2. Closes the CDP having the given `timestamp`. Optionally custom `fee` and `mode` fields can be specified.

    ```dart
    static Future<TransactionResult> closeCdp(
      int timestamp,
      Wallet wallet, {
      StdFee fee,
      String mode,
    })
    ```

## Usage examples

```dart
import 'package:commerciosdk/export.dart';
import 'commons.dart';

void main() async {
  final info = NetworkInfo(
    bech32Hrp: 'did:com:',
    lcdUrl: 'http://localhost:1317',
  );

  final mnemonic = ['will', 'hard', ..., 'man'];
  final wallet = Wallet.derive(mnemonic, info);

  // --- Open CDP
  final openResponse = await MintHelper.openCdp(100000, wallet);

  // --- Close CDP
  final closeResponse = await MintHelper.closeCdp(777, wallet);
}
```
