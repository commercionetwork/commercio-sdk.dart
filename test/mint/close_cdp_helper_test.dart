// import 'package:commerciosdk/export.dart';
// import 'package:commerciosdk/mint/export.dart';
// import 'package:test/test.dart';

// void main() {
//   group('Functions of "CloseCdpHelper" class;', () {
//     final networkInfo = NetworkInfo(bech32Hrp: "did:com:", lcdUrl: "");
//     final mnemonicString =
//         "dash ordinary anxiety zone slot rail flavor tortoise guilt divert pet sound ostrich increase resist short ship lift town ice split payment round apology";
//     final mnemonic = mnemonicString.split(" ");
//     final wallet = Wallet.derive(mnemonic, networkInfo);
//     final timeStamp = 1;

//     test('"fromWallet()" returns a well-formed "CloseCdp" object.', () {
//       final expectedCloseCdp = CloseCdp(
//           signerDid: wallet.bech32Address, timeStamp: timeStamp.toString());

//       final closeCdp = CloseCdpHelper.fromWallet(wallet, timeStamp);

//       expect(closeCdp.toJson(), expectedCloseCdp.toJson());
//     });
//   });
// }
