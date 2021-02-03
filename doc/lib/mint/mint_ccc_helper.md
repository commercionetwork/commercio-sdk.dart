# MintCCC Helper

MintCCC Helper allows to easily create a new MintCCC object.

## Provided Operations

1. `fromWallet`, creates a MintCCC from the given `wallet`, a deposit `amount` and the `id`.

   N.B.: `amount` ia a list, the `id` is a Version 4 UUID identifier.

    ```dart
    static MintCcc fromWallet({
      Wallet wallet,
      List<StdCoin> amount,
      String id,
    })
  ```

## Usage examples

```dart
final wallet = Wallet.derive(mnemonic, networkInfo);
final amount = [
  StdCoin(
    denom: 'uccc',
    amount: '10',
  ),
];
final id = Uuid().v4();

final mintCcc = MintCccHelper.fromWallet(
  wallet: wallet,
  amount: amount,
  id: id,
);
```
