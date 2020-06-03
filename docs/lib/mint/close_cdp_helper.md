# Close Cdp Helper

Close Cdp Helper allows to easily create a CloseCdp object.

## Provided Operations

1. Creates a CloseCdp from the given `wallet` and `timeStamp`.
  N.B.: `timeStamp` is the 'height' at which the position was opened

    ```dart
    static CloseCdp fromWallet(
      Wallet wallet,
      int timeStamp,
    )
    ```

## Usage examples

```dart
final networkInfo = NetworkInfo(
  bech32Hrp: 'did:com:',
  lcdUrl: 'http://localhost:1317',
);

final mnemonic = ['will', 'hard', ..., 'man'];
final wallet = Wallet.derive(mnemonic, networkInfo);

final closeCdp = CloseCdpHelper.fromWallet(
  wallet,
  1234,
);
```
