# Encryption Helper
Encryption Helper allows to perform common encryption operations such as RSA/AES encryption and decryption.

## Allowed Operations
Below you can find the encryption helper's provided operations with some examples
### AES
1. Encryption of the given **string** data with AES using the specified key  
```dart
 static Uint8List encryptStringWithAes(String data, Key key)
```
2. Encryption of the given **bytes** data with AES using the specified key
```dart
static Uint8List encryptBytesWithAes(Uint8List data, Key key)
``` 
3. Decryption of the given **bytes** data with AES using the specified key
```dart
static Uint8List decryptWithAes(Uint8List data, Key key)
```

### RSA
4. Encryption of the given **string** data with RSA using the specified key
```dart
static Uint8List encryptStringWithRsa(String data, RSAPublicKey key) 
```
5. Encryption of the given **bytes** data with RSA using the specified key
```dart
static Uint8List encryptBytesWithRsa(Uint8List data, RSAPublicKey key)
```
6. Decryption of the given **bytes** data using the specified private key
```dart
static Uint8List decryptBytesWithRsa(Uint8List data, RSAPrivateKey key)
```

### Examples of usage
