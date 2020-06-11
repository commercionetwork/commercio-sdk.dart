enum MembershipType { BRONZE, SILVER, GOLD, BLACK }

extension MembershipTypeExt on MembershipType {
  String get value {
    switch (this) {
      case MembershipType.BRONZE:
        return 'bronze';
      case MembershipType.SILVER:
        return 'silver';
      case MembershipType.GOLD:
        return 'gold';
      case MembershipType.BLACK:
        return 'black';
      default:
        return null;
    }
  }
}
