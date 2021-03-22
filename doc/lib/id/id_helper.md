# IdHelper

`IdHelper` allows to easily perform all the operations related to the commercio.network `id` module.

## Provided operations

1. `getDidDocument`, returns the `DidDocument` associated with the given `did` and `wallet`, or `null` if no `DidDocument` was found.

    ```dart
    static Future<DidDocument?> getDidDocument(
      String did,
      Wallet wallet, {
      http.Client? client,
    })
    ```

2. `setDidDocument`, performs a transaction setting the specified `didDocument` as being associated with the address present inside the specified `wallet`. Optionally `fee` and broadcasting `mode` parameters can be specified.

    ```dart
    static Future<TransactionResult> setDidDocument(
      DidDocument didDocument,
      Wallet wallet, {
      StdFee? fee,
      BroadcastingMode? mode,
      http.Client? client,
    })
    ```

3. `setDidDocumentsList`, performs a transaction setting the `didDocuments` list as being associated with the address present inside the specified `wallet`. Optionally `fee` and broadcasting `mode` parameters can be specified.

    ```dart
    static Future<TransactionResult> setDidDocumentsList(
      List<DidDocument> didDocuments,
      Wallet wallet, {
      StdFee? fee,
      BroadcastingMode? mode,
      http.Client? client,
    })
    ```

4. `requestDidPowerUp`, creates a new transaction to request a Did PowerUp of the given `amount` from the `senderWallet` wallet for the given `pairwiseDid` address. Signs everything that needs to be signed with the private key contained inside the given wallet and the `privateKey`. Optionally `fee` and broadcasting `mode` parameters can be specified.

    ```dart
    static Future<TransactionResult> requestDidPowerUp(
      Wallet senderWallet,
      String pairwiseDid,
      List<StdCoin> amount,
      CommercioRSAPrivateKey privateKey, {
      StdFee? fee,
      BroadcastingMode? mode,
    })
    ```

5. `requestDidPowerUpsList`, creates a new transaction from the sender `wallet` to request a list of Did PowerUp `requestDidPowerUpsList`. Optionally `fee` and broadcasting `mode` parameters can be specified.

    ```dart
    static Future<TransactionResult> requestDidPowerUpsList(
      List<RequestDidPowerUp> requestDidPowerUpsList,
      Wallet wallet, {
      StdFee? fee,
      BroadcastingMode? mode,
    })
    ```

## Usage examples

```dart
final networkInfo = NetworkInfo(
  bech32Hrp: 'did:com:',
  lcdUrl: 'http://localhost:1317',
);
final mnemonic = ['will', 'hard', ..., 'man'];
final wallet = Wallet.derive(mnemonic, networkInfo);
final pubKeys = [rsaVerificationPubKey, rsaSignaturePubKey];
final didDocument = DidDocumentHelper.fromWallet(
  wallet: wallet,
  pubKeys: pubKeys,
);

try {
  // Set the Did Document
  await IdHelper.setDidDocument(didDocument, wallet);
  // Send the PowerUp amount to the Tumbler
  final amount = [
    StdCoin(
      denom: 'uccc',
      amount: '10',
    )
  ];
  await TxHelper.createSignAndSendTx(
    [
      MsgSend(
        fromAddress: wallet.bech32Address,
        toAddress: tumblerAddress,
        amount: amount,
      ),
    ],
    wallet,
  );
  // Generate a pairwise wallet
  final pairwaiseWallet = Wallet.derive(
    mnemonic,
    networkInfo,
    lastDerivationPathSegment: '1',
  );
  // Generate a PowerUp request
  final requestDidPowerUp = await RequestDidPowerUpHelper.fromWallet(
    wallet: wallet,
    pairwiseDid: pairwaiseWallet.bech32Address,
    amount: amount,
    privateKey: rsaSignaturePriKey
  );
  // Send the PowerUp request
  await IdHelper.requestDidPowerUpsList(
    [requestDidPowerUp],
    wallet,
  );
} catch (error) {
  throw error;
}
```
