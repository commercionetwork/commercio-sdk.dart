# Invite User Helper

Invite User Helper allows to easily create an InviteUser object.

## Provided Operations

1. Creates an InviteUser from the given `wallet` and `recipientDid`.

    ```dart
    static InviteUser fromWallet(
      Wallet wallet,
      String recipientDid,
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

final inviteUser = InviteUserHelper.fromWallet(
  wallet, 'did:com:1crltcqwt9r0tpy9v0jnuu7lw6snl5k2wez8cca'
);
```
