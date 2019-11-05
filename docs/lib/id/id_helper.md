# Id helper
Id helper allows to easily perform all the operations related to the commercio.network `id` module.

## Provided operations
1. Returns the [DidDocument](../glossary.md) associated with the given [did](../glossary.md), or null if no `DidDocument` was found
```dart
static Future<DidDocument> getDidDocument(String did, Wallet wallet) async
```
2. Performs a transaction setting the specified `DidDocument` as being associated with the address present inside the specified
`wallet`
```dart
static Future<TransactionResult> setDidDocument(
  DidDocument didDocument,
  Wallet wallet,
) 
```
3. Creates a new [Did deposit request](../glossary.md) for the given `recipient` and of the given `amount`.  
Signs everything that need to be signed (i.e. the signature JSON inside the payload) with the private key contained inside the
given `wallet`
```dart
static Future<TransactionResult> requestDidDeposit(
  String recipient, 
  List<StdCoin> amount, 
  Wallet wallet
) async
```
4. Create a new [Did power up request](../glossary.md) for the given `pairwiseDid` and of the given `amount`.  
Signs everything that needs to be signed (i.e. the signature JSON inside the payload) with the private key contained
inside the given `wallet`
```dart
Future<TransactionResult> requestDidPowerUp(
  String pairwiseDid, 
  List<StdCoin> amount, 
  Wallet wallet
) async
```
## Usage examples
TODO
