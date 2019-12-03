# Membership helper
Membership helper allows to easily perform all the operations related to the commercio.network `membership` module.
## Provided operations
1. Sends a new transaction in order to invite the given `userDid`
```dart
static Future<TransactionResult> inviteUser(
  String userDid,
  Wallet wallet,
) async
```
2. Buys the membership with the given `membershipType`
```dart
static Future<TransactionResult> buyMembership(
  MembershipType membershipType,
  Wallet wallet,
) async
```
## Usage examples
You can reach the examples code [here](https://github.com/commercionetwork/sdk.dart/tree/docs/example)

```dart
import 'package:commerciosdk/export.dart';
import 'commons.dart';

void main() async {
  final info = NetworkInfo(
    bech32Hrp: "did:com:",
    lcdUrl: "http://localhost:1317",
  );

  final userMnemonic = [
    "will",
    "hard",
    "topic",
    "spray",
    "beyond",
    "ostrich",
    "moral",
    "morning",
    "gas",
    "loyal",
    "couch",
    "horn",
    "boss",
    "across",
    "age",
    "post",
    "october",
    "blur",
    "piece",
    "wheel",
    "film",
    "notable",
    "word",
    "man"
  ];
  final userWallet = Wallet.derive(userMnemonic, info);

  final newUserMnemonic = [
    "often",
    "emerge",
    "table",
    "boat",
    "add",
    "crowd",
    "obtain",
    "creek",
    "skill",
    "flat",
    "master",
    "gift",
    "provide",
    "peasant",
    "famous",
    "blur",
    "flight",
    "lady",
    "elephant",
    "twenty",
    "join",
    "depth",
    "laptop",
    "arrest"
  ];
  final newUserWallet = Wallet.derive(newUserMnemonic, info);

  // --- Invite user
  final response = await MembershipHelper.inviteUser(
                          newUserWallet.bech32Address, 
                          userWallet
  );
  checkResponse(response);
  // --- Buy a membership
  final response = await MembershipHelper.buyMembership(
                           type: MembershipType.GOLD, 
                           wallet: newUserWallet
  );
  checkResponse(response);
}
```
