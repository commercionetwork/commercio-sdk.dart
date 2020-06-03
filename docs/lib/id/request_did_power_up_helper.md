# Request Did PowerUp Helper

Request Did PowerUp Helper allows to easily create a Did PowerUp request.

## Provided Operations

1. Creates a RequestDidPowerUpHelper from the given `wallet`, `pairwiseDid`, `amount` and `privateKey`.

    ```dart
    static Future<RequestDidPowerUp> fromWallet(
      Wallet wallet,
      String pairwiseDid,
      List<StdCoin> amount,
      RSAPrivateKey privateKey,
    ) async
    ```

## Usage examples

```dart
final networkInfo = NetworkInfo(
  bech32Hrp: 'did:com:',
  lcdUrl: 'http://localhost:1317',
);

final mnemonic = ['will', 'hard', ..., 'man'];
final wallet = Wallet.derive(mnemonic, networkInfo);
final walletPariwaised = Wallet.derive(
  mnemonic, networkInfo, lastDerivationPathSegment: '1',
);

final amount = [
  StdCoin(
    denom: 'ucommercio',
    amount: '100',
  )
];

final rsaKey = RSAKeyParser.parseKeyFromPem(
  """
  -----BEGIN PRIVATE KEY-----
  MIIEvQ...
  -----END PRIVATE KEY-----
  """
);
final rsaPrivateKey = RSAPrivateKey(rsaKey);

final requestDidPowerUp = await RequestDidPowerUpHelper.fromWallet(
  wallet,
  walletPariwaised.bech32Address,
  amount,
  rsaPrivateKey,
);
```
