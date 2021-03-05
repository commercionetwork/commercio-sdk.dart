import 'dart:io';

import 'package:commerciosdk/export.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Functions of "CommercioDocHelper" class;', () {
    const networkInfo = NetworkInfo(bech32Hrp: 'did:com:', lcdUrl: '');
    const mnemonicString =
        'dash ordinary anxiety zone slot rail flavor tortoise guilt divert pet sound ostrich increase resist short ship lift town ice split payment round apology';
    final mnemonic = mnemonicString.split(' ');
    final wallet = Wallet.derive(mnemonic, networkInfo);
    final senderDid = wallet.bech32Address;
    final recipientDids = ['did:com:1acdefg', 'did:com:1acdefg'];
    const recipientWithDDO = 'did:com:1fswhnd44fv2qk7ls4gflxh7spu7xpqdue54s3m';
    final uuid = Uuid().v4();
    final metadata = CommercioDocMetadata(
      contentUri: 'https://example.com/document/metadata',
      schema: CommercioDocMetadataSchema(
        uri: 'https://example.com/custom/metadata/schema',
        version: '7.0.0',
      ),
    );
    final getWalletIdentityResponse =
        File('test_resources/get_wallet_identity_response.json')
            .readAsStringSync();

    test('"fromWallet()" returns a well-formed "CommercioDoc" object.',
        () async {
      final mockClient =
          MockClient((req) async => Response(getWalletIdentityResponse, 200));

      final expectedCommercioDoc = CommercioDoc(
        senderDid: senderDid,
        recipientDids: const [recipientWithDDO],
        uuid: uuid,
        metadata: metadata,
      );

      final commercioDoc = await CommercioDocHelper.fromWallet(
        wallet: wallet,
        recipients: const [recipientWithDDO],
        id: uuid,
        metadata: metadata,
      );

      expect(commercioDoc.toJson(), expectedCommercioDoc.toJson());

      final commercioDocWithEncryptedData = await CommercioDocHelper.fromWallet(
        wallet: wallet,
        recipients: const [recipientWithDDO],
        id: uuid,
        metadata: metadata,
        contentUri: 'contentUri',
        encryptedData: {CommercioEncryptedData.CONTENT_URI},
        client: mockClient,
      );

      expect(
        commercioDocWithEncryptedData.contentUri !=
            expectedCommercioDoc.contentUri,
        isTrue,
      );
    });

    test(
        'fromWallet() should throw a WalletIdentityNotFoundException if any of the recipients does not have a DDO',
        () {
      final mockClientEveryoneNotFound =
          MockClient((req) async => Response('', 404));

      expect(
        () => CommercioDocHelper.fromWallet(
          wallet: wallet,
          recipients: recipientDids,
          id: uuid,
          metadata: metadata,
          contentUri: 'contentUri',
          encryptedData: {CommercioEncryptedData.CONTENT_URI},
          client: mockClientEveryoneNotFound,
        ),
        throwsA(isA<WalletIdentityNotFoundException>()),
      );

      final mockClientOnyOneNotFound = MockClient((req) async {
        if (req.url.path.contains(recipientDids.last)) {
          Response(getWalletIdentityResponse, 200);
        }

        return Response('', 404);
      });

      expect(
        () => CommercioDocHelper.fromWallet(
          wallet: wallet,
          recipients: recipientDids,
          id: uuid,
          metadata: metadata,
          contentUri: 'contentUri',
          encryptedData: {CommercioEncryptedData.CONTENT_URI},
          client: mockClientOnyOneNotFound,
        ),
        throwsA(isA<WalletIdentityNotFoundException>()),
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
