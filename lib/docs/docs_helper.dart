import 'package:commerciosdk/docs/commercio_doc_receipt_helper.dart';
import 'package:commerciosdk/export.dart';
import 'package:http/http.dart' as http;

import 'package:commerciosdk/entities/docs/legacy/21/legacy.dart' as legacy;

class DocsHelper {
  /// Creates a new transaction that allows to share the document associated
  /// with the given [metadata] and having the optional [contentUri], [doSign],
  /// [checksum], [fee] and broadcasting [mode]. If [encryptedData] is
  /// specified then encrypts the proper data for the specified [recipients]
  /// and then sends the transaction to the blockchain.
  ///
  /// If [doSign] is specified then the field [checksum] must be also provided.
  static Future<TransactionResult> shareDocument({
    required String id,
    required CommercioDocMetadata metadata,
    required List<String> recipients,
    required Wallet wallet,
    String? contentUri,
    CommercioDoSign? doSign,
    CommercioDocChecksum? checksum,
    Uint8List? aesKey,
    Set<CommercioEncryptedData>? encryptedData,
    StdFee? fee,
    BroadcastingMode? mode,
    http.Client? client,
  }) async {
    // Build a generic document
    final commercioDoc = await CommercioDocHelper.fromWallet(
      wallet: wallet,
      recipients: recipients,
      id: id,
      metadata: metadata,
      checksum: checksum,
      contentUri: contentUri,
      doSign: doSign,
      encryptedData: encryptedData,
      aesKey: aesKey,
    );
    StdMsg msg = MsgShareDocument(document: commercioDoc);

    final isLegacy21Chain = await wallet.networkInfo.isVersion(version: '2.1');

    if (isLegacy21Chain) {
      // Convert the new CommercioDoc entity to the old format
      final legacy21Doc = legacy.CommercioDocMapper.toLegacy(commercioDoc);

      // Replace the msg with the newer document with the legacy one
      msg = legacy.MsgShareDocument(document: legacy21Doc);
    }

    // Build, sign and send the tx message
    return TxHelper.createSignAndSendTx(
      [msg],
      wallet,
      fee: fee,
      mode: mode,
      client: client,
    );
  }

  /// Create a new transaction that allows to share a list of previously
  /// generated documents [commercioDocsList] signing with [wallet].
  /// Optionally [fee] and broadcasting [mode] parameters can be specified.
  static Future<TransactionResult> shareDocumentsList(
    List<CommercioDoc> commercioDocsList,
    Wallet wallet, {
    StdFee? fee,
    BroadcastingMode? mode,
    http.Client? client,
  }) async {
    List<StdMsg> msgs;

    final isLegacy21Chain = await wallet.networkInfo.isVersion(version: '2.1');

    if (isLegacy21Chain) {
      msgs = commercioDocsList.map((commercioDoc) {
        // Convert the new CommercioDoc entity to the old format
        final legacy21Doc = legacy.CommercioDocMapper.toLegacy(commercioDoc);

        // Replace the msg with the newer document with the legacy one
        return legacy.MsgShareDocument(document: legacy21Doc);
      }).toList();
    } else {
      msgs = commercioDocsList
          .map((commercioDoc) => MsgShareDocument(document: commercioDoc))
          .toList();
    }

    return TxHelper.createSignAndSendTx(
      msgs,
      wallet,
      fee: fee,
      mode: mode,
      client: client,
    );
  }

  /// Returns the list of all the [CommercioDoc] that the specified [address]
  /// has sent.
  static Future<List<CommercioDoc>> getSentDocuments({
    required String address,
    required NetworkInfo networkInfo,
    http.Client? client,
  }) async {
    final url = Uri.parse('${networkInfo.lcdUrl}/docs/$address/sent');
    final response = await Network.queryChain(url, client: client) as List;

    return response.map((json) => CommercioDoc.fromJson(json)).toList();
  }

  /// Returns the list of all the [CommercioDoc] that the specified [address]
  /// has been received.
  static Future<List<CommercioDoc>> getReceivedDocuments({
    required String address,
    required NetworkInfo networkInfo,
    http.Client? client,
  }) async {
    final url = Uri.parse('${networkInfo.lcdUrl}/docs/$address/received');
    final response = await Network.queryChain(url, client: client) as List;

    return response.map((json) => CommercioDoc.fromJson(json)).toList();
  }

  /// Creates a new transaction which tells the [recipient] that the document
  /// having the specified [documentId] and present inside the transaction
  /// with [txHash] has been properly seen; optionally [proof] of reading,
  /// [fee] and broadcasting [mode].
  static Future<TransactionResult> sendDocumentReceipt({
    required String recipient,
    required String txHash,
    required String documentId,
    required Wallet wallet,
    String? proof,
    StdFee? fee,
    BroadcastingMode? mode,
    http.Client? client,
  }) async {
    final commercioDocReceipt = CommercioDocReceiptHelper.fromWallet(
      wallet: wallet,
      recipient: recipient,
      txHash: txHash,
      documentId: documentId,
      proof: proof,
    );
    StdMsg msg = MsgSendDocumentReceipt(receipt: commercioDocReceipt);

    final isLegacy21Chain = await wallet.networkInfo.isVersion(version: '2.1');

    if (isLegacy21Chain) {
      // Convert the new CommercioDocReceipt entity to the old format
      final legacy21Receipt =
          legacy.CommercioDocReceiptMapper.toLegacy(commercioDocReceipt);

      // Replace the msg with the newer document with the legacy one
      msg = legacy.MsgSendDocumentReceipt(receipt: legacy21Receipt);
    }

    return TxHelper.createSignAndSendTx(
      [msg],
      wallet,
      fee: fee,
      mode: mode,
      client: client,
    );
  }

  /// Creates a new transaction which sends
  /// a list of previously generated receipts [commercioDocReceiptsList].
  /// Optionally [fee] and broadcasting [mode] parameters can be specified.
  static Future<TransactionResult> sendDocumentReceiptsList(
    List<CommercioDocReceipt> commercioDocReceiptsList,
    Wallet wallet, {
    StdFee? fee,
    BroadcastingMode? mode,
    http.Client? client,
  }) async {
    List<StdMsg> msgs;

    final isLegacy21Chain = await wallet.networkInfo.isVersion(version: '2.1');

    if (isLegacy21Chain) {
      msgs = commercioDocReceiptsList.map((docReceipt) {
        // Convert the new CommercioDocReceipt entity to the old format
        final legacy21Receipt =
            legacy.CommercioDocReceiptMapper.toLegacy(docReceipt);

        // Replace the msg with the newer document with the legacy one
        return legacy.MsgSendDocumentReceipt(receipt: legacy21Receipt);
      }).toList();
    } else {
      msgs = commercioDocReceiptsList
          .map((commercioDocReceipt) =>
              MsgSendDocumentReceipt(receipt: commercioDocReceipt))
          .toList();
    }

    return TxHelper.createSignAndSendTx(
      msgs,
      wallet,
      fee: fee,
      mode: mode,
      client: client,
    );
  }

  /// Returns the list of all the [CommercioDocReceipt] that
  /// have been sent from the given [address].
  static Future<List<CommercioDocReceipt>> getSentReceipts({
    required String address,
    required NetworkInfo networkInfo,
    http.Client? client,
  }) async {
    final url = Uri.parse('${networkInfo.lcdUrl}/receipts/$address/sent');
    final response = await Network.queryChain(url, client: client) as List;

    return response.map((json) => CommercioDocReceipt.fromJson(json)).toList();
  }

  /// Returns the list of all the [CommercioDocReceipt] that
  /// have been received from the given [address].
  static Future<List<CommercioDocReceipt>> getReceivedReceipts({
    required String address,
    required NetworkInfo networkInfo,
    http.Client? client,
  }) async {
    final url = Uri.parse('${networkInfo.lcdUrl}/receipts/$address/received');
    final response = await Network.queryChain(url, client: client) as List;

    return response.map((json) => CommercioDocReceipt.fromJson(json)).toList();
  }
}
