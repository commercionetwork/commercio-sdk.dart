// import 'package:commerciosdk/export.dart';
// import 'package:commerciosdk/mint/export.dart';
// import 'package:test/test.dart';

// void main() {
//   group('Functions of "OpenCdpHelper" class;', () {
//     final networkInfo = NetworkInfo(bech32Hrp: "did:com:", lcdUrl: "");
//     final mnemonicString =
//         "dash ordinary anxiety zone slot rail flavor tortoise guilt divert pet sound ostrich increase resist short ship lift town ice split payment round apology";
//     final mnemonic = mnemonicString.split(" ");
//     final wallet = Wallet.derive(mnemonic, networkInfo);
//     final depositAmount = [StdCoin(denom: 'commercio', amount: '10')];

//     test('"fromWallet()" returns a well-formed "OpenCdp" object.', () {
//       final expectedOpenCdp = OpenCdp(
//         depositAmount: depositAmount,
//         signerDid: wallet.bech32Address,
//       );

//       final openCdp = OpenCdpHelper.fromWallet(wallet, depositAmount);

//       expect(openCdp.toJson(), expectedOpenCdp.toJson());
//     });
//   });
// }
