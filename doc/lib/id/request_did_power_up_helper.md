# RequestDidPowerUpHelper

`RequestDidPowerUpHelper` allows to easily create a `RequestDidPowerUp` object.

## Provided Operations

1. `fromWallet`, creates a `RequestDidPowerUp` from the given `wallet`, `pairwiseDid`, `amount` and `privateKey`.

    ```dart
    static Future<RequestDidPowerUp> fromWallet({
      required Wallet wallet,
      required String pairwiseDid,
      required List<StdCoin> amount,
      required CommercioRSAPrivateKey privateKey,
      http.Client? client,
    })
    ```

## Usage examples

```dart
final wallet = Wallet.derive(mnemonic, networkInfo);
final pairwaiseWallet = Wallet.derive(
  mnemonic,
  networkInfo,
  lastDerivationPathSegment: '1',
);
final amount = [
  StdCoin(
    denom: 'uccc',
    amount: '10',
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

try {
  // Create Did PowerUp request
  final requestDidPowerUp = await RequestDidPowerUpHelper.fromWallet(
    wallet: wallet,
    pairwiseDid: pairwaiseWallet.bech32Address,
    amount: amount,
    privateKey: rsaPrivateKey,
  );
} catch (error) {
  throw error;
}
```
