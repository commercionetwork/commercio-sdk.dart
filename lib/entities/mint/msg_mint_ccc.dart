import 'package:commerciosdk/entities/mint/mint_ccc.dart';
import 'package:commerciosdk/export.dart';
import 'package:meta/meta.dart';

class MsgMintCcc extends StdMsg {
  final MintCcc mintCcc;

  MsgMintCcc({@required this.mintCcc})
      : assert(mintCcc != null),
        super(type: 'commercio/MsgMintCCC', value: <String, String>{});

  @override
  Map<String, dynamic> get value => mintCcc.toJson();
}
