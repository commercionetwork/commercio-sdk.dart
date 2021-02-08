import 'package:commerciosdk/export.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Functions of "CommercioDocHelper" class;', () {
    final networkInfo = NetworkInfo(bech32Hrp: 'did:com:', lcdUrl: '');
    const mnemonicString =
        'dash ordinary anxiety zone slot rail flavor tortoise guilt divert pet sound ostrich increase resist short ship lift town ice split payment round apology';
    final mnemonic = mnemonicString.split(' ');
    final wallet = Wallet.derive(mnemonic, networkInfo);
    final senderDid = wallet.bech32Address;
    final recipientDids = ['did:com:1acdefg', 'did:com:1acdefg'];
    final uuid = Uuid().v4();
    final metadata = CommercioDocMetadata(
      contentUri: 'https://example.com/document/metadata',
      schema: CommercioDocMetadataSchema(
        uri: 'https://example.com/custom/metadata/schema',
        version: '7.0.0',
      ),
    );

    test('"fromWallet()" returns a well-formed "CommercioDoc" object.',
        () async {
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

      final commercioDocWithEncryptedData = await CommercioDocHelper.fromWallet(
        wallet: wallet,
        recipients: recipientDids,
        id: uuid,
        metadata: metadata,
        contentUri: 'contentUri',
        encryptedData: {CommercioEncryptedData.CONTENT_URI},
      );

      expect(
        commercioDocWithEncryptedData.contentUri !=
            expectedCommercioDoc.contentUri,
        isTrue,
      );
    });

    test(
        'fromWallet() should throw an ArgumentError if passing CONTENT_URI with null contentUri param',
        () async {
      expect(
        () => CommercioDocHelper.fromWallet(
          wallet: wallet,
          recipients: recipientDids,
          id: uuid,
          metadata: metadata,
          encryptedData: {CommercioEncryptedData.CONTENT_URI},
        ),
        throwsArgumentError,
      );
    });

    test(
        'fromWallet() should throw an ArgumentError if passing METADATA_SCHEMA_URI with null metadata.schema param',
        () async {
      expect(
        () => CommercioDocHelper.fromWallet(
          wallet: wallet,
          recipients: recipientDids,
          id: uuid,
          metadata: CommercioDocMetadata(
            contentUri: 'contentUri',
            schema: null,
            schemaType: 'schemaType',
          ),
          encryptedData: {CommercioEncryptedData.METADATA_SCHEMA_URI},
        ),
        throwsArgumentError,
      );
    });
  });
}
