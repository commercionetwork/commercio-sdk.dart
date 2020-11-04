# Buy Membership Helper

Buy Membership Helper allows to easily create a Buy Membership object.

## Provided Operations

1. Creates a BuyMembership from the given `wallet` and `membershipType`.

    ```dart
    static BuyMembership fromWallet(
      Wallet wallet,
      MembershipType membershipType,
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

final buyMembership = BuyMembershipHelper.fromWallet(
  wallet, MembershipType.GOLD,
);
```
