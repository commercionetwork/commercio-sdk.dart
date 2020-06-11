import 'package:commerciosdk/entities/mint/open_cdp.dart';
import 'package:meta/meta.dart';
import 'package:sacco/sacco.dart';

/// Represents the transaction message that must be used when wanting to open a
/// Collateralized Debt position that allows to transform the user's
/// Commercio Token into Commercio Cash Credits.
class MsgOpenCdp extends StdMsg {
  final OpenCdp openCdp;

  MsgOpenCdp({
    @required this.openCdp,
  })  : assert(openCdp != null),
        super(type: "commercio/MsgOpenCdp", value: Map());

  @override
  Map<String, dynamic> get value => openCdp.toJson();
}
