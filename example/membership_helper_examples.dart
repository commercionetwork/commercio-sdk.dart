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

  final newUserMnemonic = [
    "often",
    "emerge",
    "table",
    "boat",
    "add",
    "crowd",
    "obtain",
    "creek",
    "skill",
    "flat",
    "master",
    "gift",
    "provide",
    "peasant",
    "famous",
    "blur",
    "flight",
    "lady",
    "elephant",
    "twenty",
    "join",
    "depth",
    "laptop",
    "arrest"
  ];
  final newUserWallet = Wallet.derive(newUserMnemonic, info);

  // --- Invite user
  // await _inviteUser(user: newUserWallet.bech32Address, wallet: userWallet);

  // --- Buy a membership
  // await _buyMembership(type: MembershipType.GOLD, wallet: newUserWallet);
}

/// Shows how to perform a transaction to invite a user.
/// Note that in order to invite a user, you must already have a membership.
Future<void> _inviteUser({String user, Wallet wallet}) async {
  final response = await MembershipHelper.inviteUser(user, wallet);
  checkResponse(response);
}

/// Shows how to perform the transaction that allows the owner of the
/// given [wallet] to buy a membership of the specified [membershipType].
Future<void> _buyMembership({MembershipType type, Wallet wallet}) async {
  final response = await MembershipHelper.buyMembership(type, wallet);
  checkResponse(response);
}
