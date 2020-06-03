# Commercio Doc Receipt Helper

Allows to easily create a CommercioDocReceipt and perform common related operations.

## Provide Operations

1. Creates a CommercioDoc from the given `wallet`, `recipient`, `txHash`, `documentId` and optionally `proof`.

    ```dart
    static CommercioDocReceipt fromWallet({
      @required Wallet wallet,
      @required String recipient,
      @required String txHash,
      @required String documentId,
      String proof = "",
    })
    ```

## Usage examples

```dart
...
final docId = Uuid().v4();
final response = await DocsHelper.shareDocumentsList(
  [commercioDoc],
  senderWallet,
);
String txHash = response.hash;
...

final networkInfo = NetworkInfo(
  bech32Hrp: 'did:com:',
  lcdUrl: 'http://localhost:1317',
);

final senderDid = senderWallet.bech32Address;
final recipientMnemonic = ['mad', 'accuse', ..., 'eternal'];
final recipientWallet = Wallet.derive(recipientMnemonic, networkInfo);

final receipt = CommercioDocReceiptHelper.fromWallet(
  wallet: recipientWallet,
  recipient: senderDid,
  txHash: txHash,
  documentId: docId,
);
```
