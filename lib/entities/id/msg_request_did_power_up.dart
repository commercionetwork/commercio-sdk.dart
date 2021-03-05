import 'package:commerciosdk/entities/id/request_did_power_up.dart';
import 'package:sacco/sacco.dart';

/// Represents the transaction message that should be used when asking
/// for a private Did power up.
class MsgRequestDidPowerUp extends StdMsg {
  final RequestDidPowerUp requestDidPowerUp;

  MsgRequestDidPowerUp({
    required this.requestDidPowerUp,
  }) : super(type: 'commercio/MsgRequestDidPowerUp', value: <String, String>{});

  @override
  Map<String, dynamic> get value => requestDidPowerUp.toJson();
}
