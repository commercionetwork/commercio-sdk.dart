# Commercio.network SDK (Dart) Documentation

Inside the following page you will learn how to perform all the Commercio.network
transactions  by using the Commercio.network SDK.

:::tip Disclaimer
This documentation is valid for the `v2.1.0` sdk version  
:::

## Installation

In order to use the SDK inside your project you can easilly follow the guidelines
provided [here](https://pub.dev/packages/commerciosdk#-installing-tab-).

## How to start using SDK

### Wallet

In order to perform transactions on the Commercio.network blockchain you need to create a **wallet**.

:::tip Wallet  
To know what a wallet is and how to create it, you can read the
[wallet creation guide](wallet/create-wallet.md)  
:::

### Helpers

#### Blockchain's helpers

After creating the wallet, you can use it inside the blockchain's **Helpers**,
specific classes used to allow a simple way to send Commercio.network blockchain's messages and perform transactions.  
Here's the list:

* [`IdHelper`](lib/id/id_helper.md)
* [`DidDocumentHelper`](lib/id/did_document_helper.md)
* [`RequestDidPowerUptHelper`](lib/id/request_did_power_up_helper.md)
* [`DocsHelper`](lib/docs/docs_helper.md)
* [`CommercioDocHelper`](lib/docs/commercio_doc_helper.md)
* [`CommercioDocReceiptHelper`](lib/docs/commercio_doc_receipt_helper.md)
* [`MembershipHelper`](lib/membership/membership_helper.md)
* [`MintHelper`](lib/mint/mint_helper.md)
* [`TxHelper`](lib/tx/tx_helper.md)
* [`SignHelper`](lib/crypto/sign_helper.md)

#### Utility helpers

Beside the above helpers, there is a few more that allows you to perform specific operations such as  string or bytes encryption/decryption,
RSA/AES keys generation, JSON signature.  
Here's the list:

* [`EncryptionHelper`](lib/crypto/encryption_helper.md)  
* [`KeysHelper`](lib/crypto/keys_helper.md)
