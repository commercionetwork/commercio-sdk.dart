import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'buy_membership.g.dart';

/// Contains the data related to a membership buying.
@JsonSerializable(explicitToJson: true)
class BuyMembership extends Equatable {
  @JsonKey(name: 'membership_type')
  final String membershipType;

  @JsonKey(name: 'buyer')
  final String buyerDid;

  const BuyMembership({
    @required this.membershipType,
    @required this.buyerDid,
  })  : assert(membershipType != null),
        assert(buyerDid != null);

  @override
  List<Object> get props => [membershipType, buyerDid];

  factory BuyMembership.fromJson(Map<String, dynamic> json) =>
      _$BuyMembershipFromJson(json);

  Map<String, dynamic> toJson() => _$BuyMembershipToJson(this);
}
