# Glossary
Here are collected all that common terms that you should know while you are working with Commercio.network

## Did 
Directly from [Did Specifications](https://w3c.github.io/did-core/):
> A DID is a simple text string that consists of three parts: 
> 1) the URL scheme identifier (did); 
> 2) the identifier for the DID method;
> 3) the DID method-specific identifier.

:::tip Example of Commercio.network Did
did:com:14zk9u8894eg7fhgw0dsesnqzmlrx85ga9rvnjc
:::

This Did in simple words it's nothing but a link that resolves to a specific Did Document.

### In SDK
Inside the SDK the did is a simple `String` like the one above.

## Did Document 
Directly from [Did Specifications](https://w3c.github.io/did-core/):
>A Did Document contains information associated with the Did such as ways to 
 cryptographically authenticate the entity in control of the Did, 
 as well as services that can be used to interact with the entity.

:::tip Did Document Example (specific for Commercio.network)
```json
{
  "@context": "https://www.w3.org/2019/did/v1",
  "id": "did:com:14zk9u8894eg7fhgw0dsesnqzmlrx85ga9rvnjc",
  "publicKey": [
    {
      "id": "did:com:14zk9u8894eg7fhgw0dsesnqzmlrx85ga9rvnjc#keys-1",
      "type": "RsaVerificationKey2018",
      "controller": "did:com:14zk9u8894eg7fhgw0dsesnqzmlrx85ga9rvnjc ",
      "publicKeyHex": "30820122300d06092a864886f70d01010105000382010f003082010a0282010100"
    },
    {
      "id": "did:com:14zk9u8894eg7fhgw0dsesnqzmlrx85ga9rvnjc#keys-2",
      "type": "Secp256k1VerificationKey2018",
      "controller": "did:com:14zk9u8894eg7fhgw0dsesnqzmlrx85ga9rvnjc ",
      "publicKeyHex": "02b97c30de767f084ce3080168ee293053ba33b235d7116a3263d29f1450936b71"
    }
  ],
  "authentication": "did:com:14zk9u8894eg7fhgw0dsesnqzmlrx85ga9rvnjc#keys-1",
  "service": [
    {
      "id": "did:com:14zk9u8894eg7fhgw0dsesnqzmlrx85ga9rvnjc#openid",
      "type": "OpenIdConnectVersion1.0Service",
      "serviceEndpoint": "https://openid.commercio.com/"
    },
    {
      "id": "did:com:14zk9u8894eg7fhgw0dsesnqzmlrx85ga9rvnjc#messageing",
      "type": "MessaginService",
      "serviceEndpoint": "http://chat.commercio.com/did:com:14zk9u8894eg7fhgw0dsesnqzmlrx85ga9rvnjc"
    }
  ],
  "proof": {
    "type": "LinkedDataSignature2015",
    "created": "2016-02-08T16:02:20Z",
    "creator": "did:com:14zk9u8894eg7fhgw0dsesnqzmlrx85ga9rvnjc#keys-1",
    "signatureValue": "QNB13Y7Q9...1tzjn4w=="
  }
}
```
:::
### In SDK
Inside the SDK it is an object of type `DidDocument`:  
```dart
class DidDocument extends Equatable {
  @JsonKey(name: "@context")
  final String context;

  @JsonKey(name: "id")
  final String id;

  @JsonKey(name: "publicKey")
  final List<DidDocumentPublicKey> publicKeys;

  @JsonKey(name: "authentication")
  final List<String> authentication;

  @JsonKey(name: "proof")
  final DidDocumentProof proof;

  @JsonKey(name: "service")
  final List<DidDocumentService> services;

  DidDocument({
    @required this.context,
    @required this.id,
    @required this.publicKeys,
    @required this.authentication,
    @required this.proof,
    @required this.services,
  });
}
```

