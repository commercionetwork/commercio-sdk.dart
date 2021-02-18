import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'invite_user.g.dart';

/// Contains the data related to invite a new user to join the system.
@JsonSerializable(explicitToJson: true)
class InviteUser extends Equatable {
  @JsonKey(name: 'recipient')
  final String recipientDid;

  @JsonKey(name: 'sender')
  final String senderDid;

  const InviteUser({
    @required this.recipientDid,
    @required this.senderDid,
  })  : assert(recipientDid != null),
        assert(senderDid != null);

  @override
  List<Object> get props => [recipientDid, senderDid];

  factory InviteUser.fromJson(Map<String, dynamic> json) =>
      _$InviteUserFromJson(json);

  Map<String, dynamic> toJson() => _$InviteUserToJson(this);
}
