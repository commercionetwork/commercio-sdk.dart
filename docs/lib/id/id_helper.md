# Id helper

Id helper allows to easily perform all the operations related to the commercio.network `id` module.

## Provided operations

1. Returns the [DidDocument](../glossary.md) associated with the given [did](../glossary.md), or `null` if no `DidDocument` was found

   ```dart
   static Future<DidDocument> getDidDocument(String did, Wallet wallet) async
   ```

2. Performs a transaction setting the specified `didDocument` as being associated with the address present inside the specified `wallet`. Optionally `fee` and broadcasting `mode` parameters can be specified.

   ```dart
   static Future<TransactionResult> setDidDocument(
      DidDocument didDocument,
      Wallet wallet, {
      StdFee fee,
      BroadcastingMode mode,
    })
   ```

3. Performs a transaction setting the `didDocuments` list as being associated with the address present inside the specified `wallet`. Optionally `fee` and broadcasting `mode` parameters can be specified.

    ```dart
    static Future<TransactionResult> setDidDocumentsList(
        List<DidDocument> didDocuments,
        Wallet wallet, {
        StdFee fee,
        BroadcastingMode mode,
      })
    ```

4. Create a new [Did power up request](../glossary.md) from `senderWallet` address for the given `pairwiseDid` and of the given `amount`.  
Signs everything that needs to be signed (i.e. the signature JSON inside the payload) with the private key contained inside the given `senderWallet` and the `private key`. Optionally `fee` and broadcasting `mode` parameters can be specified.

    ```dart
    static Future<TransactionResult> requestDidPowerUp(
      Wallet senderWallet,
      String pairwiseDid,
      List<StdCoin> amount,
      RSAPrivateKey privateKey, {
      StdFee fee,
      BroadcastingMode mode,
    }) async
    ```

5. Sends a new transaction from the sender `wallet` to request a list of Did PowerUp `requestDidPowerUpsList`. Optionally `fee` and broadcasting `mode` parameters can be specified.

    ```dart
    static Future<TransactionResult> requestDidPowerUpsList(
      List<RequestDidPowerUp> requestDidPowerUpsList,
      Wallet wallet, {
      StdFee fee,
      BroadcastingMode mode,
    })
    ```

## Usage examples

```dart
final info = NetworkInfo(
  bech32Hrp: 'did:com:',
  lcdUrl: 'http://localhost:1317',
);

final mnemonic = ['will', 'hard', ..., 'man'];
final wallet = Wallet.derive(mnemonic, info);

final rsaVerificationKeyPair = await KeysHelper.generateRsaKeyPair();
final rsaVerificationPubKey = rsaVerificationKeyPair.publicKey;
final rsaSignatureKeyPair =
    await KeysHelper.generateRsaKeyPair(type: 'RsaSignatureKey2018');
final rsaSignaturePubKey = rsaSignatureKeyPair.publicKey;

// --- Create Did Document
final didDocument =  DidDocumentHelper.fromWallet(
    wallet,
    [rsaVerificationPubKey, rsaSignaturePubKey]
);

try {
  // --- Set the Did Document
  await IdHelper.setDidDocument(didDocument, wallet);

  // Send Power Up to the Tumbler
  final depositAmount = [StdCoin(denom: 'ucommercio', amount: '100')];
  final msgDeposit = MsgSend(...

  await TxHelper.createSignAndSendTx([msgDeposit], wallet);

  // --- Request the Did power up
  final pairwiseWallet = Wallet.derive(
    userMnemonic, info, lastDerivationPathSegment: '1'
  );
  await IdHelper.requestDidPowerUp(
    userWallet,
    pairwiseWallet.bech32Address,
    depositAmount,
    rsaSignatureKeyPair.privateKey
  );
} catch (error) {
  throw error;
}
```
