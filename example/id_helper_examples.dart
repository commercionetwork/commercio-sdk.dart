import 'package:commerciosdk/export.dart';

import 'commons.dart';

void main() async {
  final info = NetworkInfo(
    bech32Hrp: "did:com:",
    lcdUrl: "http://localhost:1317",
  );

  final userMnemonic = [
    "will",
    "hard",
    "topic",
    "spray",
    "beyond",
    "ostrich",
    "moral",
    "morning",
    "gas",
    "loyal",
    "couch",
    "horn",
    "boss",
    "across",
    "age",
    "post",
    "october",
    "blur",
    "piece",
    "wheel",
    "film",
    "notable",
    "word",
    "man"
  ];

  final userWallet = Wallet.derive(userMnemonic, info);

  // --- Set the Did Document
  final rsaKeyPair = await KeysHelper.generateRsaKeyPair();
  final ecKeyPair = await KeysHelper.generateEcKeyPair();
  // await _createDidDocument(userWallet, [rsaKeyPair.publicKey, ecKeyPair.publicKey]);

  // --- Request the Did deposit
  final depositAmount = [StdCoin(denom: "ucommercio", amount: "10")];
  _postDepositRequest(depositAmount, userWallet);
}

/// Shows how to create a Did Document and associate it to an existing
/// account Did.
/// Documentation: https://docs.commercio.network/x/id/tx/associate-a-did-document.html
Future<void> _createDidDocument(Wallet wallet, List<PublicKey> keys) async {
  final didDocument = DidDocumentHelper.fromWallet(wallet, keys);
  final response = await IdHelper.setDidDocument(didDocument, wallet);
  checkResponse(response);
}

/// Shows how to post a request for a deposit that will be later read from the
/// centralized APIs.
/// Documentation: https://docs.commercio.network/x/id/tx/request-did-deposit.html
Future<void> _postDepositRequest(List<StdCoin> amount, Wallet wallet) async {
  final response = await IdHelper.requestDidDeposit(
    wallet.bech32Address,
    amount,
    wallet,
  );
  checkResponse(response);
}
