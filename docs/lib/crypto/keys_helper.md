# Keys helper

Keys helper allows to easily generate nonce and new RSA, AES and EC keys.

## Provided operations

Below you can find the keys helper's provided operations with some examples

1. Generates **RSA** key pair having the given bytes length and type. If no length is specified, the default is goin to be 2048

    ```dart
    static Future<KeyPair<RSAPubKey, RSASecretKey>> generateRsaKeyPair({int bytes = 2048,}) async
    ```

2. Generates **AES** key having the chosen length

    ```dart
    static Future<Key> generateAesKey({int length = 356}) async
    ```

3. Generate a random nonce

    ```dart
    static Uint8List generateRandomNonce(int length, {bit = 256})
    ```

4. Generate a random nonce Utf8

    ```dart
    static Uint8List generateRandomNonceUtf8(int length)
    ```

5. Generates a new random **EC** key pair

    ```dart
    static Future<KeyPair<ECPublicKey, ECPrivateKey>> generateEcKeyPair({String type}) async
    ```
