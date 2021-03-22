# MintHelper

`MintHelper` allows to easily perform all the operations related to the commercio.network `mint` module.

## Provided operations

1. `mintCccsList`, mints the CCCs having the given `mintCccs` list as being associated with the address present inside the specified `wallet`. Optionally `fee` and broadcasting `mode` parameters can be specified.

    ```dart
    static Future<TransactionResult> mintCccsList(
      List<MintCcc> mintCccs,
      Wallet wallet, {
      StdFee? fee,
      BroadcastingMode? mode,
    })
    ```

2. `burnCccsList`, burns the CCCs having the given `burnCccs` list as being associated with the address present inside the specified `wallet`. Optionally `fee` and broadcasting `mode` parameters can be specified.

    ```dart
    static Future<TransactionResult> burnCccsList(
      List<BurnCcc> burnCccs,
      Wallet wallet, {
      StdFee? fee,
      BroadcastingMode? mode,
    })
    ```

3. `getExchangeTradePositions`, returns the list of all the `ExchangeTradePosition` that the specified wallet has minted

    ```dart
    static Future<List<ExchangeTradePosition>> getExchangeTradePositions(
      Wallet wallet,
    )
    ```

## Usage examples

```dart
final wallet = Wallet.derive(mnemonic, networkInfo);

try {
  // --- Mint CCC
  final mintCcc = MintCccHelper.fromWallet(
    wallet: wallet,
    amount: [StdCoin(denom: 'uccc', amount: '10')],
    id: Uuid().v4(),
  );
  await MintHelper.mintCccsList([mintCcc], wallet);

  // --- Burn CCC
  final etps = await MintHelper.getExchangeTradePositions(wallet);
  List<BurnCcc> burnCccs = new List();
  etps.forEach((etp) {
    final burnCcc = BurnCccHelper.fromWallet(
      wallet: wallet,
      amount: StdCoin(
        denom: etp.credits.denom,
        amount: etp.credits.amount,
      ),
      id: etp.id,
    );
    burnCccs.add(burnCcc);
  });
  await MintHelper.burnCccsList(burnCccs, wallet);
} catch (error) {
  throw error;
}
```
