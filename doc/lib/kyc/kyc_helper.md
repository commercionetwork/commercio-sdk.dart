# KycHelper

`KycHelper` allows to easily perform all the operations related to the commercio.network `kyc` module.

## Provided operations

1. `buyMembershipsList`, buys the membership with the given memberships list `buyMemberships` and tsp `wallet`. Optionally `fee` and broadcasting `mode` parameters can be specified.

    ```dart
    static Future<TransactionResult> buyMembershipsList(
      List<BuyMembership> buyMemberships,
      Wallet wallet, {
      StdFee fee,
      BroadcastingMode mode,
    })
    ```

2. `inviteUsersList`, invite new users with the given users list `inviteUsers` and `wallet`. Optionally `fee` and broadcasting `mode` parameters can be specified.

    ```dart
    static Future<TransactionResult> inviteUsersList(
      List<InviteUser> inviteUsers,
      Wallet wallet, {
      StdFee fee,
      BroadcastingMode mode,
    })
    ```

3. `rewardPoolDepositsList`, deposit a list of deposits `rewardPoolDeposits` into reward pool
with the depositor `wallet`. Optionally `fee` and broadcasting `mode` parameters can be specified.

    ```dart
    static Future<TransactionResult> rewardPoolDepositsList(
      List<RewardPoolDeposit> rewardPoolDeposits,
      Wallet wallet, {
      StdFee fee,
      BroadcastingMode mode,
    })
    ```

## Usage examples

```dart
final wallet = Wallet.derive(mnemonic, networkInfo);
final government = Wallet.derive(govMnemonic, networkInfo);

try {
  // Invite a user
  final invite = InviteUserHelper.fromWallet(
    wallet: government,
    recipientDid: wallet.bech32Address,
  );
  await KycHelper.inviteUsersList([invite], wallet);
  // Recharge the user
  final amount = [
    const StdCoin(denom: 'uccc', amount: '100'),
  ];
  final msgs = [
    MsgSend(
      amount: amount,
      fromAddress: government.bech32Address,
      toAddress: wallet.bech32Address,
    ),
  ];
  await TxHelper.createSignAndSendTx(
    msgs,
    government,
  );
  // Buy a membership
  final membership = BuyMembershipHelper.fromWallet(
    wallet: wallet,
    membershipType: MembershipType.BRONZE,
    tsp: government.bech32Address,
  );
  await KycHelper.buyMembershipsList([membership], government);
  // Deposit into the reward pool
  final depositAmount = [
    StdCoin(
      denom: 'uccc',
      amount: '10',
    )
  ];
  final rewardPoolDeposit = RewardPoolDepositHelper.fromWallet(
      wallet: wallet,
      amount: depositAmount,
    );
  await KycHelper.rewardPoolDepositsList([rewardPoolDeposit], wallet);
} catch (error) {
  throw error;
}
```
