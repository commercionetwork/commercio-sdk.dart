# Mint helper

Mint helper allows to easily perform all the operations related to the commercio.network `mint` module.

## Provided operations

1. Opens a new CDP depositing the given `commercioTokenAmount`. Optionally `fee` and broadcasting `mode` parameters can be specified.

    ```dart
    static Future<TransactionResult> openCdp(
      int amount,
      Wallet wallet, {
      StdFee fee,
      BroadcastingMode mode,
    })
    ```

2. Performs a transaction opening a new CDP `openCdp` as being associated with the address present inside the specified `wallet`. Optionally `fee` and broadcasting `mode` parameters can be specified.

    ```dart
    static Future<TransactionResult> openCdpSingle(
      OpenCdp openCdp,
      Wallet wallet, {
      StdFee fee,
      BroadcastingMode mode,
    })
    ```

3. Closes the CDP having the given `timestamp`. Optionally `fee` and broadcasting `mode` parameters can be specified.

    ```dart
    static Future<TransactionResult> closeCdp(
      int timestamp,
      Wallet wallet, {
      StdFee fee,
      BroadcastingMode mode,
    })
    ```

4. Closes the open CDPs having the given `closeCdps` list as being associated with the address present inside the specified `wallet`. Optionally `fee` and broadcasting `mode` parameters can be specified.

    ```dart
    static Future<TransactionResult> closeCdpsList(
        List<CloseCdp> closeCdps,
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

// --- Open CDP
final openResponse = await MintHelper.openCdp(100000, wallet);

// --- Close CDP
final closeResponse = await MintHelper.closeCdp(777, wallet);
```
