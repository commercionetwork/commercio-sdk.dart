import 'package:commerciosdk/export.dart';

/// Allows to easily create a BuyMembership and perform common related operations
class BuyMembershipHelper {
  /// Creates a BuyMembership from the given [wallet] and [membershipType].
  static BuyMembership fromWallet(
    Wallet wallet,
    MembershipType membershipType,
  ) {
    return BuyMembership(
      buyerDid: wallet.bech32Address,
      membershipType: membershipType.value,
    );
  }
}
