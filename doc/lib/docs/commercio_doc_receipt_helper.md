# Commercio Doc Receipt Helper

Allows to easily create a CommercioDocReceipt and perform common related operations.

## Provide Operations

1. Creates a CommercioDoc from the given `wallet`, `recipient`, `txHash`, `documentId` and optionally a `proof`.

    ```dart
    static CommercioDocReceipt fromWallet({
      @required Wallet wallet,
      @required String recipient,
      @required String txHash,
      @required String documentId,
      String proof,
    })
    ```

## Usage examples

Suppose that we received a `MsgShareDocument` with our wallet address in the `recipients` list and we whant to send back a receipt. Let's assume that we check the transaction at http://localhost:1337/txs/3959641D57D8B6DE0DE7F71CFB636F3140AB0F8FD9976E996477C6AAD5FBF730 and extract the needed information to build our receipt in the following example:

```dart
// Configure the blockchain network
final networkInfo = NetworkInfo(
  bech32Hrp: 'did:com:',
  lcdUrl: 'http://localhost:1317',
);

// Build our wallet from the mnemonics
final mnemonic = ['mad', 'accuse', ..., 'eternal'];
final wallet = Wallet.derive(mnemonic, networkInfo);

// The received MsgShareDocument transaction hash
const txHash = '3959641D57D8B6DE0DE7F71CFB636F3140AB0F8FD9976E996477C6AAD5FBF730';

// The MsgShareDocument sender
const shareDocSender = 'did:com:1cc65t29yuwuc32ep2h9uqhnwrregfq230lf2rj';

// The MsgShareDocument UUID
const docId = '63df6ade-d2c7-490b-9191-f56f88c8e5eb';

final receipt = CommercioDocReceiptHelper.fromWallet(
  wallet: wallet,
  recipient: shareDocSender,
  txHash: txHash,
  documentId: docId,
);
```
