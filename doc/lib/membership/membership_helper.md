# Membership helper

Membership helper allows to easily perform all the operations related to the commercio.network `membership` module.

## Provided operations

1. Sends a new transaction in order to invite the given `userDid`. Optionally `fee` and broadcasting `mode` parameters can be specified.

    ```dart
    static Future<TransactionResult> inviteUser(
      String userDid,
      Wallet wallet, {
      StdFee fee,
      BroadcastingMode mode,
    }) async
    ```

2. Sends a new transaction in order to invite the given `inviteUsers` users list. Optionally `fee` and broadcasting `mode` parameters can be specified.

    ```dart
    static Future<TransactionResult> inviteUsersList(
      List<InviteUser> inviteUsers,
      Wallet wallet, {
      StdFee fee,
      BroadcastingMode mode,
    }) async
    ```

3. Buys the membership with the given `membershipType`. Optionally `fee` and broadcasting `mode` parameters can be specified.

    ```dart
    static Future<TransactionResult> buyMembership(
      MembershipType membershipType,
      Wallet wallet, {
      StdFee fee,
      BroadcastingMode mode,
    }) async
    ```

4. Buys the membership with the given `buyMemberships` memberships list. Optionally `fee` and broadcasting `mode` parameters can be specified.

    ```dart
    static Future<TransactionResult> buyMembershipsList(
      List<BuyMembership> buyMemberships,
      Wallet wallet, {
      StdFee fee,
      BroadcastingMode mode,
    }) async
    ```

## Usage examples

```dart
final info = NetworkInfo(
  bech32Hrp: 'did:com:',
  lcdUrl: 'http://localhost:1317',
);

final userMnemonic = ['will', 'hard', ..., 'man'];
final userWallet = Wallet.derive(userMnemonic, info);

final newUserMnemonic = ['often', 'emerge', ..., 'arrest'];
final newUserWallet = Wallet.derive(newUserMnemonic, info);

try {
  // --- Invite user
  final inviteResponse =
    await MembershipHelper.inviteUser(
        newUserWallet.bech32Address,
        userWallet
    );

  // --- Buy a membership
  final buyResponse =
    await MembershipHelper.buyMembership(
        type: MembershipType.GOLD,
        wallet: newUserWallet
    );
} catch (error) {
  throw error;
}
```
