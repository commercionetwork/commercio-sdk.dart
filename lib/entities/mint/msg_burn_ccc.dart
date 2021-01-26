import 'package:commerciosdk/entities/mint/burn_ccc.dart';
import 'package:commerciosdk/export.dart';
import 'package:meta/meta.dart';

class MsgBurnCcc extends StdMsg {
  final BurnCcc burnCcc;

  MsgBurnCcc({@required this.burnCcc})
      : assert(burnCcc != null),
        super(type: 'commercio/MsgBurnCCC', value: <String, String>{});

  @override
  Map<String, dynamic> get value => burnCcc.toJson();
}
