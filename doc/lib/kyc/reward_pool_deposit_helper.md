# RewardPoolDepositHelper

`RewardPoolDepositHelper` allows to easily create a `DepositRewardPool` object.

## Provided Operations

1. `fromWallet`, creates a `RewardPoolDeposit` from the given `wallet`, and deposit `amount`.

   N.B.: `amount` is a list.

    ```dart
    static RewardPoolDeposit fromWallet({
      @required Wallet wallet,
      @required List<StdCoin> amount,
    })
    ```

## Usage examples

```dart
final wallet = Wallet.derive(mnemonic, networkInfo);
final depositAmount = [
  StdCoin(
    denom: 'uccc',
    amount: '10',
  ),
];
final rewardPoolDeposit = RewardPoolDepositHelper.fromWallet(
  wallet: wallet,
  amount: depositAmount,
);
```
