# Changelog

## Version 2.2.0-pre.1 - 2021-02-18

* Updated `Id`, `Docs` and `CommercioMint` modules to match the new specification:
  * Updated the CommercioDoc, CommercioDocReceipt, MsgSendDocumentReceipt, entities to match the new specification;
  * In CommercioDocHelper.fromWallet() the parameter encryptedData now is a Set;
  * In CommercioDocReceiptHelper.fromWallet() the proof now is null by default;
  * In DocsHelper.shareDocument() the parameter encryptedData now is a Set;
  * Added http.Client client parameter in getSentDocuments(), getReceivedDocuments(), getSentReceipts() and getReceivedReceipts();
  * The parameter encryptedData now is a Set in the method encryptField();
  * Removed the duplication of EncryptedData with CommercioEncryptedData in encryptField();
  * Added MintCcc helper and entities;
  * Added BurnCcc helper and entities;
  * Added method to fetch all the Exchange Trade Positions by wallet;
  * Removed OpenCdp helper and entities;
  * Removed CloseCdp helper and entities.
* Added new `CommercioKyc` module including `KycHelper`, `BuyMembershipHelper`, `InviteUserHelper`and `RewardPoolDepositHelper` helpers.
* Removed outdated `Membership` module.
* Updated utilities:
  * Added optional parameter client in EncryptionHelper.getGovernmentRsaPubKey();
  * SignHelper.signSorted parameter data now is defined as Map<String, dynamic>;
  * Updated the Network helper, removing the static client with optional parameters, let queryChain() to use the query() method instead of duplicate code.
* Added an analysis_options.yaml file to enable more lints.
* Updated examples and documentation included.

## Version 2.1.3-pre.1 - 2020-11-05

* Update sacco dependency
* Update external packages dependency
* Update doc
* Add examples

## Version 2.1.2 - 2020-06-22

* Added the static shareDocumentsList() method to the DocsHelper class to send multiple shareDocument messages
* Added the static sendDocumentReceiptsList() method to the DocsHelper class to send multiple sendDocumentReceipt messages
* Added the static setDidDocumentsList() method to the IdHelper class to send multiple setDidDocument messages
* Added class RequestDidPowerUpHelper
* Added the static requestDidPowerUpsList() method to the RequestDidPowerUpHelper class to send multiple RequestDidPowerUp messages
* Added the static inviteUsersList() method to the MembershipHelper class to send multiple InviteUser messages
* Added the static buyMembershipsList() method to the MembershipHelper class to send multiple BuyMembership messages 
* Added automatic fees calculation for multiple messages
* Added the ability to configure the transactions sync mode

## Version 2.1.0 - 2020-05-18

* Aligned DDO creation
* Aligned powerUP creation
* Aligned shareDoc creation
* Deleted Did Deposit
* Fixed Cdp creation
* Add do_sign shareDoc

## Version 0.1.3 - 2019-12-16

* updated `context` link in `DidDocumentHelper` with https://www.w3.org/ns/did/v1.

## Version 0.1.2 - 2019-12-09

* updated sdk with hints provided by pub.dev

## Version 0.1.1 - 2019-12-09

* updated the code with the hints provided by pub.dev

## Version 0.1.0 - 2019-12-04

* updated the code with the hints provided by pub.dev
* updated all dependencies
* fixed errors due to dependencies upgrade
* fixed docs

## Version 0.0.2 - 2019-12-03

* added to project generated g files

## Version 0.0.1 - 2019-10-23

* Initial release
