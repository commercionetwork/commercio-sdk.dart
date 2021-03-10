import 'package:commerciosdk/export.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Functions of "CommercioDoReceiptHelper" class;', () {
    final networkInfo = NetworkInfo(
      bech32Hrp: 'did:com:',
      lcdUrl: Uri.parse(''),
    );
    const mnemonicString =
        'dash ordinary anxiety zone slot rail flavor tortoise guilt divert pet sound ostrich increase resist short ship lift town ice split payment round apology';
    final mnemonic = mnemonicString.split(' ');
    final wallet = Wallet.derive(mnemonic, networkInfo);

    final uuid = Uuid().v4();
    const recipientDid = 'did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau';
    const txHash = 'txHash';
    final documentId = Uuid().v4();

    test('"fromWallet()" returns a well-formed "CommercioDocReceipt" object.',
        () {
      final expectedDocReceipt = CommercioDocReceipt(
        uuid: uuid,
        senderDid: wallet.bech32Address,
        recipientDid: recipientDid,
        txHash: txHash,
        documentUuid: documentId,
      );

      final commercioDocReceipt = CommercioDocReceiptHelper.fromWallet(
        wallet: wallet,
        recipient: recipientDid,
        txHash: txHash,
        documentId: documentId,
      );

      expect(commercioDocReceipt.uuid, isNot(expectedDocReceipt.uuid));
      expect(commercioDocReceipt.senderDid, expectedDocReceipt.senderDid);
      expect(commercioDocReceipt.recipientDid, expectedDocReceipt.recipientDid);
      expect(commercioDocReceipt.txHash, expectedDocReceipt.txHash);
      expect(commercioDocReceipt.documentUuid, expectedDocReceipt.documentUuid);
      expect(commercioDocReceipt.proof, isNull);
    });

    test('Invalid sender bech32 format should throw an assertion error', () {
      expect(
        () => CommercioDocReceiptHelper.fromWallet(
          wallet: wallet,
          recipient: 'invalid bech32',
          txHash: txHash,
          documentId: documentId,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test(
        'Invalid document uuid (not v4) format should throw an assertion error',
        () {
      expect(
        () => CommercioDocReceiptHelper.fromWallet(
          wallet: wallet,
          recipient: recipientDid,
          txHash: txHash,
          documentId: 'doc invalid uuid',
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
