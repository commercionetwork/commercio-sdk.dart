# Membership helper

Membership helper allows to easily perform all the operations related to the commercio.network `membership` module.

## Provided operations

1. Sends a new transaction in order to invite the given `userDid`. Optionally custom `fee` and `mode` fields can be specified.

    ```dart
    static Future<TransactionResult> inviteUser(
      String userDid,
      Wallet wallet, {
      StdFee fee,
      String mode,
    }) async
    ```

2. Buys the membership with the given `membershipType`. Optionally custom `fee` and `mode` fields can be specified.

    ```dart
    static Future<TransactionResult> buyMembership(
      MembershipType membershipType,
      Wallet wallet, {
      StdFee fee,
      String mode,
    }) async
    ```

## Usage examples

```dart
import 'package:commerciosdk/export.dart';
import 'commons.dart';

void main() async {
  final info = NetworkInfo(
    bech32Hrp: 'did:com:',
    lcdUrl: 'http://localhost:1317',
  );

  final userMnemonic = ['will', 'hard', ..., 'man'];
  final userWallet = Wallet.derive(userMnemonic, info);

  final newUserMnemonic = ['often', 'emerge', ..., 'arrest'];
  final newUserWallet = Wallet.derive(newUserMnemonic, info);

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
}
```
