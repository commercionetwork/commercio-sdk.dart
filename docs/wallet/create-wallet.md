##What wallet is?
From wikipedia:
> A cryptocurrency wallet is a device, physical medium, program or a service which
>stores the public and private keys and can be used to track ownership, receive or spend cryptocurrencies.

Specifying, in our case the wallet will be used to sign 
(with the keys contained in it) the transactions that will 
then be entered into the Commercio.network blockchain.
  
###Create a Wallet
Before doing anything with the tools offered by Commercio.network SDK you **must** create a wallet as follow:
```dart
final derivationPath = "m/44'/118'/0'/0/0";
final networkInfo = NetworkInfo(id: "", bech32Hrp: "cosmos", lcdUrl: "");

final mnemonicString = "final random flame cinnamon grunt hazard easily mutual resist pond solution define knife female tongue crime atom jaguar alert library best forum lesson rigid";
final mnemonic = mnemonicString.split(" ");
final wallet = Wallet.derive(mnemonic, derivationPath, networkInfo);
```
