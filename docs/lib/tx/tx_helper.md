# Tx helper

Allows to easily perform common transaction operations.

## Provided operations

1. Creates a transaction having the given `msgs`, `fee` and `mode` inside, signs it with the given `wallet` and sends it to the blockchain

```dart
static Future<TransactionResult> createSignAndSendTx(
  List<StdMsg> msgs,
  Wallet wallet, {
  StdFee fee,
  String mode,
}) async
```
