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

void main() async {
  final networkInfo = NetworkInfo(
    bech32Hrp: 'did:com:',
    lcdUrl: 'http://localhost:1317',
  );

  final userWallet = Wallet.derive(userMnemonic, networkInfo);

  // --- Open CDP
  await _openCdp(amount: 100000, wallet: userWallet);

  // --- Close CDP
  await _closeCdp(timestamp: 757, wallet: userWallet);
}

/// Shows how to open a new Collateralized Debt Position in order to get half
/// the specified [amount] of Commercio Cash Credits millionth parts (`uccc`).
/// Please note that `uccc` are millionth of Commercio Cash Credits and thus to
/// send one document you wil need 10.000 `uccc`.
///
/// Docs: https://docs.commercio.network/x/commerciomint/#open-a-cdp
Future<void> _openCdp({int amount, Wallet wallet}) async {
  final response = await MintHelper.openCdp(amount, wallet);

  checkResponse(response);
}

/// Shows how to close a Collateralized Debt Position in order to allow the
/// user controlling the given [wallet] to get back the amount of pico
/// Commercio Tokens (`ucommercio`) giving back the lent pico Commercio
/// Cash Credits (`uccc`).
/// The [timestamp] is the block height at which the CDP is was inserted into
///  the chain.
///
/// Docs: https://docs.commercio.network/x/commerciomint/#close-a-cdp
Future<void> _closeCdp({int timestamp, Wallet wallet}) async {
  final response = await MintHelper.closeCdp(timestamp, wallet);

  checkResponse(response);
}
