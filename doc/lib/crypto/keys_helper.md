# Keys helper

Keys helper allows to easily generate nonce and new RSA, AES and EC keys.

## Provided operations

Below you can find the keys helper's provided operations with some examples

1. Generates **RSA** key pair having the given bytes length and type. If no length is specified, the default is goin to be 2048

    ```dart
    static Future<CommercioKeyPair<CommercioRSAPublicKey, CommercioRSAPrivateKey>> generateRsaKeyPair({
        required CommercioRSAKeyType keyType,
        int bytes = 2048,
    })
    ```

2. Generates **AES** key having the chosen length

    ```dart
    static Future<Uint8List> generateAesKey({int length = 256})
    ```

3. Generate a random nonce

    ```dart
    static Uint8List generateRandomNonce(int length, {int bit = 256})
    ```

4. Generates a new random **EC** key pair

    ```dart
    static Future<CommercioKeyPair<CommercioECPublicKey, CommercioECPrivateKey>> generateEcKeyPair({String? type})
    ```
