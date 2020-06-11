# Open Cdp Helper

Open Cdp Helper allows to easily create a OpenCdp object.

## Provided Operations

1. Creates an OpenCdp from the given `wallet` and deposit `amount`.

    ```dart
    static OpenCdp fromWallet(
      Wallet wallet,
      List<StdCoin> amount,
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

final amount = [
  StdCoin(denom: 'ucommercio', amount: '10')
];

final openCdp = OpenCdpHelper.fromWallet(
  wallet, amount
);
```
