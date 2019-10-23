/// Returns true iff the given [membershipType] is a valid membership type.
bool validateMembership(String membershipType) {
  var type = membershipType.toLowerCase();
  return type == "bronze" ||
      type == "silver" ||
      type == "gold" ||
      type == "black";
}
