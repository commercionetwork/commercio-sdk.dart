# Tx helper

Allows to easily perform common transaction operations.

## Provided operations

1. Creates a transaction having the given `msgs`, signs it with the given `Wallet` and sends it to the blockchain. Optional parameters can be `fee` and broadcasting `mode`, that can be of type "sync", "async" or "block".

```dart
static Future<TransactionResult> createSignAndSendTx(
  List<StdMsg> msgs,
  Wallet wallet, {
  StdFee fee,
  BroadcastingMode mode,
}) async
```
