# BurnCCC Helper

BurnCCC Helper allows to easily create a new BurnCCC object.

## Provided Operations

1. `fromWallet`, creates a BurnCCC from the given `wallet`, the `amount` to be burned and a MintCCC `id`.

   N.B.: `amount` is an object.

    ```dart
    static BurnCcc fromWallet({
      Wallet wallet,
      StdCoin amount,
      String id,
    })
    ```

## Usage examples

```dart
final wallet = Wallet.derive(mnemonic, networkInfo);
final amount = StdCoin(
  denom: 'uccc',
  amount: '10',
);
final id = '74fe4236-925b-4cdf-899b-0844de64eff3';

final burnCcc = BurnCccHelper.fromWallet(
  wallet: wallet,
  amount: amount,
  id: id,
);
```
