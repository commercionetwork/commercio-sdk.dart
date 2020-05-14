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
     {StdFee fee}
   )
   ```

3. Create a new [Did power up request](../glossary.md) for the given `pairwiseDid` and of the given `amount`.  
Signs everything that needs to be signed (i.e. the signature JSON inside the payload) with the private key contained inside the given `wallet`

   ```dart
   Future<TransactionResult> requestDidPowerUp(
     String pairwiseDid,
     List<StdCoin> amount,
     Wallet wallet,
     {StdFee fee}
   ) async
   ```

## Usage examples

```dart
void main() async {
  final info = NetworkInfo(
    bech32Hrp: "did:com:",
    lcdUrl: "http://localhost:1317",
  );

  // --- Create user wallet
  final userMnemonic = ["will", "hard", ..., "man"];
  final userWallet = Wallet.derive(userMnemonic, info);

  // --- Create verification RSA public key
  const String PUB_KEY_PEM_VERIFICATION = """
  -----BEGIN PUBLIC KEY-----
  MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArC0ApIgc5MmQ2s...
  -----END PUBLIC KEY-----
  """;
  final pubKeyVerification = RSAKeyParser.parsePublicKeyFromPem(PUB_KEY_PEM_VERIFICATION);
  final rsaPubKeyVerification = RSAPublicKey(pubKeyVerification, keyType: "RsaVerificationKey2018");

  // --- Create signature RSA public key
  const String PUB_KEY_PEM_SIGNATURE = """
  -----BEGIN PUBLIC KEY-----
  MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA+Juw6xqYchTNFY...
  -----END PUBLIC KEY-----
  """;
  final pubKeySignature = RSAKeyParser.parsePublicKeyFromPem(PUB_KEY_PEM_SIGNATURE);
  final rsaPubKeySignature = RSAPublicKey(pubKeySignature, keyType: "RsaSignatureKey2018");

  // --- Create Did Document
  final didDocument =  DidDocumentHelper.fromWallet(
    userWallet,
    [rsaPubKeyVerification, rsaPubKeySignature],
  );
  
  // --- Set the Did Document
  await IdHelper.setDidDocument(didocument, userWallet);

  // --- Send power up to the Tumbler
  const tumblerAddress = "did:com:1z...";
  final depositAmount = [StdCoin(denom: "ucommercio", amount: "10")];
  final msgs = [
    MsgSend(
      amount: depositAmount,
      fromAddress: userWallet.bech32Address,
      toAddress: tumblerAddress,
    ),
  ];

  final res = await TxHelper.createSignAndSendTx(
    msgs,
    userWallet,
  );

  // --- Request the Did power up
  final pairwiseWallet = Wallet.derive(
    userMnemonic,
    info,
    lastDerivationPathSegment: '10',
  );

  await IdHelper.requestDidPowerUp(
    pairwiseWallet.bech32Address,
    depositAmount,
    userWallet,
  );
}
```
