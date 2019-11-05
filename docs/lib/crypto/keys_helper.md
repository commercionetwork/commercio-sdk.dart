# Keys helper
Keys helper allows to easily generate new RSA or AES keys.

## Provided operations
Below you can find the keys helper's provided operations with some examples

1. Generates **RSA** key pair having the given bytes length.  
If no length is specified, the default is goin to be 2048
```dart
static Future<AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>>generateRsaKeyPair({int bytes = 2048,}) async
```
2. Generates **AES** key having the chosen length
```dart
static Future<Key> generateAesKey({int length = 356}) async 
```

## Usage examples
TODO
