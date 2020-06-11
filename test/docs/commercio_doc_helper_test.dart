import 'package:commerciosdk/export.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Functions of "CommercioDocHelper" class;', () {
    final networkInfo = NetworkInfo(bech32Hrp: "did:com:", lcdUrl: "");
    final mnemonicString =
        "dash ordinary anxiety zone slot rail flavor tortoise guilt divert pet sound ostrich increase resist short ship lift town ice split payment round apology";
    final mnemonic = mnemonicString.split(" ");
    final wallet = Wallet.derive(mnemonic, networkInfo);

    test('"fromWallet()" returns a well-formed "CommercioDoc" object.',
        () async {
      final senderDid = wallet.bech32Address;
      final recipientDids = ['recipient1', 'recipient2'];
      final uuid = Uuid().v4();
      final metadata = CommercioDocMetadata(
        contentUri: 'https://example.com/document/metadata',
        schema: CommercioDocMetadataSchema(
          uri: 'https://example.com/custom/metadata/schema',
          version: '7.0.0',
        ),
      );

      final expectedCommercioDoc = CommercioDoc(
        senderDid: senderDid,
        recipientDids: recipientDids,
        uuid: uuid,
        metadata: metadata,
      );

      final commercioDoc = await CommercioDocHelper.fromWallet(
        wallet: wallet,
        recipients: recipientDids,
        id: uuid,
        metadata: metadata,
      );

      expect(commercioDoc.toJson(), expectedCommercioDoc.toJson());
    });
  });
}
