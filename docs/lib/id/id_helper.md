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

3. Create a new [Did power up request](../glossary.md) from `senderWallet` address for the given `pairwiseDid` and of the given `amount`.  
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

## Usage examples

```dart
import 'package:commerciosdk/export.dart';
import 'commons.dart';

void main() async {
  final info = NetworkInfo(
    bech32Hrp: 'did:com:',
    lcdUrl: 'http://localhost:1317',
  );

  final userMnemonic = ['will', 'hard', ..., 'man'];
  final userWallet = Wallet.derive(userMnemonic, info);

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

  // --- Set the Did Document
  await IdHelper.setDidDocument(didDocument, wallet);

  // --- Request the Did power up
  final pairwiseWallet = Wallet.derive(userMnemonic, info, '10');
  final depositAmount = [StdCoin(denom: 'ucommercio', amount: '100')];
  await IdHelper.requestDidPowerUp(
    userWallet,
    pairwiseWallet.bech32Address,
    depositAmount,
    rsaSignatureKeyPair.privateKey
  );
}
```
