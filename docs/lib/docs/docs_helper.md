# Docs helper
Docs helper allows to easily perform all the operations related to the commercio.network `docs` module.

## Provided operations

1. Creates a new transaction that allows to share the document associated with the given `contentUri` and having the given
`metadata` and `checksum`.  
If `encryptedData` is specified, encrypts the proper data for the specified `recipients` and then 
sends the transaction to the blockchain
```dart
static Future<TransactionResult> shareDocument(
  String contentUri,
  CommercioDocMetadata metadata,
  CommercioDocChecksum checksum,
  List<String> recipientsDids,
  Wallet wallet, {
  Key aesKey = null,
  List<EncryptedData> encryptedData = const [],
}) async
```

2. Returns the list of all the `CommercioDoc` that the specified `address` has sent
```dart
static Future<List<CommercioDoc>> getSendDocuments(
  String address,
  Wallet wallet,
) async
```
3. Returns the list of all the `CommercioDoc` that the specified `address` has received
```dart
static Future<List<CommercioDoc>> getReceivedDocuments(
  String address,
  Wallet wallet,
) async
```
4. Creates a new transaction which tells the `recipient` that the document having the specified `documentId` and present
inside the transaction with hash `txHash` has been properly seen.  
The `proof` is an optional field that indicates proof of reading.
```dart
static Future<TransactionResult> sendDocumentReceipt(
  String recipient,
  String txHash,
  String documentId,
  Wallet wallet, {
  String proof = null,
}) 
```
5. Returns the list of all the `CommercioDocReceipt` that have been sent from the given `address`
```dart
Future<List<CommercioDocReceipt>> getSentReceipts(
  String address,
  Wallet wallet,
) async 
```
6. Returns the list of all the `CommercioDocRecepit` that have been received from the given `address`
```dart
Future<List<CommercioDocReceipt>> getReceivedReceipts(
  String address,
  Wallet wallet,
) async 
```
## Usage examples
TODO
