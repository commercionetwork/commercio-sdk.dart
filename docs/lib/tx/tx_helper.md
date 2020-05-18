# Tx helper

Allows to easily perform common transaction operations.

## Provided operations

1. Creates a transaction having the given `msgs` and `fee` inside, signs it with the given `wallet` and sends it to the blockchain

```dart
static Future<TransactionResult> createSignAndSendTx(
  List<StdMsg> msgs,
  Wallet wallet, {
  StdFee fee = const StdFee(
    gas: "200000",
    amount: [const StdCoin(denom: "ucommercio", amount: "100")]),
}) async
```
