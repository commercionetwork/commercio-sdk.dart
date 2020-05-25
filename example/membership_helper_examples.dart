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

final newUserMnemonic = [
  'often',
  'emerge',
  'table',
  'boat',
  'add',
  'crowd',
  'obtain',
  'creek',
  'skill',
  'flat',
  'master',
  'gift',
  'provide',
  'peasant',
  'famous',
  'blur',
  'flight',
  'lady',
  'elephant',
  'twenty',
  'join',
  'depth',
  'laptop',
  'arrest'
];

void main() async {
  final networkInfo = NetworkInfo(
    bech32Hrp: 'did:com:',
    lcdUrl: 'http://localhost:1317',
  );

  final userWallet = Wallet.derive(userMnemonic, networkInfo);
  final newUserWallet = Wallet.derive(newUserMnemonic, networkInfo);

  // --- Invite user
  await _inviteUser(
    user: newUserWallet.bech32Address,
    wallet: userWallet,
    mode: BroadcastingMode.SYNC,
  );

  // --- Buy a membership
  await _buyMembership(
    type: MembershipType.GOLD,
    wallet: newUserWallet,
    mode: BroadcastingMode.SYNC,
  );
}

/// Shows how to perform a transaction to invite a user.
/// Note that in order to invite a user, you must already have a membership.
///
/// Docs: https://docs.commercio.network/x/memberships/#inviting-a-user
Future<void> _inviteUser({
  String user,
  Wallet wallet,
  BroadcastingMode mode,
}) async {
  final response = await MembershipHelper.inviteUser(
    user,
    wallet,
    mode: mode,
  );

  checkResponse(response);
}

/// Shows how to perform the transaction that allows the owner of the
/// given [wallet] to buy a membership of the specified [membershipType].
/// Make sure that the [wallet] possess a sufficient amount of `uccc`
/// (Commercio Cash Credits).
///
/// To obtain CCCs see the [CommercioMint] helper and documentation:
/// - `MintHelper`
/// - https://docs.commercio.network/x/commerciomint/
///
/// Docs: https://docs.commercio.network/x/memberships/#buying-a-membership-2
Future<void> _buyMembership({
  MembershipType type,
  Wallet wallet,
  BroadcastingMode mode,
}) async {
  final response = await MembershipHelper.buyMembership(
    type,
    wallet,
    mode: mode,
  );

  checkResponse(response);
}
