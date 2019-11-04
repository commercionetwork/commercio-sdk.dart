# Mint helper
Mint helper allows to easily perform all the operations related to the commercio.network `mint` module.

# Provided operations

1. Opens a new [CDP](../glossary.md) depositing the given `commercioTokenAmount`
```dart
static Future<TransactionResult> openCdp(
  int commercioTokenAmount,
  Wallet wallet,
) 
```
2. Closes the CDP having the given `timestamp`.
```dart
static Future<TransactionResult> closeCdp(
  String timestamp,
  Wallet wallet,
) 
```
## Usage examples
TODO
