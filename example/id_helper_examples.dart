import 'package:commerciosdk/export.dart';

import 'commons.dart';

final userMnemonic = [
  'will',
  'hard',
  'topic',
  'spray',
  'beyond',
  'ostrich',
  'moral',
  'morning',
  'gas',
  'loyal',
  'couch',
  'horn',
  'boss',
  'across',
  'age',
  'post',
  'october',
  'blur',
  'piece',
  'wheel',
  'film',
  'notable',
  'word',
  'man'
];

final pairwiseMnemonic = [
  'push',
  'grace',
  'power',
  'desk',
  'arrive',
  'horror',
  'gallery',
  'physical',
  'kingdom',
  'ecology',
  'fat',
  'firm',
  'future',
  'service',
  'table',
  'little',
  'live',
  'reason',
  'maximum',
  'short',
  'motion',
  'planet',
  'stage',
  'second'
];

void main() async {
  final networkInfo = NetworkInfo(
    bech32Hrp: 'did:com:',
    lcdUrl: 'http://localhost:1317',
  );

  final userWallet = Wallet.derive(userMnemonic, networkInfo);

  // --- Set the Did Document
  final rsaVerificationKeyPair = await KeysHelper.generateRsaKeyPair();
  final rsaSignatureKeyPair =
      await KeysHelper.generateRsaKeyPair(type: 'RsaSignatureKey2018');

  await _createDidDocument(
    userWallet,
    [rsaVerificationKeyPair.publicKey, rsaSignatureKeyPair.publicKey],
    BroadcastingMode.SYNC,
  );

  final pairwiseWallet = Wallet.derive(pairwiseMnemonic, networkInfo);

  // --- Request the Did power up
  final depositAmount = const [StdCoin(denom: 'ucommercio', amount: '10')];
  await _postPowerUpRequest(
    userWallet,
    pairwiseWallet.bech32Address,
    depositAmount,
    rsaSignatureKeyPair.privateKey,
    BroadcastingMode.SYNC,
  );
}

/// Shows how to create a [DidDocument] and associate it to an existing
/// account Did.
///
/// Docs: https://docs.commercio.network/x/id/tx/associate-a-did-document.html
Future<void> _createDidDocument(
  Wallet wallet,
  List<PublicKey> keys,
  BroadcastingMode mode,
) async {
  final didDocument = DidDocumentHelper.fromWallet(wallet, keys);
  final response =
      await IdHelper.setDidDocument(didDocument, wallet, mode: mode);

  checkResponse(response);
}

/// Shows how to request a pairwise Did power up. This request will later be
/// read and handled by the centralized APIs that will send the funds
/// to such account.
///
/// Docs: https://docs.commercio.network/x/id/tx/request-did-power-up.html
Future<void> _postPowerUpRequest(
  Wallet wallet,
  String pairwiseDid,
  List<StdCoin> amount,
  RSAPrivateKey privateKey,
  BroadcastingMode mode,
) async {
  final response = await IdHelper.requestDidPowerUp(
    wallet,
    pairwiseDid,
    amount,
    privateKey,
    mode: mode,
  );

  checkResponse(response);
}
