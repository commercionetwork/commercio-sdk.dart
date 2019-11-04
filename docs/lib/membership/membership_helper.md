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
