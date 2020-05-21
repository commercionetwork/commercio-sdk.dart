# Docs helper

Docs helper allows to easily perform all the operations related to the commercio.network `docs` module.

## Provided operations

1. Creates a new transaction that allows to share the document associated with the given `metadata` and having the optional fields `contentUri`, `doSign`, `checksum`, `fee` and broadcasting `mode`.

   If `encryptedData` is specified, encrypts the proper data and optional `aesKey` for the specified `recipients` and then sends the transaction to the blockchain.

    ```dart
    static Future<TransactionResult> shareDocument({
      @required String id,
      @required CommercioDocMetadata metadata,
      @required List<String> recipients,
      @required Wallet wallet,
      CommercioDoSign doSign,
      CommercioDocChecksum checksum,
      Key aesKey,
      List<EncryptedData> encryptedData,
      StdFee fee,
      String contentUri,
      String mode,
    }) async
    ```

2. Returns the list of all the `CommercioDoc` that the specified `address` has sent

    ```dart
    static Future<List<CommercioDoc>> getSendDocuments(
      String address,
      Wallet wallet,
    ) async
    ```

3. Returns the list of all the `CommercioDoc` that the specified `address` has received

    ```dart
    static Future<List<CommercioDoc>> getReceivedDocuments(
      String address,
      Wallet wallet,
    ) async
    ```

4. Creates a new transaction which tells the `recipient` that the document having the specified `documentId` and present inside the transaction with `txHash` has been properly seen; optionally `proof` of reading, `fee` and broadcasting `mode`.

    ```dart
    static Future<TransactionResult> sendDocumentReceipt({
      String recipient,
      String txHash,
      String documentId,
      Wallet wallet,
      String proof = '',
      StdFee fee,
      String mode,
    }) async
    ```

5. Returns the list of all the `CommercioDocReceipt` that have been sent from the given `address`

    ```dart
    Future<List<CommercioDocReceipt>> getSentReceipts(
      String address,
      Wallet wallet,
    ) async
    ```

6. Returns the list of all the `CommercioDocRecepit` that have been received from the given `address`

    ```dart
    Future<List<CommercioDocReceipt>> getReceivedReceipts(
      String address,
      Wallet wallet,
    ) async
    ```

## Usage examples

```dart
import 'package:commerciosdk/export.dart';
import 'package:uuid/uuid.dart';
import 'commons.dart';

void main() async {
  final info = NetworkInfo(
    bech32Hrp: 'did:com:',
    lcdUrl: 'http://localhost:1317',
  );

  final senderMnemonic = ['will', 'hard', ..., 'man'];
  final senderWallet = Wallet.derive(senderMnemonic, info);

  final recipientMnemonic = ['crisp', 'become', ..., 'cereal'];
  final recipientWallet = Wallet.derive(recipientMnemonic, info);
  final recipientDid = recipientWallet.bech32Address;

  // --- Share a document
  final pair = await _shareDocument([recipientDid], senderWallet);

  // --- Send receipt
  final senderDid = senderWallet.bech32Address;
  await _sendReceipt(
    pair.first,
    pair.second,
    senderDid,
    recipientWallet,
  );
}

class Pair<F, S> {
  final F first;
  final S second;

  Pair(this.first, this.second);
}

/// Shows how to share a document to the given recipients.
/// Documentation: https://docs.commercio.network/x/docs/tx/send-document.html
Future<Pair<String, String>> _shareDocument(
  List<String> recipients,
  Wallet wallet,
) async {
  final docId = new Uuid().v4();

  final checksum = CommercioDocChecksum(
    value: 'a00ab326fc8a3dd93ec84f7e7773ac2499b381c4833e53110107f21c3b90509c',
    algorithm: CommercioDocChecksumAlgorithm.SHA256,
  );

  final doSign = CommercioDoSign(
    storageUri: 'http://www.commercio.network',
    signerIstance: 'did:com:1cc65t29yuwuc32ep2h9uqhnwrregfq230lf2rj',
    sdnData: [
      CommercioSdnData.COMMON_NAME,
      CommercioSdnData.SURNAME,
    ],
    vcrId: 'xxxxx',
    certificateProfile: 'xxxxx',
  );

  final response = await DocsHelper.shareDocument(
    id: docId,
    contentUri: 'https://example.com/document',
    metadata: CommercioDocMetadata(
      contentUri: 'https://example.com/document/metadata',
      schema: CommercioDocMetadataSchema(
        uri: 'https://example.com/custom/metadata/schema',
        version: '1.0.0',
      ),
    ),
    recipients: recipients,
    wallet: wallet,
    checksum: checksum,
    encryptedData: [EncryptedData.CONTENT_URI],
    doSign: doSign,
    fee: StdFee(
      gas: '200000',
      amount: [
        StdCoin(denom: 'ucommercio', amount: '10000'),
      ],
    ),
  );
  return Pair(docId, response.hash);
}

/// Shows how to send a document receipt to the specified [recipient] for
/// the given [docId] present inside the transaction having the given [txHash].
Future<TransactionResult> _sendReceipt(
  String documentId,
  String txHash,
  String recipient,
  Wallet wallet,
) async {
  return await DocsHelper.sendDocumentReceipt(
    recipient: recipient,
    txHash: txHash,
    documentId: documentId,
    wallet: wallet,
  );
}
```
