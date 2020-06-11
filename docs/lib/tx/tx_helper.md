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

## Usage examples

```dart
final info = NetworkInfo(
  bech32Hrp: 'did:com:',
  lcdUrl: 'http://localhost:1317',
);

final mnemonic = ['will', 'hard', ..., 'man'];
final wallet = Wallet.derive(mnemonic, info);

final deposit = StdCoin(denom: 'ucommercio', amount: '10');
final msgDeposit = MsgSend(
  fromAddress: wallet.bech32Address,
  toAddress: "did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau",
  amount: [deposit],
);

try {
  await TxHelper.createSignAndSendTx([msgDeposit], wallet);
} catch (error) {
  throw error;
}
```
