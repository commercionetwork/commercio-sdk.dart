# Commercio Doc Helper

Commercio Doc Helper allows to easily create a Commercio Doc.

## Provide Operations

1. Creates a `CommercioDoc` from the given `wallet`, `recipients`, `id`, `metadata` and optionally `contentUri`, `checksum`, `doSign`, `encryptedData`, `aesKey`.

   ```dart
   static Future<CommercioDoc> fromWallet({
      @required Wallet wallet,
      @required List<String> recipients,
      @required String id,
      @required CommercioDocMetadata metadata,
      String contentUri,
      CommercioDocChecksum checksum,
      CommercioDoSign doSign,
      List<EncryptedData> encryptedData,
      Key aesKey,
    }) async
   ```

## Usage examples

```dart
final networkInfo = NetworkInfo(
  bech32Hrp: 'did:com:',
  lcdUrl: 'http://localhost:1317',
);

final senderMnemonic = ['will', 'hard', ..., 'man'];
final senderWallet = Wallet.derive(senderMnemonic, networkInfo);

final recipientMnemonic = ['mad', 'accuse', ..., 'eternal'];
final recipientWallet = Wallet.derive(recipientMnemonic, networkInfo);

final docRecipientDid = recipientWallet.bech32Address;
final docId = Uuid().v4();

final checksum = CommercioDocChecksum(
  value: "a00ab326fc8a3dd93ec84f7e7773ac2499b381c4833e53110107f21c3b90509c",
  algorithm: CommercioDocChecksumAlgorithm.SHA256,
);

final doSign = CommercioDoSign(
  storageUri: "http://www.commercio.network",
  signerIstance: "did:com:1cc65t29yuwuc32ep2h9uqhnwrregfq230lf2rj",
  sdnData: [
    CommercioSdnData.COMMON_NAME,
    CommercioSdnData.SURNAME,
  ],
  vcrId: "xxxxx",
  certificateProfile: "xxxxx",
);

final commercioDoc = await CommercioDocHelper.fromWallet(
  wallet: senderWallet,
  recipients: [docRecipientDid],
  id: docId,
  metadata: CommercioDocMetadata(
    contentUri: 'https://example.com/document/metadata',
    schema: CommercioDocMetadataSchema(
      uri: 'https://example.com/custom/metadata/schema',
      version: '7.0.0',
    ),
  ),
  contentUri: 'https://example.com/document',
  checksum: checksum,
  doSign: doSign,
  encryptedData: [EncryptedData.CONTENT_URI],
);
```
