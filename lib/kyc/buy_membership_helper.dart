import 'package:commerciosdk/export.dart';

/// Allows to easily create a BuyMembership and perform common related operations
class BuyMembershipHelper {
  /// Creates a BuyMembership from the given [wallet],
  /// [membershipType] and [tsp] address.
  static BuyMembership fromWallet({
    required Wallet wallet,
    required MembershipType membershipType,
    required String tsp,
  }) {
    return BuyMembership(
      buyerDid: wallet.bech32Address,
      membershipType: membershipType.value,
      tsp: tsp,
    );
  }
}
