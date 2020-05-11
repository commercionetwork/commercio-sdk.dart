# Id helper

Id helper allows to easily perform all the operations related to the commercio.network `id` module.

## Provided operations

1. Returns the [DidDocument](../glossary.md) associated with the given [did](../glossary.md), or null if no `DidDocument` was found

   ```dart
   static Future<DidDocument> getDidDocument(String did, Wallet wallet) async
   ```

2. Performs a transaction setting the specified `DidDocument` as being associated with the address present inside the specified `wallet`

   ```dart
   static Future<TransactionResult> setDidDocument(
     DidDocument didDocument,
     Wallet wallet,
   )
   ```

3. Create a new [Did power up request](../glossary.md) for the given `pairwiseDid` and of the given `amount`.  
Signs everything that needs to be signed (i.e. the signature JSON inside the payload) with the private key contained inside the given `wallet`

   ```dart
   Future<TransactionResult> requestDidPowerUp(
     String pairwiseDid,
     List<StdCoin> amount,
     Wallet wallet
   ) async
   ```

## Usage examples

```dart
import 'package:commerciosdk/export.dart';
import 'commons.dart';

void main() async {
  final info = NetworkInfo(
    bech32Hrp: "did:com:",
    lcdUrl: "http://localhost:1317",
  );

  final userMnemonic = ["will", "hard", ..., "man"];

  final userWallet = Wallet.derive(userMnemonic, info);

  // --- Create Did Document
  final rsaVerificationKeyPair = await KeysHelper.generateRsaKeyPair();
  final rsaVerificationPubKey = rsaVerificationKeyPair.publicKey;
  final rsaSignatureKeyPair =
      await KeysHelper.generateRsaKeyPair(type: "RsaSignatureKey2018");
  final rsaSignaturePubKey = rsaSignatureKeyPair.publicKey;

  final didDocument =  DidDocumentHelper.fromWallet(
      wallet,
      [rsaVerificationPubKey, rsaSignaturePubKey]
  );
  
  // --- Set the Did Document
  await IdHelper.setDidDocument(didocument, wallet);

  // --- Request the Did power up
  final pairwiseMnemonic = [
    "push",
    "grace",
    "power",
    "desk",
    "arrive",
    "horror",
    "gallery",
    "physical",
    "kingdom",
    "ecology",
    "fat",
    "firm",
    "future",
    "service",
    "table",
    "little",
    "live",
    "reason",
    "maximum",
    "short",
    "motion",
    "planet",
    "stage",
    "second"
  ];

  final pairwiseWallet = Wallet.derive(pairwiseMnemonic, info);

  final depositAmount = [StdCoin(denom: "ucommercio", amount: "100")];

  await IdHelper.requestDidPowerUp(
    pairwiseWallet.bech32Address,
    depositAmount,
    userWallet,
  );
}
```
