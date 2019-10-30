#Commercio.network SDK(Dart) Documentation 
Inside the following page you will learn how to perform all the Commercio.network
transactions  by using the Commercio.network SDK.  
:::tip  
This documentation is valid for the **version** sdk version  
::: 
##Installation
In order to use the SDK inside your project you can easilly follow the guidelines
provided [here](https://pub.dev/packages/sacco#-installing-tab-).

##How to start using SDK
###Wallet
In order to perform transactions on the Commercio.network blockchain you need to create a **wallet**.  
:::tip Wallet  
To know what a wallet is and how to create it, you can read the 
[wallet *installation* guide](wallet/create-wallet.md)  
:::

###Helpers
After creating the wallet, you can use it inside **Helpers**,
specific classes used to allow a simple way to send Commercio.network blockchain's messages.  
Here's the list of helpers:  
* [`EncryptionHelper`](lib/crypto/encryption_helper.md)  
* [`DocsHelper`](lib/docs/docs_helper.md)
* [`IdHelper`](lib/id/id_helper.md)
* [`MembershipHelper`](lib/membership/membership_helper.md)
* [`MintHelper`](lib/mint/mint_helper.md)
* [`TxHelper`](lib/tx/tx_helper.md)  

Each one of these allows the creation of a set of messages with which you can interact in different ways with the blockchain.

