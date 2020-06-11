// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InviteUser _$InviteUserFromJson(Map<String, dynamic> json) {
  return InviteUser(
    recipientDid: json['recipient'] as String,
    senderDid: json['sender'] as String,
  );
}

Map<String, dynamic> _$InviteUserToJson(InviteUser instance) =>
    <String, dynamic>{
      'recipient': instance.recipientDid,
      'sender': instance.senderDid,
    };
