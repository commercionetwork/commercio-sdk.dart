import 'package:commerciosdk/export.dart';
import 'package:uuid/uuid.dart';

import 'commons.dart';

void main() async {
  final info = NetworkInfo(
    bech32Hrp: "did:com:",
    lcdUrl: "http://localhost:1317",
  );

  final userMnemonic = [
    "will",
    "hard",
    "topic",
    "spray",
    "beyond",
    "ostrich",
    "moral",
    "morning",
    "gas",
    "loyal",
    "couch",
    "horn",
    "boss",
    "across",
    "age",
    "post",
    "october",
    "blur",
    "piece",
    "wheel",
    "film",
    "notable",
    "word",
    "man"
  ];
  final userWallet = Wallet.derive(userMnemonic, info);

  final recipientMnemonic = [
    "crisp",
    "become",
    "thumb",
    "fetch",
    "forest",
    "senior",
    "polar",
    "slush",
    "wise",
    "wash",
    "doctor",
    "sunset",
    "skate",
    "disease",
    "power",
    "tool",
    "sock",
    "upper",
    "diary",
    "what",
    "trap",
    "artist",
    "wood",
    "cereal"
  ];
  final recipientWallet = Wallet.derive(recipientMnemonic, info);

  // --- Share a document
  final docRecipientDid = recipientWallet.bech32Address;
  // final pair = await _shareDoc([docRecipientDid], userWallet);

  // --- Share receipt
  final receiptRecipientDid = userWallet.bech32Address;
  // await _sendReceipt(pair.first, pair.second, receiptRecipientDid, recipientWallet);
}

class Pair<F, S> {
  final F first;
  final S second;

  Pair(this.first, this.second);
}

/// Shows how to share a document to the given recipients.
/// Documentation: https://docs.commercio.network/x/docs/tx/send-document.html
Future<Pair<String, String>> _shareDoc(
  List<String> recipients,
  Wallet wallet,
) async {
  final docId = new Uuid().v4();
  final response = await DocsHelper.shareDocument(
    id: docId,
    contentUri: "https://example.com/document",
    metadata: CommercioDocMetadata(
      contentUri: "https://example.com/document/metadata",
      schema: CommercioDocMetadataSchema(
        uri: "https://example.com/custom/metadata/schema",
        version: "1.0.0",
      ),
    ),
    recipients: recipients,
    wallet: wallet,
  );
  checkResponse(response);
  return Pair(docId, response.hash);
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
