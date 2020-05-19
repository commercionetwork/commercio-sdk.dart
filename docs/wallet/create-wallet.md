# What a wallet is?

From wikipedia:
> A cryptocurrency wallet is a device, physical medium, program or a service which
>stores the public and private keys and can be used to track ownership, receive or spend cryptocurrencies.

In our case the wallet will be used to sign
(with the keys contained in it) the transactions that will
then be sended to the Commercio.network blockchain.
  
## Create a Wallet

Before doing anything with the tools offered by Commercio.network SDK you **must** create a wallet as follow:

```dart
final networkInfo = NetworkInfo(bech32Hrp: 'did:com:', lcdUrl: 'http://localhost:1317');

final mnemonicString = 'final random flame cinnamon grunt hazard easily mutual resist pond solution define knife female tongue crime atom jaguar alert library best forum lesson rigid';
final mnemonic = mnemonicString.split(' ');
final wallet = Wallet.derive(mnemonic, networkInfo);
```
