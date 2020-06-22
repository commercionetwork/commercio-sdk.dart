# Commercio SDK - Dart

[![Release](https://img.shields.io/pub/v/commerciosdk)](https://pub.dev/packages/commerciosdk)
[![Compatible](https://img.shields.io/badge/compatible-flutter-blue)](https://flutter.dev)

This repository contains the code of the official [Commercio.network](https://commercio.network) Dart SDK,
entirely based on [Sacco.dart](https://github.com/commercionetwork/sacco.dart). 

The main features are:

* Entirely made in Dart
* Completely stateless

Thanks to these characteristics, you can use this SDK inside any pure Dart project or even any Flutter application.

You can find the official **documentation** [here](https://dart.sdk.docs.commercio.network/).

## Helper methods

Inside the SDK you will find the following helper methods that will help you with almost any operation
that you might want to perform on the Commercio.network blockchain.

Please note that you can find usage examples of the following methods inside the
[sdk documentation](https://dart.sdk.docs.commercio.network).
We highly suggest you checking it out to have a complete reference of the SDK.  

### Crypto

* Create HD wallet  
* Generate AES key
* Generate RSA key

### CommercioDOCS

* Share document
* Send receipt
* List documents
* List receipts

### CommercioID

* Create Did Document
* Request power up
* Create connection invitation
* Verify connection invitation

### CommercioMINT

* Open CDP
* Close CDP

### CommercioMEMBERSHIP

* Invite user
* Buy membership
