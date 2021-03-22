# BuyMembershipHelper

`BuyMembershipHelper` allows to easily create a `BuyMembership` object.

## Provided Operations

1. `fromWallet`, creates a `BuyMembership` from the given `wallet`, the `membershipType` and `tsp` address.

    ```dart
    static BuyMembership fromWallet({
      required Wallet wallet,
      required MembershipType membershipType,
      required String tsp,
    })
    ```

## Usage examples

```dart
final wallet = Wallet.derive(mnemonic, networkInfo);
final membership = BuyMembershipHelper.fromWallet(
  wallet: wallet,
  membershipType: MembershipType.BRONZE,
  tsp: tspAddress,
);
```
