# InviteUserHelper

`InviteUserHelper` allows to easily create an `InviteUser` object.

## Provided Operations

1. `fromWallet`, creates an `InviteUser` from the given `wallet` and `recipientDid`.

    ```dart
    static InviteUser fromWallet({
      required Wallet wallet,
      required String recipientDid,
    })
    ```

## Usage examples

```dart
final wallet = Wallet.derive(mnemonic, networkInfo);
final invite = InviteUserHelper.fromWallet(
  wallet: wallet,
  recipientDid: recipientAddress,
);
```
