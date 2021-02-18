// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buy_membership.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuyMembership _$BuyMembershipFromJson(Map<String, dynamic> json) {
  return BuyMembership(
    membershipType: json['membership_type'] as String,
    buyerDid: json['buyer'] as String,
    tsp: json['tsp'] as String,
  );
}

Map<String, dynamic> _$BuyMembershipToJson(BuyMembership instance) =>
    <String, dynamic>{
      'membership_type': instance.membershipType,
      'buyer': instance.buyerDid,
      'tsp': instance.tsp,
    };
