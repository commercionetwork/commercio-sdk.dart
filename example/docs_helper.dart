import 'package:commerciosdk/export.dart';
import 'package:uuid/uuid.dart';

import 'commons.dart';

final userMnemonic = [
  'will',
  'hard',
  'topic',
  'spray',
  'beyond',
  'ostrich',
  'moral',
  'morning',
  'gas',
  'loyal',
  'couch',
  'horn',
  'boss',
  'across',
  'age',
  'post',
  'october',
  'blur',
  'piece',
  'wheel',
  'film',
  'notable',
  'word',
  'man'
];

final recipientMnemonic = [
  'crisp',
  'become',
  'thumb',
  'fetch',
  'forest',
  'senior',
  'polar',
  'slush',
  'wise',
  'wash',
  'doctor',
  'sunset',
  'skate',
  'disease',
  'power',
  'tool',
  'sock',
  'upper',
  'diary',
  'what',
  'trap',
  'artist',
  'wood',
  'cereal'
];

void main() async {
  final networkInfo = NetworkInfo(
    bech32Hrp: 'did:com:',
    lcdUrl: 'http://localhost:1317',
  );

  final userWallet = Wallet.derive(userMnemonic, networkInfo);
  final recipientWallet = Wallet.derive(recipientMnemonic, networkInfo);

  // --- Share a document
  final docRecipientDid = recipientWallet.bech32Address;
  final shareDocResult = await _shareDoc([docRecipientDid], userWallet);

  // --- Share receipt
  final receiptRecipientDid = userWallet.bech32Address;
  await _sendReceipt(shareDocResult.docId, shareDocResult.hash,
      receiptRecipientDid, recipientWallet);
}

/// Helper class used store the DidDocument identifier and transaction hash.
class ShareDocResult {
  final String docId;
  final String hash;

  ShareDocResult(this.docId, this.hash);
}

/// Shows how to share a document to the given recipients.
/// Documentation: https://docs.commercio.network/x/docs/tx/send-document.html
Future<ShareDocResult> _shareDoc(
  List<String> recipients,
  Wallet wallet,
) async {
  final docId = new Uuid().v4();

  final response = await DocsHelper.shareDocument(
    id: docId,
    contentUri: 'https://example.com/document',
    metadata: CommercioDocMetadata(
      contentUri: 'https://example.com/document/metadata',
      schema: CommercioDocMetadataSchema(
        uri: 'https://example.com/custom/metadata/schema',
        version: '1.0.0',
      ),
    ),
    recipients: recipients,
    wallet: wallet,
  );

  checkResponse(response);

  return ShareDocResult(docId, response.hash);
}

/// Shows how to send a document receipt to the specified [recipient] for
/// the given [docId] present inside the transaction having the given [txHash].
Future<void> _sendReceipt(
  String docId,
  String txHash,
  String recipient,
  Wallet wallet,
) async {
  final response = await DocsHelper.sendDocumentReceipt(
    recipient: recipient,
    txHash: txHash,
    documentId: docId,
    wallet: wallet,
  );

  checkResponse(response);
}
