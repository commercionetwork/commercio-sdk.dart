# DidDocumentHelper

`DidDocumentHelper` allows to easily create a `DidDocument` object.

## Provided Operations

1. `fromWallet`, creates a `DidDocument` from the given `wallet` and the `pubKeys`. Optionally the list `service` can be specified.

    ```dart
    static Future<DidDocument> fromWallet({
      required Wallet wallet,
      required List<CommercioPublicKey> pubKeys,
      List<DidDocumentService>? service,
    })
    ```  

## Usage examples

```dart
final wallet = Wallet.derive(mnemonic, networkInfo);

// Generate keys
final rsaVerificationKeyPair = await KeysHelper.generateRsaKeyPair();
final rsaVerificationPubKey = rsaVerificationKeyPair.publicKey;
final rsaSignatureKeyPair =
  await KeysHelper.generateRsaKeyPair(type: 'RsaSignatureKey2018');
final rsaSignaturePubKey = rsaSignatureKeyPair.publicKey;
final pubKeys = [rsaVerificationPubKey, rsaSignaturePubKey];

// Generate service
final serviceId = Uuid().v4();
final service = [
  DidDocumentService(
    id: serviceId,
    type: 'service-type',
    endpoint: 'https://endpoint.com/services/${serviceId}',
  )
];

// Create the Did Document
final didDocument = DidDocumentHelper.fromWallet(
  wallet: wallet,
  pubKeys: pubKeys,
  service: service,
);
```
